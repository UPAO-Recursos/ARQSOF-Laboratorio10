# API Gateway
resource "aws_api_gateway_rest_api" "myapi" {
  name        = "MyAPI"
  description = "My API Gateway"
}

resource "aws_api_gateway_resource" "myresource" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id
  path_part   = "test"
}

resource "aws_api_gateway_method" "mymethod" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.myresource.id
  http_method   = "GET"
  authorization = "NONE"
}


resource "aws_api_gateway_deployment" "mydeployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  stage_name  = "dev"
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "test"
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  deployment_id = aws_api_gateway_deployment.mydeployment.id
  description   = "Development stage"
  variables = {
    key = "value"
  }
}
