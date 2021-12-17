# Sandbox workspace
This workspace is used to call the networking, compute and database module to create resources on AWS to host the php web application for the challenge from Greylog:

## Prerequisite
Before you can run this terraform workspace, you will need the following below:
- AWS account used to create the resources
- IAM credentials will access to create resources, an Administrator role will be able to create the resources
- AWS [CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed on your machine,.
- Terraform [CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) version >=0.14 installed on your machine.
- A configured aws [named profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html), this is used to configure the provider in the `provider.tf` file.
- A public AWS Route53 hosted zone (this is used to create a DNS record and request for a SSL certificate from AWS Certificate Manager to attach to the Loadbalancer)

## Modifying variables
To modify modify a variable please set the values in the `terraform.tfvars` file, some of the variables have default values, so you do not have to configure all of them, and not all configurable variables are listed in the `terraform.tfvars` file, but if you want to configure a certiain variable of a resource in a module, then please create the variable in the `variables.tf` file, pass it to the module call in the `main.tf` file, then assign a value to that variable in the `terraform.tfvars` file.

## Setting secret values
The `terraform.tfvars` file will be commited to git, and we do not want it to contain secret credentials, so in order to set secret values required, we will need to use environment variables.
To configure a sensitive variable like the database password, run `export TF_VAR_postgresql_password="<password>"`, in the terminal you will be using to apply the terraform configuration

## Whitelisting loadbalancer and bastion host
You can restric access to the Loadbalancer which forwards traffic to the web servers by setting the list of IP's that should have access in the 'ip\_list\_for\_lb\_access' variable, if you want to open it to the world then set that variable to ["0.0.0.0/0"]
> Note: You can also restric access to the bastion host that is used to configure the database, make sure the IP of the machine you are running this configuration is listed in the `ip_list_for_bastion_access`, else terraform will fail, becuase the security group will not permit traffic, and the remote exec will fail.

## Running Terraform
To apply this workspace, run:
- Create a named aws profile called greylog: run `aws configure --profile greylog`, then fill in your access key and secret key
- Modify `terraform.tfvars`, the only variable you have to modify is the `hosted_zone_name`, the others can be left as-is.
- `Terraform init` to initialize terraform
- `Terraform plan` to view changes that the workspace will make
- `Terraform apply -auto-approve` to apply the changes

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.69.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.7.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute"></a> [compute](#module\_compute) | ../../modules/compute | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ../../modules/networking | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | ../../modules/database | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region to deploy resouces in | `string` | `"us-east-1"` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | Cidr block for the VPC | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | env added to names/tags of all resources | `string` | n/a | yes |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | The host zone name in AWS to create a record for this rancher server | `string` | n/a | yes |
| <a name="input_ip_list_for_bastion_access"></a> [ip\_list\_for\_bastion\_access](#input\_ip\_list\_for\_bastion\_access) | List of IP's to allow ssh access to the bastion | `list(string)` | n/a | yes |
| <a name="input_ip_list_for_lb_access"></a> [ip\_list\_for\_lb\_access](#input\_ip\_list\_for\_lb\_access) | List of IP's to allow into the worker LB | `list(string)` | n/a | yes |
| <a name="input_postgres_db_enabled"></a> [postgres\_db\_enabled](#input\_postgres\_db\_enabled) | deploy the postgres db or not | `bool` | `false` | no |
| <a name="input_postgresql_allocated_storage"></a> [postgresql\_allocated\_storage](#input\_postgresql\_allocated\_storage) | The allocated storage in gibibytes | `number` | `50` | no |
| <a name="input_postgresql_backup_retention_period"></a> [postgresql\_backup\_retention\_period](#input\_postgresql\_backup\_retention\_period) | The days to retain backups for | `number` | `30` | no |
| <a name="input_postgresql_db_name"></a> [postgresql\_db\_name](#input\_postgresql\_db\_name) | The name of the database to create when the DB instance is created | `string` | n/a | yes |
| <a name="input_postgresql_engine"></a> [postgresql\_engine](#input\_postgresql\_engine) | The database engine to use | `string` | `null` | no |
| <a name="input_postgresql_engine_version"></a> [postgresql\_engine\_version](#input\_postgresql\_engine\_version) | The host zone name in AWS to create a record for this rancher server | `string` | n/a | yes |
| <a name="input_postgresql_instance_class"></a> [postgresql\_instance\_class](#input\_postgresql\_instance\_class) | The RDS instance class | `string` | n/a | yes |
| <a name="input_postgresql_max_allocated_storage"></a> [postgresql\_max\_allocated\_storage](#input\_postgresql\_max\_allocated\_storage) | The maximum allocatatable storage in gibibytes | `number` | `100` | no |
| <a name="input_postgresql_multi_az"></a> [postgresql\_multi\_az](#input\_postgresql\_multi\_az) | Specifies if the RDS instance is multi-AZ | `bool` | n/a | yes |
| <a name="input_postgresql_parameter_group_name"></a> [postgresql\_parameter\_group\_name](#input\_postgresql\_parameter\_group\_name) | Name of the DB parameter group to associate | `string` | n/a | yes |
| <a name="input_postgresql_password"></a> [postgresql\_password](#input\_postgresql\_password) | Password for the master DB user | `string` | n/a | yes |
| <a name="input_postgresql_port"></a> [postgresql\_port](#input\_postgresql\_port) | The port on which the DB accepts connections. | `string` | `"5432"` | no |
| <a name="input_postgresql_replicate_source_db"></a> [postgresql\_replicate\_source\_db](#input\_postgresql\_replicate\_source\_db) | Specifies that this resource is a Replicate database, and to use this value as the source database | `string` | `null` | no |
| <a name="input_postgresql_storage_encrypted"></a> [postgresql\_storage\_encrypted](#input\_postgresql\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `false` | no |
| <a name="input_postgresql_username"></a> [postgresql\_username](#input\_postgresql\_username) | The master username for the database | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | Cidr for the private subnet | `list(string)` | `[]` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | Cidr for the public subnet | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | DNS address to access the application |
