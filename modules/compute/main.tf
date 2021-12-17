/**
* # Compute module
* This module is used to create AWS compute resources used to host a simple PHP web application on EC2 instances created by an ASG and launch template, list of resources created are listed below:
* - Launch template
* - Auto scaling group, with auto scalling policies triggered by Cloudwatch alarms
* - Route53 record to access the LB with a dns name
* - Certifcate in AWS Certificate manager
* - Loadbalancer, listeners, target groups
* - Security groups with whitelisting
* - A bastion host for configing the database
* - SSH keys to access the compute nodes
* - IAM instance profile
*
* The list of requirements, outputs, variables(optional and required) are listed below
*/

# Instance profile
resource "aws_iam_instance_profile" "this" {
  name = "${var.env}-instance-profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "this" {
  name = "${var.env}-instance-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": "STS"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "dev-resources-ssm-policy" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ACM config
resource "aws_acm_certificate" "this" {
  domain_name               = "${var.env}.${data.aws_route53_zone.this.name}"
  subject_alternative_names = ["*.${var.env}.${data.aws_route53_zone.this.name}"]
  validation_method         = "DNS"

  tags = {
    Env = var.env
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ACM validation
resource "aws_route53_record" "this" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this.zone_id
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}

# Create DNS record 
resource "aws_route53_record" "compute" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${var.env}.${data.aws_route53_zone.this.name}"
  type    = "A"

  alias {
    name                   = aws_lb.worker_lb.dns_name
    zone_id                = aws_lb.worker_lb.zone_id
    evaluate_target_health = true
  }
}

# LB listener
resource "aws_lb_listener" "compute_80" {
  load_balancer_arn = aws_lb.worker_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# listener
resource "aws_lb_listener" "compute_443" {
  load_balancer_arn = aws_lb.worker_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

# compute ASG attachment to target group
resource "aws_autoscaling_attachment" "asg_attachment_compute" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  alb_target_group_arn   = aws_lb_target_group.this.arn
}

# compute target group
resource "aws_lb_target_group" "this" {
  name     = "${var.env}-compute-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
