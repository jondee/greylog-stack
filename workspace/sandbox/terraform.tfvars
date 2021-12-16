# General
aws_region = "us-east-2"
env        = "sandbox"

# Network
cidr                 = "10.0.0.0/16"
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]


# Compute 
hosted_zone_name      = "sirjobzy.com."
ip_list_for_lb_access = ["99.238.254.40/32"]
