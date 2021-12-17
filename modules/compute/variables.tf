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

variable "ip_list_for_bastion_access" {
  type        = list(string)
  description = "List of IP's to allow ssh access to the bastion"
}
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

variable "db_endpoint" {
  type        = string
  description = "The endpoint of the RDS instance"
}

variable "db_port" {
  type        = number
  description = "The port of the RDS instance"
  default     = 5432
}

variable "db_name" {
  type        = string
  description = "The name of the database to connect to"
  default     = "greylog"
}

variable "db_username" {
  type        = string
  description = "Username for the DB"
  default     = "greylog"
}

variable "db_password" {
  type        = string
  description = "Password for the DB"
  sensitive   = true
}