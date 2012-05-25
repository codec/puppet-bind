# Class: bind::key
#
# This module manages bind keys
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   
#
# [Remember: No empty lines between comments and class definition]
define bind::key (
  $algorithm='hmac-md5',
  $secret,
  $target=false
) {
  include bind::params

  concat::fragment { "named.conf-key-${name}":
    target  => $bind::params::config,
    content => template('bind/named.conf/key.erb')
  }
  
  if $target != false {
    file { $target:
      ensure  => present,
      owner   => $bind::params::user,
      group   => $bind::params::group,
      mode    => 0644,
      content => template('bind/named.conf/key.erb')
    }
  }
}