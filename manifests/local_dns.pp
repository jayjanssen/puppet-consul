class consul::local_dns {
	include bind
	bind::server::conf { '/etc/named.conf':
	    forwarders        => [ '8.8.8.8', '8.8.4.4' ],
	    allow_query       => [ 'localhost' ],
		dnssec_enable     => 'no',
		dnssec_validation     => 'no',
		zones             => {
		    'consul' => [
		      'type forward',
		      'forwarders { 127.0.0.1 port 8600; }',
			  'forward only'
		    ],
		}
	}
	
	
    class { 'resolv_conf':
        nameservers => ['127.0.0.1'],
		require => Service['named']
  	}
	
	consul::service {'local_dns':
		checks => [{
			port           => 53,
			script   => '/usr/bin/dig @127.0.0.1 google.com +time=1',
			interval => '1m'
		}]
	}
	
}