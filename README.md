# vm_provision

This Puppet module currently provides simple virtual machine provisioning in Amazon Web Services through Terraform and Puppet Tasks.

Requires the target node to have the AWS CLI and Terraform installed. Classify the target node with the aforementioned pre-reqs installed with the *vm_provision* class.

Supports Windows and Linux. Experimental / Rapid WIP.
