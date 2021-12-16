output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "private_route_table_id" {
  description = "The ID of the route table associated with the private subnets"
  value       = aws_route_table.private.*.id
}

output "public_route_table_id" {
  description = "The ID of the route table associated with the public subnets"
  value       = aws_route_table.public.id
}

output "internet_gateway_id" {
  description = "VPC Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

output "public_subnet_ids" {
  description = "Public subnets"
  value       = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  description = "Private subnets"
  value       = aws_subnet.private.*.id
}

output "public_route_table_association_id" {
  value = aws_route_table_association.public.*.id
}

output "private_route_table_association_id" {
  value = aws_route_table_association.private.*.id
}