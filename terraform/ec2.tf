resource "aws_instance" "cicd-ec2" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_keypair.key_name
  depends_on = [
    aws_key_pair.my_keypair
  ]

  tags = {
    Name = "cicd-pipeline-automation"
  }
}

resource "null_resource" "execute-commands" {

  provisioner "local-exec" {
    command = <<EOT
      echo '${tls_private_key.private_key.private_key_pem}' > ../ansible/private.pem 
      chmod 400 ../ansible/private.pem
      echo 'my-ec2 ansible_ssh_host=${aws_instance.cicd-ec2.public_ip} ansible_ssh_user=ec2-user ansible_ssh_private_key_file=private.pem' > ../ansible/inventory
    EOT
  }
  depends_on = [aws_instance.cicd-ec2]
}


resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "my_keypair" {
  key_name   = "my-keypair"
  public_key = tls_private_key.private_key.public_key_openssh
}
