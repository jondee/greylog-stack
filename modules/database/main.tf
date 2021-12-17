resource "aws_db_subnet_group" "this" {
  name       = "${var.env}-db-subnets"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.env}-db-subnet-group"
    Env  = var.env
  }
}


resource "aws_db_instance" "database" {
  replicate_source_db     = var.replicate_source_db
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
  db_subnet_group_name    = aws_db_subnet_group.this.id
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  storage_type            = var.storage_type
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  name                    = var.db_name
  identifier              = var.identifier
  username                = var.username
  password                = var.password
  port                    = var.port
  license_model           = var.license_model
  publicly_accessible     = var.publicly_accessible
  skip_final_snapshot     = var.skip_final_snapshot
  storage_encrypted       = var.storage_encrypted
  multi_az                = var.multi_az
  parameter_group_name    = var.parameter_group_name
  vpc_security_group_ids  = [aws_security_group.this.id]

  tags = {
    Name = "${var.env}-${var.engine}-db"
    Env  = var.env
  }
}