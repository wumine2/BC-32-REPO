provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      Project   = "vpc-demo-argoCd"
      ManagedBy = "terraform"
    }
  }
}


