# Class: bind::zone::managed
#
# This module manages bind forward zones with puppet
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
class bind::zone::forward ($forwarders) {
  include bind::params
  include concat::setup

  concat::fragment { "named.conf.local-forward-${name}":
    target  => $bind::params::local,
    content => template('bind/named.conf/local_forward.erb')
  }
}