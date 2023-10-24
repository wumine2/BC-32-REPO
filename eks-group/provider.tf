provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket  = "bootcamp32-prod-2"
    region  = "us-west-2"
    key     = "users/terraform.tfstate"
    encrypt = true
  }
}
