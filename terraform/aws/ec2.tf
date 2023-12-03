resource "aws_instance" "cicd-ec2"{
  ami = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  tags = {
    Name = "cicd-pipeline-automation"
  }
}
