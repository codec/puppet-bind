# Class: bind::zone::record
#
# This module manages bind zone records
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
define bind::zone::record (
  $zone,
  $type='A',
  $value,
  $key,
) {
  include bind::params
  include concat::setup

  concat::fragment { "db.${zone}_record_${type}":
    target  => "${bind::params::zonedir}/db.${zone}",
    content => template('bind/named.conf/zone_record.erb')
  }
}