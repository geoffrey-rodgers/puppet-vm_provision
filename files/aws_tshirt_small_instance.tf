variable "ami" {}
variable "instance_name" {}
variable "instance_type" {}
variable "root_volume_type" {}
variable "root_volume_size" {}
variable "region" {}
variable "public_key_data" {}
variable "pe_server_name" {}
variable "pe_server_ip" {}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = var.region
}

resource "aws_security_group" "single_srvr_sg" {
  name          = "${var.instance_name}_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "pe_server" {
  type              = "egress"
  from_port         = 8140
  to_port           = 8140
  protocol          = "tcp"
  cidr_blocks       = ["${var.pe_server_ip}/32"]
  security_group_id = aws_security_group.single_srvr_sg.id
}

resource "aws_security_group_rule" "pe_orchestration" {
  type              = "egress"
  from_port         = 8142
  to_port           = 8142
  protocol          = "tcp"
  cidr_blocks       = ["${var.pe_server_ip}/32"]
  security_group_id = aws_security_group.single_srvr_sg.id
}

resource "aws_key_pair" "key_pair" {
  public_key = var.public_key_data
}

resource "aws_instance" "server_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.single_srvr_sg.id]
  key_name               = aws_key_pair.key_pair.key_name
  tags                   = {Name = var.instance_name}

  user_data = <<-EOF
              #!/bin/bash
              echo -e "${var.pe_server_ip} ${var.pe_server_name}" >> /etc/hosts
              curl -k https://${var.pe_server_name}:8140/packages/current/install.bash | bash
              puppet agent -t
              EOF

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }
}
