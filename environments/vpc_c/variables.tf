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
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
}

variable "public_cidr" {
  type        = list(string)
  description = "Public subnet cidr"
  default     = ["10.0.64.0/19", "10.0.96.0/19"]

}