data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_role" "iam_for_lambda" {
  name               = "development_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "hello" {
  type        = "zip"
  source_dir  = "../src/hello"
  output_path = "bin/hello.zip"
}

resource "aws_lambda_function" "lambda_main" {
  filename      = data.archive_file.hello.output_path
  function_name = "Laboratorio10"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main.handler"

  source_code_hash = data.archive_file.hello.output_base64sha256

  runtime = "nodejs18.x"

  environment {
    variables = {
      "key" = "value"
    }
  }
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.myresource.id
  http_method             = aws_api_gateway_method.mymethod.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_main.invoke_arn
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_main.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.myapi.execution_arn}/*/*"
}
