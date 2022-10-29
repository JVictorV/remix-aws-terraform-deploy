data "aws_route53_zone" "main_zone" {
  name         = var.base_url
  private_zone = false
}

resource "aws_route53_record" "certificate_record" {
  for_each = {
    for dvo in aws_acm_certificate.wildcard_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main_zone.zone_id
}

