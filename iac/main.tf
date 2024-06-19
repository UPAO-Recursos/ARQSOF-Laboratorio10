provider "aws" {
  region      = "us-east-2"
  access_key  = env.aws_access_key
  secret_key  = env.aws_secret_key
  max_retries = 2

  default_tags {
    tags = var.tags[local.env_name]
  }
}