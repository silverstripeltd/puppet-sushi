class ss_sushi (
	Optional[Array[Stdlib::Compat::Hash]] $vhosts = undef,
) {
	file { '/usr/local/bin/sushi':
		ensure  => present,
		content => template('ss_sushi/sushi_script.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0700',
	}

	if $vhosts and ! empty($vhosts) {
		create_resources(
			'ss_sushi::vhost',
			$vhosts,
		)
	}
}
