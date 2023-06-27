variable "ami" {}
variable "instance_name" {}
variable "instance_type" {}
variable "root_volume_type" {}
variable "root_volume_size" {}
variable "region" {}
variable "public_key_data" {}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.67.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = var.region
}

resource "aws_security_group" "simple_sec_group" {

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key_pair" {
  public_key = var.public_key_data
}

resource "aws_instance" "server_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.simple_sec_group.id]
  key_name               = aws_key_pair.key_pair.key_name
  tags                   = {Name = var.instance_name}

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }

}
