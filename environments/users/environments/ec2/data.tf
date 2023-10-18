data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]

  }
}


data "terraform_remote_state" "vpc_storage" {
  backend = "s3"
  config = {
    bucket = "bootcamp32-prod-1"
    region = "us-west-2"
    key    = "vpc/terraform.tfstate"
  }
}


# Declare aws_ami data resource to fetch the desired AMI ID
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"] # Replace with appropriate owner IDs if needed
}




   