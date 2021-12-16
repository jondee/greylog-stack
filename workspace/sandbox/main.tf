
# Networking module
module "networking" {
  source = "../../modules/networking"

  env                  = var.env
  cidr                 = var.cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}