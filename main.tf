provider "aws" {
    region = "us-east-1"
    access_key = "AKIAQCIY444ENPR3Z4SE"
    secret_key = "n9uCSdbd+EUpRqR0oYaK81Hgxnj8yRYJTg266e6P"
}
resource "aws_instance" "Example" {
    ami = "ami-08e4e35cccc6189f4"
    instance_type = "t2.micro"
    tags = {
      Name = "Example"
    } 
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    user_data ="${file("jenkins.sh")}"
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0acf5bf7b5c578e38"

  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}