terraform {
  backend "s3" {
    bucket  = "bootcamp32-prod-1"
    region  = "us-west-2"
    key     = "vpc/terraform.tfstate"
    encrypt = true
  }
}

# This is the backend configuration. */