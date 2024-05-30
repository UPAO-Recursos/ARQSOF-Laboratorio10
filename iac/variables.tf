variable "tags" {}
variable "aws_role" {
  description = "AWS Role"
  type        = map(string)
}

locals {
  env_name = lower(terraform.workspace)
}
