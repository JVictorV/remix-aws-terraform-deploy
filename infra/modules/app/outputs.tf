output "bff_lambda" {
  value = aws_lambda_function.bff_server_lambda.function_name
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "app_url" {
  value = "https://${aws_route53_record.app_record.name}"
}
