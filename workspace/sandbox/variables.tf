
# General
variable "aws_region" {
  type = string
  description = "Region to deploy resouces in"
  default = "us-east-1"
}
variable "env" {
  type        = string
  description = "env added to names/tags of all resources"
}


# Networking
variable "cidr" {
  type        = string
  description = "Cidr block for the VPC"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Cidr for the private subnet"
  default     = []
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Cidr for the public subnet"
  default     = []
}