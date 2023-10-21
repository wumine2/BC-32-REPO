terraform {
  backend "s3" {
    bucket  = "bootcamp32-prod-1"
    region  = "us-west-2"
    key     = "vpc_c/terraform.tfstate"
    encrypt = true
  }
}

