# Networking module
This module is used to create networking resources on AWS, list of resources created are listed below:
- VPC
- Private and public subnets
- Route tables
- Nat gateways for internets access from public subnets
- S3 bucket for VPC flow logs
- Internet gateway

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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/default_security_group) | resource |
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/eip) | resource |
| [aws_flow_log.main](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/flow_log) | resource |
| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/s3_bucket) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/vpc) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.az](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | Cidr block for the VPC | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | env added to names/tags of all resources | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | Cidr for the private subnet | `list(string)` | `[]` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | Cidr for the public subnet | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidr_block"></a> [cidr\_block](#output\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | VPC Internet Gateway |
| <a name="output_private_route_table_association_id"></a> [private\_route\_table\_association\_id](#output\_private\_route\_table\_association\_id) | n/a |
| <a name="output_private_route_table_id"></a> [private\_route\_table\_id](#output\_private\_route\_table\_id) | The ID of the route table associated with the private subnets |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | Private subnets |
| <a name="output_public_route_table_association_id"></a> [public\_route\_table\_association\_id](#output\_public\_route\_table\_association\_id) | n/a |
| <a name="output_public_route_table_id"></a> [public\_route\_table\_id](#output\_public\_route\_table\_id) | The ID of the route table associated with the public subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | Public subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
