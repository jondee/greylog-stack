# random string generator
resource "random_string" "suffix" {
  length  = 5
  upper   = false
  lower   = false
  number  = true
  special = false
}

# S3 bucket for VPC flow logs
resource "aws_s3_bucket" "vpc_flow_logs" {
  bucket        = "${var.env}-vpc-flow-logs-bucket-${random_string.suffix.result}"
  force_destroy = true
  acl           = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "${var.env}_vpc_flow_logs_bucket"
    Env  = var.env
  }
}

# flow logs
resource "aws_flow_log" "main" {
  log_destination      = aws_s3_bucket.vpc_flow_logs.arn
  log_destination_type = "s3"
  traffic_type         = "REJECT"
  vpc_id               = aws_vpc.main.id

  tags = {
    Name = "${var.env}_vpc_flow_logs"
    Env  = var.env
  }
}


# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}_vpc"
    Env  = var.env
  }
}

# Declare default SG without rules to revent use
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}_default_sg"
    Env  = var.env
  }
}

# VPC IG
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}_ig"
    Env  = var.env
  }
}

# Private subnet
resource "aws_subnet" "private" {
  count                   = length(var.private_subnet_cidrs)
  availability_zone       = element(data.aws_availability_zones.az.names, count.index)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.env}_private_subnet"
    Env  = var.env
  }

  depends_on = [
    aws_nat_gateway.gw,
    aws_route_table.private

  ]
}

# Public subnet
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  availability_zone       = element(data.aws_availability_zones.az.names, count.index)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}_public_subnet"
    Env  = var.env
  }

  depends_on = [
    aws_internet_gateway.gw,
    aws_route_table.public,
  ]
}

# Nat EIP
resource "aws_eip" "nat_eip" {
  vpc   = true
  count = min(length(var.public_subnet_cidrs), length(var.private_subnet_cidrs), length(data.aws_availability_zones.az.names))
  tags = {
    Name = "${var.env}_nat_eip_${count.index}"
    Env  = var.env
  }
}

# Nat GW
resource "aws_nat_gateway" "gw" {
  count         = min(length(var.public_subnet_cidrs), length(var.private_subnet_cidrs), length(data.aws_availability_zones.az.names))
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "${var.env}_nat_gateway_${count.index}"
    Env  = var.env
  }
}

# Private RT
resource "aws_route_table" "private" {
  count  = min(length(var.public_subnet_cidrs), length(var.private_subnet_cidrs), length(data.aws_availability_zones.az.names))
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
  }

  tags = {
    Name = "${var.env}_private_rt_${count.index}"
    Env  = var.env
  }

  lifecycle {
    ignore_changes = [route]
  }

  depends_on = [
    aws_internet_gateway.gw,
  ]

}

# Public RT
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.env}_public_rt"
    Env  = var.env
  }

  lifecycle {
    ignore_changes = [route]
  }

  depends_on = [
    aws_internet_gateway.gw,
  ]

}

# RT association
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public.*.id)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private.*.id)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}