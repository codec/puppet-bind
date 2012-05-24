# Class: bind::params
#
# This module manages parameters
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
class bind::params {
  case $operatingsystem {
    default: {
      $confdir = '/etc/bind'
      $zonedir = "${bind::params::confdir}/zones"
      $cachedir = '/var/cache/bind'
      $package = 'bind9'
      $service = 'bind9'
      $config  = "${bind::params::confdir}/named.conf"
      $options = "${bind::params::confdir}/named.conf.options"
      $local   = "${bind::params::confdir}/named.conf.local"
      $default_zones = "${bind::params::confdir}/named.conf.default-zones"
      $user = 'bind'
      $group = 'bind'
    }
    #default: {
    #  fail("${operatingsystem} is not supported!")
    #}
  }
}