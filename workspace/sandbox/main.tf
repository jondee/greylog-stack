/**
* # Sandbox workspace
* This workspace is used to call the networking, compute and database module to create resources on AWS to host the php web application for the challenge from Greylog:
*
* ## Prerequisite
* Before you can run this terraform workspace, you will need the following below:
* - AWS account used to create the resources
* - IAM credentials will access to create resources, an Administrator role will be able to create the resources
* - AWS (CLI)[https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html] installed on your machine,.
* - Terraform (CLI)[https://learn.hashicorp.com/tutorials/terraform/install-cli] version >=0.14 installed on your machine.
* - A configured aws (named profile)[https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html], this is used to configure the provider in the `provider.tf` file.
* - A public AWS Route53 hosted zone (this is used to create a DNS record and request for a SSL certificate from AWS Certificate Manager to attach to the Loadbalancer)
*
* ## Modifying variables
* To modify modify a variable please set the values in the `terraform.tfvars` file, some of the variables have default values, so you do not have to configure all of them, and not all configurable variables are listed in the `terraform.tfvars` file, but if you want to configure a certiain variable of a resource in a module, then please create the variable in the `variables.tf` file, pass it to the module call in the `main.tf` file, then assign a value to that variable in the `terraform.tfvars` file.
*
* ## Setting secret values
* The `terraform.tfvars` file will be commited to git, and we do not want it to contain secret credentials, so in order to set secret values required, we will need to use environment variables.
* To configure a sensitive variable like the database password, run `export TF_VAR_postgresql_password="<password>"`, in the terminal you will be using to apply the terraform configuration
*
* ## Whitelisting loadbalancer and bastion host
* You can restric access to the Loadbalancer which forwards traffic to the web servers by setting the list of IP's that should have access in the 'ip_list_for_lb_access' variable, if you want to open it to the world then set that variable to ["0.0.0.0/0"]
* > Note: You can also restric access to the bastion host that is used to configure the database, make sure the IP of the machine you are running this configuration is listed in the `ip_list_for_bastion_access`, else terraform will fail, becuase the security group will not permit traffic, and the remote exec will fail.
*
* ## Running Terraform
* To apply this workspace, run:
* - `Terraform init` to initialize terraform
* - `Terraform plan` to view changes that the workspace will make
* - `Terraform apply -auto-approve` to apply the changes
*/



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
