
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

  env                   = var.env
  hosted_zone_name      = var.hosted_zone_name
  ip_list_for_lb_access = var.ip_list_for_lb_access
  vpc_id                = module.networking.vpc_id
  public_subnets_ids    = module.networking.public_subnet_ids
  private_subnets_ids   = module.networking.private_subnet_ids
}