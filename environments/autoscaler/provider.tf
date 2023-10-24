# Terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider block

provider "aws" {
  region  = "us-west-2"
}


data "terraform_remote_state" "network" {
 backend = "s3"
  config = {
    bucket = "bootcamp32-prod-2"
    region = "us-west-2"
    key    = "oidc/terraform.tfstate"   
 }
}



