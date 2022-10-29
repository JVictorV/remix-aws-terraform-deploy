resource "aws_lambda_function" "bff_server_lambda" {
  function_name = "${var.environment}-bff-lambda"
  runtime       = "nodejs16.x"

  filename         = data.archive_file.server_zip.output_path
  handler          = "index.handler"
  source_code_hash = filebase64sha256(data.archive_file.server_zip.output_path)

  role          = aws_iam_role.lambda.arn
  architectures = ["arm64"]
}

resource "aws_lambda_function_url" "bff_url" {
  authorization_type = "NONE"
  function_name      = aws_lambda_function.bff_server_lambda.function_name
}
