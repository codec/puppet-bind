puppet-bind
===========

A module to manage bind9. Tested on Debian (squeeze).

Example usage
-------------
See tests/init.pp.

```puppet
class { 'bind':
  forwarders => ['4.4.4.4', '8.8.8.8']
}

bind::key { 'rndc':
  secret  => 'foo',
  target  => "${bind::params::confdir}/rndc.key"
}

bind::zone { 'example.com':
  nameservers => ['127.0.0.1', '127.0.0.2'],
  options     => {
    'type'            => 'master',
    'allow-transfer'  => '{ 127.0.0.1; }',
    'allow-update'    => '{ 127.0.0.1; key rndc; }'
  }
}

bind::zone::record { 'test.example.com':
  zone  => 'example.com',
  key   => 'test',
  value => '127.0.0.1'
}
```

