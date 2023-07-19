# vm_provision

This Puppet module currently provides simple virtual machine provisioning in Amazon Web Services using Terraform and Puppet Tasks.

Nodes used as targets of these Puppet Tasks require the AWS CLI and Terraform to already be installed. Additionally, classify the target node with the *vm_provision* class contained in this module.

The [New EC2 Instance Shell Task](https://github.com/geoffrey-rodgers/puppet-vm_provision/blob/main/tasks/new_ec2_instance_shell.sh) is the core focus of current module updates.

Tested on Windows 10 and RHEL 7. Experimental / Rapid WIP.
