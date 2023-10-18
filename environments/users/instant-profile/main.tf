#Declaring the AWS Provider
provider "aws" {
  region = "us-west-2"
}

# Role
resource "aws_iam_role" "instance_role" {
  name = "my-test-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_instance_profile" "test-profile" {
  name = "test_profile"
  role = aws_iam_role.instance_role.name
}


resource "aws_iam_policy" "policy" {
  name        = "iam-policy-for-instance-role"
  description = "iam-policy-for-instance-role"

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = [
          "s3:Get*",
          "s3:List*",
          "ec2:*",
          "SNS:List*",
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role = aws_iam_role.instance_role.name
  policy_arn =  aws_iam_policy.policy.arn
}


data "aws_ami" "ubuntu" {
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


resource "aws_instance" "web" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    iam_instance_profile = aws_iam_instance_profile.test-profile.id
    key_name = "BC_Key"
    

    tags = {
      Name = "Test_Instance_profile"
    }
  
}