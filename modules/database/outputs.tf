output "db_endpoint" {
  value = aws_db_instance.database.endpoint
}

output "db_arn" {
  value = aws_db_instance.database.arn
}