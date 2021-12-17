resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key_pem" {
  filename          = "${path.root}/keys/${var.env}-key"
  sensitive_content = tls_private_key.global_key.private_key_pem
  file_permission   = "0400"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "${path.root}/keys/${var.env}-key.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# aws key pair used for SSH accesss
resource "aws_key_pair" "this" {
  key_name_prefix = "${var.env}-key"
  public_key      = tls_private_key.global_key.public_key_openssh
}
