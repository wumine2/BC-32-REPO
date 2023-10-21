terraform {
  backend "s3" {
    bucket  = "bootcamp32-prod-2"
    region  = "us-west-2"
    key     = "vpc/terraform.tfstate"
    encrypt = true
  }
}

