# @summary Creates the directory structure and places the Terraform files for
# AWS instance provisioning in the correct locations
#
# Include this class on any node that can reach AWS and has Terraform installed
# in order to provision AWS instances from it using the Tasks included in this module. 
#
# @example
#   include vm_provision
class vm_provision {
  if $facts['os']['family'] == 'windows' {
    # build the directory structure for AWS instance provisioning on Windows
    file { 'C:/vm_provision':
      ensure => 'directory',
    }
    file { 'C:/vm_provision/aws':
      ensure => 'directory',
    }
    file { 'C:/vm_provision/aws/custom_instance':
      ensure => 'directory',
    }
    file { 'C:/vm_provision/aws/small_instance':
      ensure => 'directory',
    }
    file { 'C:/vm_provision/aws/medium_large_instance':
      ensure => 'directory',
    }

    # place the Terraform files for AWS instance provisioning in the correct locations for Windows
    file { 'C:/vm_provision/aws/custom_instance/aws_custom_instance.tf':
      ensure => 'file',
      source => 'puppet:///modules/vm_provision/aws_custom_instance.tf',
    }

    file { 'C:/vm_provision/aws/small_instance/aws_tshirt_small_instance.tf':
      ensure => 'file',
      source => 'puppet:///modules/vm_provision/aws_tshirt_small_instance.tf',
    }

    file { 'C:/vm_provision/aws/medium_large_instance/aws_tshirt_medium_large_instance.tf':
      ensure => 'file',
      source => 'puppet:///modules/vm_provision/aws_tshirt_medium_large_instance.tf',
    }
  }
  elsif $facts['kernel'] == 'Linux' {
    # build the directory structure for AWS instance provisioning for Linux
    file { '/usr/vm_provision':
      ensure => 'directory',
    }
    file { '/usr/vm_provision/aws':
      ensure => 'directory',
    }
    file { '/usr/vm_provision/aws/custom_instance':
      ensure => 'directory',
    }
    file { '/usr/vm_provision/aws/small_instance':
      ensure => 'directory',
    }
    file { '/usr/vm_provision/aws/medium_large_instance':
      ensure => 'directory',
    }

    # place the Terraform files for AWS instance provisioning in the correct locations for Linux
    file { '/usr/vm_provision/aws/custom_instance/aws_custom_instance.tf':
      ensure => 'file',
      source => 'puppet:///modules/vm_provision/aws_custom_instance.tf',
    }

    file { '/usr/vm_provision/aws/small_instance/aws_tshirt_small_instance.tf':
      ensure => 'file',
      source => 'puppet:///modules/vm_provision/aws_tshirt_small_instance.tf',
    }

    file { '/usr/vm_provision/aws/medium_large_instance/aws_tshirt_medium_large_instance.tf':
      ensure => 'file',
      source => 'puppet:///modules/vm_provision/aws_tshirt_medium_large_instance.tf',
    }
  }
}
