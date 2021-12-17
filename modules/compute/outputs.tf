output "compute_sg_id" {
  value = aws_security_group.compute.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}