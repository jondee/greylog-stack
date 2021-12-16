
variable "env" {
  type        = string
  description = "env added to names/tags of all resources"
}

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