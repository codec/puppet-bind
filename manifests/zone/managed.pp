# Class: bind::zone::managed
#
# This module manages bind zone records with puppet
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
define bind::zone::managed ($nameservers=[$::ipaddress]){
  concat { "${bind::params::zonedir}/db.${name}":
    owner => bind,
    group => bind,
    mode  => 0644
  }
  
  concat::fragment { "db.${name}":
    target  => "${bind::params::zonedir}/db.${name}",
    content => template('bind/named.conf/zone_header.erb'),
    order   => 01
  }
}