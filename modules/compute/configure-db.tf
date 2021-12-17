
resource "null_resource" "configure_db" {

  provisioner "remote-exec" {
    inline = [
      "export PGPASSWORD=\"${var.db_password}\"",
      "psql -h ${trim(var.db_endpoint, ":5432")} -d ${var.db_name} -U ${var.db_username} -c \"create table if not exists notes(id int, note varchar(255));\"",
      "psql -h ${trim(var.db_endpoint, ":5432")} -d ${var.db_name} -U ${var.db_username} -c \"insert into notes(id,note)values(1,'Hello Greylog!');\"",
      "unset PGPASSWORD"
    ]
  }

  # the ssh connection details for this null resource
  connection {
    type        = "ssh"
    host        = aws_instance.bastion.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.global_key.private_key_pem
    port        = "22"
  }

  depends_on = [
    time_sleep.wait_60_seconds
  ]
}