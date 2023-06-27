#!/bin/bash

instance_size=$PT_instance_size
ami=$PT_ami
instance_name=$PT_instance_name
region=$PT_region
public_key_data=$PT_public_key_data
aws_access_key_id=$PT_aws_access_key_id
aws_secret_access_key=$PT_aws_secret_access_key

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
            -var "instance_type=t2.micro" \
            -var "root_volume_type=gp3" \
            -var "root_volume_size=30" \
            -var "region=$PT_region" \
            -var "public_key_data=$PT_public_key_data"
        ;;
    "Medium")
        terraform apply -auto-approve \
            -var "ami=$PT_ami" \
            -var "instance_name=$PT_instance_name" \
            -var "instance_type=t2.micro" \
            -var "ebs_optimized=false" \
            -var "root_volume_type=gp3" \
            -var "root_volume_size=30" \
            -var "ebs_device_name=/dev/sdh" \
            -var "ebs_volume_type=gp3" \
            -var "ebs_volume_size=20" \
            -var "region=$PT_region" \
            -var "public_key_data=$PT_public_key_data"
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
            -var "public_key_data=$PT_public_key_data"
        ;;
esac