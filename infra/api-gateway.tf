locals {
  prod_url = "prod.${data.aws_route53_zone.main_zone.name}"
  dev_url  = "dev.${data.aws_route53_zone.main_zone.name}"
}

resource "aws_apigatewayv2_api" "lambda_gateway" {
  name          = "BFF Lambda Gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "prod_stage" {
  api_id      = aws_apigatewayv2_api.lambda_gateway.id
  name        = "production"
  auto_deploy = true
}

resource "aws_apigatewayv2_domain_name" "lambda_gateway_domain_name" {
  domain_name = local.prod_url

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.wildcard_certificate.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "lambda_gateway_mapping" {
  api_id      = aws_apigatewayv2_api.lambda_gateway.id
  domain_name = aws_apigatewayv2_domain_name.lambda_gateway_domain_name.id
  stage       = aws_apigatewayv2_stage.prod_stage.id
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id = aws_apigatewayv2_api.lambda_gateway.id

  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.bff_server_lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "lambda_route" {
  api_id    = aws_apigatewayv2_api.lambda_gateway.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}
