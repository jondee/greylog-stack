# Compute module
This module is used to create AWS compute resources used to host a simple PHP web application on EC2 instances created by an ASG and launch template, list of resources created are listed below:
- Launch template
- Auto scaling group, with auto scalling policies triggered by Cloudwatch alarms
- Route53 record to access the LB with a dns name
- Certifcate in AWS Certificate manager
- Loadbalancer, listeners, target groups
- Security groups with whitelisting
- A bastion host for configing the database
- SSH keys to access the compute nodes
- IAM instance profile

The list of requirements, outputs, variables(optional and required) are listed below

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.69.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.69.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | 0.7.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/acm_certificate_validation) | resource |
| [aws_autoscaling_attachment.asg_attachment_compute](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/autoscaling_attachment) | resource |
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.scale_down](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.scale_up](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm.cpu_alarm_down](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_alarm_up](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.dev-resources-ssm-policy](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/instance) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/key_pair) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/launch_template) | resource |
| [aws_lb.worker_lb](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/lb) | resource |
| [aws_lb_listener.compute_443](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.compute_80](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/lb_target_group) | resource |
| [aws_route53_record.compute](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/route53_record) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/route53_record) | resource |
| [aws_security_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/security_group) | resource |
| [aws_security_group.compute](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/security_group) | resource |
| [aws_security_group.lb](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/security_group) | resource |
| [local_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.ssh_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.configure_db](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_60_seconds](https://registry.terraform.io/providers/hashicorp/time/0.7.0/docs/resources/sleep) | resource |
| [tls_private_key.global_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/data-sources/ami) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_desired_size"></a> [asg\_desired\_size](#input\_asg\_desired\_size) | (optional) Desired size for the auto scaling group | `number` | `2` | no |
| <a name="input_asg_health_check_grace_period"></a> [asg\_health\_check\_grace\_period](#input\_asg\_health\_check\_grace\_period) | (optional) The amount of time until EC2 Auto Scaling performs the first health check on new instances after they are put into service. | `number` | `180` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | (optional) Max size for the auto scaling group | `number` | `3` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | (optional) Min size for the auto scaling group | `number` | `1` | no |
| <a name="input_db_endpoint"></a> [db\_endpoint](#input\_db\_endpoint) | The endpoint of the RDS instance | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database to connect to | `string` | `"greylog"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for the DB | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | The port of the RDS instance | `number` | `5432` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Username for the DB | `string` | `"greylog"` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Decides if deletion protection should be enabled for the loadbalancer | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | Env added to names of all resources | `string` | n/a | yes |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | The host zone name in AWS to create a record for this rancher server | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type used for all EC2 instances | `string` | `"t2.micro"` | no |
| <a name="input_ip_list_for_bastion_access"></a> [ip\_list\_for\_bastion\_access](#input\_ip\_list\_for\_bastion\_access) | List of IP's to allow ssh access to the bastion | `list(string)` | n/a | yes |
| <a name="input_ip_list_for_lb_access"></a> [ip\_list\_for\_lb\_access](#input\_ip\_list\_for\_lb\_access) | List of IP's to allow into the worker LB | `list(string)` | n/a | yes |
| <a name="input_private_subnets_ids"></a> [private\_subnets\_ids](#input\_private\_subnets\_ids) | List of private subnet ID's | `list(string)` | n/a | yes |
| <a name="input_public_subnets_ids"></a> [public\_subnets\_ids](#input\_public\_subnets\_ids) | List of public subnet ID's | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id to deplpy resources in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_sg_id"></a> [bastion\_sg\_id](#output\_bastion\_sg\_id) | n/a |
| <a name="output_compute_sg_id"></a> [compute\_sg\_id](#output\_compute\_sg\_id) | n/a |
| <a name="output_record"></a> [record](#output\_record) | n/a |
