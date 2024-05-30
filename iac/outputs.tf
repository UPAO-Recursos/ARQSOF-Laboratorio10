output "aws_lambda_function" {
  value = data.archive_file.lambda.output_path
}
