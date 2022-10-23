data "aws_route53_zone" "main_zone" {
  name         = var.base_url
  private_zone = false
}


resource "aws_route53_record" "certificate_record" {
  for_each = {
    for dvo in aws_acm_certificate.wildcard_certificate.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = data.aws_route53_zone.main_zone.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_route53_record" "production_record" {
  name    = aws_apigatewayv2_domain_name.lambda_gateway_domain_name.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.main_zone.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_apigatewayv2_domain_name.lambda_gateway_domain_name.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.lambda_gateway_domain_name.domain_name_configuration[0].hosted_zone_id
  }
}
