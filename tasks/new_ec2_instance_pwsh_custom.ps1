[CmdletBinding()]
Param(
  $ami,
  $instance_name,
  $instance_type,
  $availability_zone,
  $key_name,
  $monitoring,
  $vpc_security_group_ids,
  $subnet_id,
  $disable_api_termination,
  $ebs_optimized,
  $iam_instance_profile,
  $user_data,
  $root_volume_type,
  $root_volume_size,
  $root_delete_on_termination,
  $ebs_device_name,
  $ebs_volume_type,
  $ebs_volume_size,
  $ebs_delete_on_termination,
  $ebs_iops,
  $region,
  $public_key_data,
  $aws_access_key_id,
  $aws_secret_access_key
)

$env:TF_LOG = "DEBUG"
$env:TF_LOG_PATH = "./terraform.log"
$env:AWS_ACCESS_KEY_ID = $aws_access_key_id
$env:AWS_SECRET_ACCESS_KEY = $aws_secret_access_key

$files = '.terraform', '.terraform.lock.hcl', '.terraform.tfstate.lock.info', 'terraform.tfstate', 'terraform.log'

Set-Location -Path "C:\vm_provision\aws\custom_instance"

Remove-Item $files -ErrorAction SilentlyContinue -Force -Recurse

terraform init

terraform apply -auto-approve `
  -var "ami=$ami" `
  -var "name=$instance_name" `
  -var "instance_type=$instance_type" `
  -var "availability_zone=$availability_zone" `
  -var "key_name=$key_name" `
  -var "monitoring=$monitoring" `
  -var "vpc_security_group_ids=$vpc_security_group_ids" `
  -var "subnet_id=$subnet_id" `
  -var "disable_api_termination=$disable_api_termination" `
  -var "ebs_optimized=$ebs_optimized" `
  -var "iam_instance_profile=$iam_instance_profile" `
  -var "user_data=$user_data" `
  -var "root_volume_type=$root_volume_type" `
  -var "root_volume_size=$root_volume_size" `
  -var "root_delete_on_termination=$root_delete_on_termination" `
  -var "ebs_device_name=$ebs_device_name" `
  -var "ebs_volume_type=$ebs_volume_type" `
  -var "ebs_volume_size=$ebs_volume_size" `
  -var "ebs_delete_on_termination=$ebs_delete_on_termination" `
  -var "ebs_iops=$ebs_iops" `
  -var "region=$region" `
  -var "public_key_data=$public_key_data"