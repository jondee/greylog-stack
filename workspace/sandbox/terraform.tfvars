# General
aws_region = "us-east-2"
env        = "sandbox"

# Network
cidr                 = "10.0.0.0/16"
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]


# Compute 
hosted_zone_name           = "greylog.com."
ip_list_for_lb_access      = ["0.0.0.0/0"]
ip_list_for_bastion_access = ["0.0.0.0/0"]


# PostgreSQL
postgresql_backup_retention_period = 2
postgresql_allocated_storage       = 50
postgresql_engine                  = "postgres"
postgresql_engine_version          = "12.7"
postgresql_instance_class          = "db.t2.micro"
postgresql_db_name                 = "greylog"
postgresql_username                = "greylog"
postgresql_multi_az                = true
postgresql_port                    = 5432
postgresql_parameter_group_name    = "default.postgres12"
