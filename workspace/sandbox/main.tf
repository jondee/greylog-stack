
# Networking module
module "networking" {
  source = "../../modules/networking"

  env                  = var.env
  cidr                 = var.cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

# Compute module
module "compute" {
  source = "../../modules/compute"

  env                        = var.env
  hosted_zone_name           = var.hosted_zone_name
  ip_list_for_lb_access      = var.ip_list_for_lb_access
  vpc_id                     = module.networking.vpc_id
  public_subnets_ids         = module.networking.public_subnet_ids
  private_subnets_ids        = module.networking.private_subnet_ids
  ip_list_for_bastion_access = var.ip_list_for_bastion_access
  # DB config
  db_endpoint = module.postgresql.db_endpoint
  db_password = var.postgresql_password
}

module "postgresql" {
  source = "../../modules/database"

  backup_retention_period = var.postgresql_backup_retention_period
  replicate_source_db     = var.postgresql_replicate_source_db
  env                     = var.env
  allocated_storage       = var.postgresql_allocated_storage
  subnet_ids              = module.networking.private_subnet_ids
  engine                  = var.postgresql_engine
  engine_version          = var.postgresql_engine_version
  instance_class          = var.postgresql_instance_class
  port                    = var.postgresql_port
  db_name                 = var.postgresql_db_name
  identifier              = "${var.env}-postgresql"
  username                = var.postgresql_username
  password                = var.postgresql_password
  multi_az                = var.postgresql_multi_az
  storage_encrypted       = var.postgresql_storage_encrypted
  parameter_group_name    = var.postgresql_parameter_group_name
  list_of_security_groups = [module.compute.compute_sg_id, module.compute.bastion_sg_id]
  vpc_id                  = module.networking.vpc_id

}
