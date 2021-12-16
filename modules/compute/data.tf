# VPC
data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_route53_zone" "this" {
  name = var.hosted_zone_name
}

data "aws_elb_service_account" "main" {}

data "aws_caller_identity" "current" {}

data "aws_subnet" "this" {
  id = element(var.private_subnets_ids, 0)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}