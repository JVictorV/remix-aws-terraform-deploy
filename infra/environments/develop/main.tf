terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  backend "s3" {
    bucket = "remix-aws-terraform"
    region = "us-east-1"
    key    = "terraform-develop.tfstate"
  }
}


provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner       = "Terraform"
      Environment = "development"
    }
  }
}

module "development" {
  source = "../../modules/app"

  environment = "development"
}

output "app_url" {
  value = module.development.app_url
}
