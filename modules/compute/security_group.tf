# Worker nodes SG
resource "aws_security_group" "lb" {
  name        = "${var.env}-compute-lb-sg"
  description = "Compute Loadbalancer SG"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ip_list_for_lb_access

    content {
      from_port   = "80"
      to_port     = "80"
      protocol    = "TCP"
      cidr_blocks = [ingress.value]
    }

  }

  dynamic "ingress" {
    for_each = var.ip_list_for_lb_access

    content {
      from_port   = "443"
      to_port     = "443"
      protocol    = "TCP"
      cidr_blocks = [ingress.value]
    }

  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [
      ingress,
    ]
  }

  tags = {
    Name = "${var.env}-compute-lb-sg"
    Env  = var.env
  }
}

# Bastion node SG
resource "aws_security_group" "bastion" {
  name        = "${var.env}-bastion-sg"
  description = "Bastion SG"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ip_list_for_bastion_access

    content {
      from_port   = "22"
      to_port     = "22"
      protocol    = "TCP"
      cidr_blocks = [ingress.value]
    }

  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [
      ingress,
    ]
  }

  tags = {
    Name = "${var.env}-bastion-sg"
    Env  = var.env
  }
}

resource "aws_security_group" "compute" {
  name        = "${var.env}-compute-sg"
  description = "Security gruop for compute nodes"
  vpc_id      = var.vpc_id


  ingress {
    description     = "HTTP from worker LB"
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.lb.id]
  }

  ingress {
    description     = "HTTPS from worker LB"
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    description = "All traffic out"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "${var.env}-node-sg"
    Env  = var.env
  }
}