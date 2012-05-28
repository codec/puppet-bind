# Class: bind
#
# This module manages bind
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   class { 'bind': forwarders => ['8.8.8.8', '4.4.4.4'] }
#
# [Remember: No empty lines between comments and class definition]
class bind (
  $forwarders,
  $options
){
  include bind::params
  include concat::setup

  package { 'bind9':
    ensure => installed,
    name   => $bind::params::package,
  }

  service { 'bind9':
    ensure  => running,
    name    => $bind::params::service,
    require => Package['bind9'],
  }
  
  file { $bind::params::zonedir:
    ensure  => directory,
    owner   => $bind::params::user,
    group   => $bind::params::group,
    mode    => 0744,
    require => Package['bind9']
  }


  ##  /etc/bind/named.conf
  #
  concat { $bind::params::config:
    owner   => $bind::params::user,
    group   => $bind::params::group,
    mode    => 0644,
    require => Package['bind9']
  }

  concat::fragment { 'named.conf-includes':
    target  => $bind::params::config,
    content => template('bind/named.conf/includes.erb')
  }

  ##  /etc/bind/named.conf.options
  #  
  concat { $bind::params::options:
    owner   => $bind::params::user,
    group   => $bind::params::group,
    mode    => 0644
  }

  concat::fragment { 'named.conf.options-header':
    target  => $bind::params::options,
    content => 'options {',
    order   => 01
  }
  
  concat::fragment { 'named.conf.options-forwarders':
    target  => $bind::params::options,
    content => template('bind/named.conf/options_forwarders.erb'),
    order   => 02
  }

  concat::fragment { 'named.conf.options-defaults':
    target  => $bind::params::options,
    content => template('bind/named.conf/options_defaults.erb'),
    order   => 03
  }

  concat::fragment { 'named.conf.options-footer':
    target  => $bind::params::options,
    content => '};',
    order   => 99
  }
  
  create_resources('bind::option', $options)

  ##  /etc/bind/named.conf.local
  #
  concat { $bind::params::local:
    owner => $bind::params::user,
    group => $bind::params::group,
    mode  => 0644
  }

  concat::fragment { 'named.conf.local-header':
    target  => $bind::params::options,
    content => template('bind/named.conf/local_header.erb'),
    order   => 01
  }
}