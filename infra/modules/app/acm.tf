data "aws_acm_certificate" "wildcard_certificate" {
  domain = var.base_url
}
