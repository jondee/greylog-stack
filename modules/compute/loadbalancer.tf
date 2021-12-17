resource "aws_lb" "worker_lb" {
  name               = "${var.env}-compute-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = var.public_subnets_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name = "${var.env}-compute-lb"
  }

}
