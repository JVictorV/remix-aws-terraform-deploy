resource "aws_lambda_function" "bff_server_lambda" {
  function_name = "bff_lambda"
  role          = aws_iam_role.lambda.arn

  filename         = data.archive_file.server_zip.output_path
  handler          = "index.handler"
  source_code_hash = filebase64sha256(data.archive_file.server_zip.output_path)

  runtime = "nodejs16.x"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.bff_server_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda_gateway.execution_arn}/*/*/*"
}
