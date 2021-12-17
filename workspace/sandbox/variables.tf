
# General
variable "aws_region" {
  type        = string
  description = "Region to deploy resouces in"
  default     = "us-east-1"
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



# Compute module variables

variable "ip_list_for_lb_access" {
  type        = list(string)
  description = "List of IP's to allow into the worker LB"
}

variable "ip_list_for_bastion_access" {
  type        = list(string)
  description = "List of IP's to allow ssh access to the bastion"
}
variable "hosted_zone_name" {
  type        = string
  description = "The host zone name in AWS to create a record for this rancher server"
}


# POSTGRES VARS
variable "postgresql_engine" {
  type        = string
  description = "The database engine to use"
  default     = null
}

variable "postgresql_engine_version" {
  type        = string
  description = "The host zone name in AWS to create a record for this rancher server"
}

variable "postgresql_instance_class" {
  type        = string
  description = "The RDS instance class"
}

variable "postgresql_db_name" {
  type        = string
  description = "The name of the database to create when the DB instance is created"
}

variable "postgresql_username" {
  type        = string
  description = "The master username for the database"
}

variable "postgresql_password" {
  type        = string
  description = "Password for the master DB user"
  sensitive   = true
}

variable "postgresql_multi_az" {
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ"
}

variable "postgresql_parameter_group_name" {
  type        = string
  description = "Name of the DB parameter group to associate"
}

variable "postgresql_storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB instance is encrypted"
  default     = false
}

variable "postgres_db_enabled" {
  type        = bool
  default     = false
  description = "deploy the postgres db or not"
}

variable "postgresql_backup_retention_period" {
  type        = number
  default     = 30
  description = "The days to retain backups for"
}

variable "postgresql_replicate_source_db" {
  type        = string
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database"
  default     = null
}

variable "postgresql_allocated_storage" {
  type        = number
  description = "The allocated storage in gibibytes"
  default     = 50
}

variable "postgresql_max_allocated_storage" {
  type        = number
  description = "The maximum allocatatable storage in gibibytes"
  default     = 100
}

variable "postgresql_port" {
  type        = string
  description = "The port on which the DB accepts connections."
  default     = "5432"
}