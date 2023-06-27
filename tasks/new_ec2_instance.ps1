[CmdletBinding()]
Param(
    $instance_size,
    $ami,
    $instance_name,
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

if ($instance_size -eq 'Small') {
    Set-Location -Path "C:\vm_provision\aws\small_instance"
}
else {
    Set-Location -Path "C:\vm_provision\aws\medium_large_instance"
}

Remove-Item $files -ErrorAction SilentlyContinue -Force -Recurse

terraform init

switch ($instance_size) {
    'Small' { 
        terraform apply -auto-approve `
            -var "ami=$ami" `
            -var "instance_name=$instance_name" `
            -var "instance_type=t2.micro" `
            -var "root_volume_type=gp3" `
            -var "root_volume_size=30" `
            -var "region=$region" `
            -var "public_key_data=$public_key_data"  
    }
    'Medium' {
        terraform apply -auto-approve `
            -var "ami=$ami" `
            -var "instance_name=$instance_name" `
            -var "instance_type=t2.micro" `
            -var "ebs_optimized=false" `
            -var "root_volume_type=gp3" `
            -var "root_volume_size=30" `
            -var "ebs_device_name=/dev/sdh" `
            -var "ebs_volume_type=gp3" `
            -var "ebs_volume_size=20" `
            -var "region=$region" `
            -var "public_key_data=$public_key_data"
    }
    'Large' {
        terraform apply -auto-approve `
            -var "ami=$ami" `
            -var "name=$instance_name" `
            -var "instance_type=t3.micro" `
            -var "ebs_optimized=true" `
            -var "root_volume_type=gp3" `
            -var "root_volume_size=30" `
            -var "ebs_device_name=/dev/sdh" `
            -var "ebs_volume_type=gp3" `
            -var "ebs_volume_size=30" `
            -var "region=$region" `
            -var "public_key_data=$public_key_data"
    }
}

