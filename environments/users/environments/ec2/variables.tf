variable "us_region" {
  type    = string
  default = "us-east-1"
}

variable "my_instance_name" {
  type    = string
  default = "Demo_ec2"
}

variable "my_ami" {
  type    = string
  default = "ami-053b0d53c279acc90"
}

variable "my_instance_type" {
  type = map(any)
  default = {
    dev     = "t2.micro"
    staging = "t2.medium"
    prod    = "t2.large"
  }
}


