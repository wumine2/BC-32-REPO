provider "aws" {
  region = "us-west-2"
  tags = {
      Project   = "vpc-demo-argoCd"
      ManagedBy = "terraform"
}
}
