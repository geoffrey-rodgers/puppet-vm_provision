# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include vm_provision
class vm_provision {
  if $facts['os']['family'] == 'windows' {
    # build the directory structure for AWS instance provisioning
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

    # place the Terraform files for AWS instance provisioning in the correct locations
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
    # build the directory structure for AWS instance provisioning
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

    # place the Terraform files for AWS instance provisioning in the correct locations
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
