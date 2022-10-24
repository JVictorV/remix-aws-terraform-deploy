output "server_zip" {
  value = data.archive_file.server_zip.output_path
}

output "main_zone" {
  value = data.aws_route53_zone.main_zone.name
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "apigw_url" {
  value = aws_apigatewayv2_stage.prod_stage.invoke_url
}

output "app_url" {
  value = aws_route53_record.app_record.name
}

output "region" {
  value = data.aws_region.current.name
}
