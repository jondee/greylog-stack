resource "aws_launch_template" "this" {
  name = "${var.env}-launch-template"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [aws_security_group.compute.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Env = var.env
    }
  }

  user_data = base64encode(templatefile("${path.module}/templates/compute_data.tpl", {
    db_host     = trim(var.db_endpoint, ":5432")
    db_user     = var.db_username
    db_password = var.db_password
    db_port     = var.db_port
    db_name     = var.db_name
  }))
}