variable "allocated_storage" {
  type        = number
  description = "The allocated storage in gibibytes"
  default     = 50
}

variable "max_allocated_storage" {
  type        = number
  description = "The maximum allocatatable storage in gibibytes"
  default     = 100
}

variable "deletion_protection" {
  type        = bool
  description = "Determines if deletion protection should be enable for the DB instance"
  default     = false
}

variable "replicate_source_db" {
  type        = string
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database"
  default     = null
}

variable "storage_type" {
  type        = string
  description = "The default is io1 if iops is specified, gp2 if not"
  default     = "gp2"
}

variable "engine" {
  type        = string
  description = "The database engine to use"
}

variable "engine_version" {
  type        = string
  description = "The engine version to use"
}

variable "instance_class" {
  type        = string
  description = "The instance type of the RDS instance"
  default     = "db.t2.micro"
}

variable "db_name" {
  type        = string
  description = "The name of the database to create when the DB instance is created"
}

variable "identifier" {
  type        = string
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
}

variable "username" {
  type        = string
  description = "Username for the master DB user"
}

variable "password" {
  type        = string
  description = "Password for the master DB user"
  sensitive   = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  default     = true
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB instance is encrypted"
  default     = true
}

variable "multi_az" {
  type        = bool
  description = "If the RDS instance is multi AZ enabled"
  default     = true
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the DB parameter group to associate"
  default     = ""
}

variable "port" {
  type        = string
  description = "The port on which the DB accepts connections."
}

variable "license_model" {
  type        = string
  description = "(Optional, but required for some DB engines, i.e. Oracle SE1) License model information for this DB instance."
  default     = null
}

variable "publicly_accessible" {
  type        = bool
  description = "Bool to control if instance is publicly accessible. Default is false"
  default     = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnets that will be used to create the DB subnet group"
}

variable "env" {
  type = string
}

variable "backup_retention_period" {
  type        = number
  default     = null
  description = "The days to retain backups for"
}

variable "list_of_security_groups" {
  description = "List of Security groups to allow access to database instance"
  type        = list(string)
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to create the Security group in"
}