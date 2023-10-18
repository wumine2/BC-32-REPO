module "vpc" {
  source = "../vpc"
}

# Ec2 instance Configuration.
resource "aws_instance" "test_ec2" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = var.my_instance_type["prod"]
  subnet_id     = data.terraform_remote_state.vpc_storage.outputs.public_subnets[0]
  key_name      = "BC_Key"
  metadata_options {
    http_endpoint = "disabled"
  }
  monitoring    = true
  ebs_optimized = true

  tags = {
    Name = var.my_instance_name
  }
}

resource "aws_launch_configuration" "example" {
  name          = "launch-config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  root_block_device {
    encrypted = true
  }
}


