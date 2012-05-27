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

bind::zone { 'sub.example.com':
  nameservers => ['192.168.0.1', '192.168.0.2'],
  options     => {
    'rr'  => 'master',
  },
  source      => 'puppet:///private/bind/db.sub.example.com'
}

bind::zone::record { 'test.example.com':
  zone  => 'example.com',
  rr  => 'AAAA',
  key   => 'test',
  value => '::1'
}

bind::zone::record { 'a_test.example.com':
  zone  => 'example.com',
  rr  => 'A',
  key   => 'test',
  value => '127.0.0.2'
}