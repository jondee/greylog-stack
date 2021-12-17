
# Bastion node
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = element(var.public_subnets_ids, 0)
  key_name               = aws_key_pair.this.key_name
  iam_instance_profile   = aws_iam_instance_profile.this.name
  vpc_security_group_ids = [aws_security_group.bastion.id]
  user_data              = filebase64("${path.module}/templates/bastion_data.tpl")

  root_block_device {
    volume_size = 16
  }

  tags = {
    Name = "${var.env}-bastion-server"
    Env  = var.env
  }

}

# sleep for 30 seconds to allow bastion host load
resource "time_sleep" "wait_60_seconds" {
  depends_on = [
    aws_instance.bastion,
  ]

  create_duration = "60s"
}