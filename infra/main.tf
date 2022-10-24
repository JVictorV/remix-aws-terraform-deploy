provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner = "Terraform"
    }
  }
}

data "aws_region" "current" {}
