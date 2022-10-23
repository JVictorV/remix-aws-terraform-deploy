resource "aws_acm_certificate" "wildcard_certificate" {
  domain_name               = var.base_url
  subject_alternative_names = ["*.${var.base_url}"]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.wildcard_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_record : record.fqdn]
}

