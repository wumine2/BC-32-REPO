terraform {
  backend "s3" {
    bucket  = "bootcamp32-prod-2"
    region  = "us-west-2"
    key     = "oidc/terraform.tfstate"
    encrypt = true
  }
}

