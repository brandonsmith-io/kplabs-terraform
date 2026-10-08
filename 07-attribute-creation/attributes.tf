provider "aws" {
  region = "us-east-1"
}



resource "aws_eip" "lb" {
  domain   = "vpc"
  instance = aws_instance.web_server.id
}


data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
}

