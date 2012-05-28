# Class: bind::option
#
# This module manages bind options
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   bind::options {}
#
# [Remember: No empty lines between comments and class definition]
define bind::options (
  $key,
  $value
){
  include bind::params
  include concat::setup

  concat::fragment { "named.conf.options-${name}":
    target  => $bind::params::options,
    content => template('bind/named.conf/options_option.erb'),
  }
}