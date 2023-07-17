# Virtual Private Cloud Setup
resource "aws_vpc" "appsilon_vpc" {
  enable_dns_hostnames = true
  cidr_block           = var.vpc_cidr_block
  tags = {
    Name = "appsilon-vpc"
  }
}

module "appsilon_subnet" {
  source                 = "./modules/network/"
  vpc_id                 = aws_vpc.appsilon_vpc.id
  subnet_cidr_block      = var.subnet_cidr_block
  az                     = var.az
  default_route_table_id = aws_vpc.appsilon_vpc.default_route_table_id
}


# Remote node setup
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_key_pair" "generated_key" {
  key_name   = "server-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "server" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = module.appsilon_subnet.subnet.id
  availability_zone           = var.az
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]

  tags = {
    Name = "appsilon-server-instance"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo yum update -y",
  #     "sudo yum install -y amazon-linux-extras",
  #     "sudo amazon-linux-extras install ansible2 -y",
  #     "ansible-playbook playbook.yml",
  #   ]
  # }


  # connection {
  #   type        = "ssh"
  #   user        = "ec2-user" # remote user
  #   private_key = file("~/.ssh/id_rsa")
  #   host        = self.public_ip
  # }

}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  vpc_id      = aws_vpc.appsilon_vpc.id
  description = "Security group for the EC2 instance"

  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = local.protocol
    cidr_blocks = [var.allowed_address_range]
  }

  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }
}

resource "null_resource" "run_playbook" {
  triggers = {
    trigger = aws_instance.server.public_ip
  }

  provisioner "local-exec" {
    working_dir = "../ansible"
    command     = "ansible-playbook --inventory ${aws_instance.server.public_ip}, --private-key ~/.ssh/id_rsa --user ec2-user playbook.yml"
  }
}

locals {
  ssh_port     = 22
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  protocol     = "tcp"
  all_ips      = ["0.0.0.0/0"]
}