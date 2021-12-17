resource "aws_security_group" "this" {
  name        = "${var.env}-${var.engine}-db-sg"
  description = "Allow DB inbound traffic"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "DB access from SG"
      from_port        = var.port
      to_port          = var.port
      protocol         = "tcp"
      security_groups  = var.list_of_security_groups
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      security_groups  = []
      prefix_list_ids  = []
      self             = false
      description      = "Allow all outbound traffic"
    }
  ]

  tags = {
    Name = "${var.env}-${var.engine}-db-sg"
    Env  = var.env
  }
}