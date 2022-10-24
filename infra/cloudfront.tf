locals {
  s3_origin_id    = aws_s3_bucket.default.id
  apigw_origin_id = aws_apigatewayv2_api.lambda_gateway.id
  prod_url        = "prod.${data.aws_route53_zone.main_zone.name}"
}


resource "aws_cloudfront_origin_access_identity" "OAI" {}

resource "aws_cloudfront_distribution" "frontend_distribution" {
  enabled     = true
  price_class = "PriceClass_All"
  aliases     = [local.prod_url]

  origin {
    origin_id   = local.s3_origin_id
    domain_name = aws_s3_bucket.default.bucket_regional_domain_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.OAI.cloudfront_access_identity_path
    }
  }

  origin {
    origin_id   = local.apigw_origin_id
    domain_name = "${aws_apigatewayv2_stage.prod_stage.api_id}.execute-api.${data.aws_region.current.id}.amazonaws.com"
    origin_path = "/${aws_apigatewayv2_stage.prod_stage.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.apigw_origin_id

    default_ttl = 0
    min_ttl     = 0
    max_ttl     = 0

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    target_origin_id = local.s3_origin_id
    path_pattern     = "/static/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
    compress    = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.wildcard_certificate.arn
    ssl_support_method  = "sni-only"
  }
}
