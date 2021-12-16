# Variables for AWS compute module

variable "env" {
  type        = string
  description = "Env added to names of all resources"
}

variable "instance_type" {
  type        = string
  description = "Instance type used for all EC2 instances"
  default     = "t2.micro"
}

variable "private_subnets_ids" {
  type        = list(string)
  description = "List of private subnet ID's"
}

variable "public_subnets_ids" {
  type        = list(string)
  description = "List of public subnet ID's"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Decides if deletion protection should be enabled for the loadbalancer"
  default     = false
}
variable "vpc_id" {
  type        = string
  description = "VPC id to deplpy resources in"
}

variable "ip_list_for_lb_access" {
  type        = list(string)
  description = "List of IP's to allow into the worker LB"
}

variable "hosted_zone_name" {
  type        = string
  description = "The host zone name in AWS to create a record for this rancher server"
}

# variable "public_rta" {}
# variable "private_rta" {}

# ASG vars
variable "asg_min_size" {
  type        = number
  description = "(optional) Min size for the auto scaling group"
  default     = 1
}

variable "asg_health_check_grace_period" {
  type        = number
  description = "(optional) The amount of time until EC2 Auto Scaling performs the first health check on new instances after they are put into service."
  default     = 180
}
variable "asg_max_size" {
  type        = number
  description = "(optional) Max size for the auto scaling group"
  default     = 3
}

variable "asg_desired_size" {
  type        = number
  description = "(optional) Desired size for the auto scaling group"
  default     = 2
}
