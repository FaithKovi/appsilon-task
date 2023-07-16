provider "aws" {
  region = "us-east-1"  # Adjust the region as per your preference
}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "server-instance"
  }
}

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y amazon-linux-extras",
      "sudo amazon-linux-extras install ansible2 -y",
      "ansible-playbook playbook.yml",
    ]
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"  # remote user
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for the EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "generated_key" {
  key_name   = "server-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
