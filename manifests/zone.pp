# Class: bind::zone
#
# This module manages bind zones
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
define bind::zone (
  $nameservers=[$::ipaddress],
  $options,
  $source=false
) {
  include bind::params
  include concat::setup
  
  concat::fragment { "named.conf.local-zone-${name}":
    target  => $bind::params::local,
    content => template('bind/named.conf/local_zone.erb')
  }
  
  if $source == false {
    class { 'bind::zone::managed':
      name        => $name,
      nameservers => $nameservers
    }
  } else {
    file { "${bind::params::zonedir}/db.${name}":
      owner   => $bind::params::user,
      group   => $bind::params::group,
      mode    => 0644,
      source  => $source
    }
  }
}