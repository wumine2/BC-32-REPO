module "s3" {
  source = "git@github.com:wumine2/s3-repo.git//s3-module?ref=v1.2.4"
}

#Backend configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "bootcamp32-prod-2"
    region  = "us-west-2"
    key     = "s3/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "us-west-2"
} 
