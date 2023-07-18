#!/bin/bash

# Since we are using the shell provisioner, we don't need this script to take input.
# We use the Puppet Task parameters directly by prefixing them with PT_.

export TF_LOG="DEBUG"
export TF_LOG_PATH="./terraform.log"
export AWS_ACCESS_KEY_ID=$PT_aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$PT_aws_secret_access_key

files=('.terraform' '.terraform.lock.hcl' 'terraform.tfstate.lock.info' 'terraform.tfstate' 'terraform.log')

cd "/usr/vm_provision/aws/custom_instance"

rm -rf "${files[@]}"

terraform init

terraform apply -auto-approve \
  -var "ami=$PT_ami" \
  -var "name=$PT_instance_name" \
  -var "instance_type=$PT_instance_type" \
  -var "availability_zone=$PT_availability_zone" \
  -var "key_name=$PT_key_name" \
  -var "monitoring=$PT_monitoring" \
  -var "vpc_security_group_ids=$PT_vpc_security_group_ids" \
  -var "subnet_id=$PT_subnet_id" \
  -var "disable_api_termination=$PT_disable_api_termination" \
  -var "ebs_optimized=$PT_ebs_optimized" \
  -var "iam_instance_profile=$PT_iam_instance_profile" \
  -var "user_data=$PT_user_data" \
  -var "root_volume_type=$PT_root_volume_type" \
  -var "root_volume_size=$PT_root_volume_size" \
  -var "root_delete_on_termination=$PT_root_delete_on_termination" \
  -var "ebs_device_name=$PT_ebs_device_name" \
  -var "ebs_volume_type=$PT_ebs_volume_type" \
  -var "ebs_volume_size=$PT_ebs_volume_size" \
  -var "ebs_delete_on_termination=$PT_ebs_delete_on_termination" \
  -var "ebs_iops=$PT_ebs_iops" \
  -var "region=$PT_region" \
  -var "public_key_data=$PT_public_key_data"

