variable "ami" {}
variable "instance_name" {}
variable "instance_type" {}
variable "availability_zone" {}
variable "key_name" {}
variable "monitoring" {}
variable "vpc_security_group_ids" {}
variable "subnet_id" {}
variable "disable_api_termination" {}
variable "ebs_optimized" {}
variable "iam_instance_profile" {}
variable "user_data" {}
variable "root_volume_type" {}
variable "root_volume_size" {}
variable "root_delete_on_termination" {}
variable "ebs_device_name" {}
variable "ebs_volume_type" {}
variable "ebs_volume_size" {}
variable "ebs_delete_on_termination" {}
variable "ebs_iops" {}
variable "region" {}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "aws_instance" "server_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  subnet_id = var.subnet_id
  disable_api_termination = var.disable_api_termination
  monitoring = var.monitoring
  iam_instance_profile = var.iam_instance_profile
  user_data = var.user_data
  ebs_optimized = var.ebs_optimized
  instance_initiated_shutdown_behavior = "stop"
  tags = {Name = var.instance_name}

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    delete_on_termination = var.root_delete_on_termination
  }

  ebs_block_device {
    device_name = var.ebs_device_name
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
    delete_on_termination = var.ebs_delete_on_termination
    iops = var.ebs_iops
  }

}
