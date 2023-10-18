variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
  default     = ["us-west-2a", "us-west-2b"]
}

variable "private_cidr" {
  type        = list(string)
  description = "Private subnet cidr"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_cidr" {
  type        = list(string)
  description = "Public subnet cidr"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]

}