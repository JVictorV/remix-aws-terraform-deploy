data "aws_route53_zone" "main_zone" {
  name         = var.base_url
  private_zone = false
}

resource "aws_route53_record" "app_record" {
  name    = "${var.environment}.${data.aws_route53_zone.main_zone.name}"
  type    = "A"
  zone_id = data.aws_route53_zone.main_zone.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.frontend_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.frontend_distribution.hosted_zone_id
  }
}

