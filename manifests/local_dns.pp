class consul::local_dns {
	# include bind::package
	# include bind::service
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
}