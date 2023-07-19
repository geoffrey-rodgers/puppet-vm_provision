#!/bin/bash

# Since we are using the shell provisioner, we don't need this script to take input.
# We use the Puppet Task parameters directly by prefixing them with PT_.

export TF_LOG="DEBUG"
export TF_LOG_PATH="./terraform.log"
export AWS_ACCESS_KEY_ID=$PT_aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$PT_aws_secret_access_key

files=('.terraform' '.terraform.lock.hcl' '.terraform.tfstate.lock.info' 'terraform.tfstate' 'terraform.log')

if [ "$PT_instance_size" = "Small" ]; then
    cd "/usr/vm_provision/aws/small_instance"
else
    cd "/usr/vm_provision/aws/medium_large_instance"
fi

rm -rf "${files[@]}"

terraform init

case $PT_instance_size in
    "Small")
        terraform apply -auto-approve \
            -var "ami=$PT_ami" \
            -var "instance_name=$PT_instance_name" \
            -var "instance_type=t3.micro" \
            -var "root_volume_type=gp3" \
            -var "root_volume_size=30" \
            -var "region=$PT_region" \
            -var "public_key_data=$PT_public_key_data" \
            -var "pe_server_name=$PT_pe_server_name" \
            -var "pe_server_ip=$PT_pe_server_ip"
        ;;
    "Medium")
        terraform apply -auto-approve \
            -var "ami=$PT_ami" \
            -var "instance_name=$PT_instance_name" \
            -var "instance_type=t3.micro" \
            -var "ebs_optimized=false" \
            -var "root_volume_type=gp3" \
            -var "root_volume_size=30" \
            -var "ebs_device_name=/dev/sdh" \
            -var "ebs_volume_type=gp3" \
            -var "ebs_volume_size=20" \
            -var "region=$PT_region" \
            -var "public_key_data=$PT_public_key_data" \
            -var "pe_server_name=$PT_pe_server_name" \
            -var "pe_server_ip=$PT_pe_server_ip"
        ;;
    "Large")
        terraform apply -auto-approve \
            -var "ami=$PT_ami" \
            -var "name=$PT_instance_name" \
            -var "instance_type=t3.micro" \
            -var "ebs_optimized=true" \
            -var "root_volume_type=gp3" \
            -var "root_volume_size=30" \
            -var "ebs_device_name=/dev/sdh" \
            -var "ebs_volume_type=gp3" \
            -var "ebs_volume_size=30" \
            -var "region=$PT_region" \
            -var "public_key_data=$PT_public_key_data" \
            -var "pe_server_name=$PT_pe_server_name" \
            -var "pe_server_ip=$PT_pe_server_ip"
        ;;
esac
