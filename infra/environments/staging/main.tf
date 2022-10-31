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
    key    = "terraform-staging.tfstate"
  }
}


provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner       = "Terraform"
      Environment = "staging"
    }
  }
}

module "staging" {
  source = "../../modules/app"

  environment = "staging"
}

output "app_url" {
  value = module.staging.app_url
}
