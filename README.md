# vm_provision

This Puppet module currently provides simple virtual machine provisioning in Amazon Web Services using Terraform and Puppet Tasks. It is currently in the proof of concept stage, and some virtual machine values are hard-coded, to ensure low to zero cost during testing and development. These values will be replaced with user-managable Hiera
data through a Puppet Plan in next week's update.

Additionally, Linux VM's will install the Puppet Agent after they have been initialized. Windows VM's do not have this feature implemented yet, but it will be added in next week's update,

Nodes used as targets of these Puppet Tasks require the AWS CLI and Terraform to already be installed. Additionally, classify the target node with the *vm_provision* class contained in this module.

The [New EC2 Instance Shell Task](https://github.com/geoffrey-rodgers/puppet-vm_provision/blob/main/tasks/new_ec2_instance_shell.sh) is the core focus of current module updates.

Tested on RHEL 7. Experimental / Rapid WIP.
