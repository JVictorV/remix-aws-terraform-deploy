resource "aws_lambda_function" "bff_server_lambda" {
  function_name = "bff_lambda"
  role          = aws_iam_role.lambda.arn

  filename         = data.archive_file.server_zip.output_path
  handler          = "index.handler"
  source_code_hash = filebase64sha256(data.archive_file.server_zip.output_path)

  runtime = "nodejs16.x"
}

resource "aws_lambda_function_url" "bff_url" {
  authorization_type = "NONE"
  function_name      = aws_lambda_function.bff_server_lambda.function_name
}
