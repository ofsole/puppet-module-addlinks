# == Class: addlinks
#
# Manage addlinks
#
class addlinks (
  $manage_local_facter_package  = true,
  $ensure_local_facter_package  = 'absent',
  $path_to_facter               = '/opt/puppet/bin/facter',
  $path_to_facter_symlink       = '/usr/bin/facter',
  $ensure_facter_symlink        = true,
  $local_factor_package_name    = 'factor',
  $manage_local_puppet_package  = true,
  $ensure_local_puppet_package  = 'absent',
  $path_to_puppet               = '/opt/puppet/bin/puppet',
  $path_to_puppet_symlink       = '/usr/bin/puppet',
  $ensure_puppet_symlink        = true,
  $local_puppet_package_name    = 'puppet',
) {

  validate_string($ensure_local_facter_package)
  validate_absolute_path($path_to_facter)
  validate_absolute_path($path_to_facter_symlink)

  if type($manage_local_facter_package) == 'string' {
    $manage_local_facter_package_real = str2bool($manage_local_facter_package)
  } else {
    validate_bool($manage_local_facter_package)
    $manage_local_facter_package_real = $manage_local_facter_package
  }

  if type($local_factor_package_name) != 'String' and type($local_factor_package_name) != 'Array' {
    fail('facter::package_name must be a string or an array.')
  }


  if $manage_local_facter_package_real == true {

    package { $local_factor_package_name:
      ensure => $ensure_local_facter_package,
    }
  }

  if type($ensure_facter_symlink) == 'string' {
    $ensure_facter_symlink_bool = str2bool($ensure_facter_symlink)
  } else {
    validate_bool($ensure_facter_symlink)
    $ensure_facter_symlink_bool = $ensure_facter_symlink
  }
  validate_bool($ensure_facter_symlink_bool)
  if $ensure_facter_symlink_bool == true {

    file { 'add_facter_symlink':
      ensure => 'link',
      path   => $path_to_facter_symlink,
      target => $path_to_facter,
    }
  }

  validate_string($ensure_local_puppet_package)
  validate_absolute_path($path_to_puppet)
  validate_absolute_path($path_to_puppet_symlink)

  if type($manage_local_puppet_package) == 'string' {
    $manage_local_puppet_package_real = str2bool($manage_local_puppet_package)
  } else {
    validate_bool($manage_local_puppet_package)
    $manage_local_puppet_package_real = $manage_local_puppet_package
  }

  if type($local_puppet_package_name) != 'String' and type($local_puppet_package_name) != 'Array' {
    fail('facter::package_name must be a string or an array.')
  }

  if $manage_local_puppet_package_real == true {

    package { $local_puppet_package_name:
      ensure => $ensure_local_puppet_package,
    }
  }

  if type($ensure_puppet_symlink ) == 'string' {
    $ensure_puppet_symlink_bool = str2bool($ensure_puppet_symlink )
  } else {
    validate_bool($ensure_puppet_symlink )
    $ensure_puppet_symlink_bool = $ensure_puppet_symlink 
  }
  validate_bool($ensure_puppet_symlink_bool)

  if $ensure_puppet_symlink_bool == true {

    file { 'add_puppet_symlink':
      ensure => 'link',
      path   => $path_to_puppet_symlink,
      target => $path_to_puppet,
    }
  }


}
