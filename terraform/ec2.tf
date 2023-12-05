resource "aws_instance" "cicd-ec2" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  key_name      = "my-keypair"
  security_groups = [aws_security_group.my_sp.name]
  

  tags = {
    Name = "cicd-pipeline-automation"
  }
}

resource "null_resource" "execute-commands" {

  provisioner "local-exec" {
    command = <<EOT
      
      echo 'my-ec2 ansible_ssh_host=${aws_instance.cicd-ec2.public_ip} ansible_ssh_user=ec2-user > ../ansible/inventory
    EOT
  }
  depends_on = [aws_instance.cicd-ec2]
}

