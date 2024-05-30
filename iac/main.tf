provider "aws" {
  region      = "us-east-2"
  profile     = var.aws_role[local.env_name]
  max_retries = 2

  default_tags {
    tags = var.tags[local.env_name]
  }
}
