# Database module
This module is used to create an RDS instance on AWS, list of resources created are listed below:
- Database subnet group
- RDS database
- Security group

The list of requirements, outputs, variables(optional and required) are listed below

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.69.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.database](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/db_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in gibibytes | `number` | `50` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for | `number` | `null` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database to create when the DB instance is created | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Determines if deletion protection should be enable for the DB instance | `bool` | `false` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance | `string` | `"db.t2.micro"` | no |
| <a name="input_license_model"></a> [license\_model](#input\_license\_model) | (Optional, but required for some DB engines, i.e. Oracle SE1) License model information for this DB instance. | `string` | `null` | no |
| <a name="input_list_of_security_groups"></a> [list\_of\_security\_groups](#input\_list\_of\_security\_groups) | List of Security groups to allow access to database instance | `list(string)` | n/a | yes |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | The maximum allocatatable storage in gibibytes | `number` | `100` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | If the RDS instance is multi AZ enabled | `bool` | `true` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the DB parameter group to associate | `string` | `""` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections. | `string` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Bool to control if instance is publicly accessible. Default is false | `bool` | `false` | no |
| <a name="input_replicate_source_db"></a> [replicate\_source\_db](#input\_replicate\_source\_db) | Specifies that this resource is a Replicate database, and to use this value as the source database | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted | `bool` | `true` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The default is io1 if iops is specified, gp2 if not | `string` | `"gp2"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | subnets that will be used to create the DB subnet group | `list(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID to create the Security group in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_arn"></a> [db\_arn](#output\_db\_arn) | n/a |
| <a name="output_db_endpoint"></a> [db\_endpoint](#output\_db\_endpoint) | n/a |
