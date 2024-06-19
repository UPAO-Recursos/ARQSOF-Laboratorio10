variable "tags" {}
variable "aws_role" {
  description = "AWS Role"
  type        = map(string)
}

locals {
  env_name = lower(terraform.workspace)
}

variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
}