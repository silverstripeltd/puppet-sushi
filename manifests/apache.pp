define ss_sushi::apache (
	$env_vars,
	$ops_env_vars = undef,
	$root_dir = '/etc/apache2/platform-variables',
	$vhost_name = 'mysite',
	$file_name = '10-master.conf',
	$owner = 'www-data',
	$group = 'www-data',
	$apache_service_name = 'apache'
) {

	if ($vhost_name != undef) {
		file { "${root_dir}/${vhost_name}":
			ensure  => directory,
			owner   => 'www-data',
			group   => 'www-data',
			mode    => '0644',
			require => File[$root_dir],
	}
		$master_file_dir = "${root_dir}/${vhost_name}"
	} else {
		$master_file_dir = $root_dir
	}

	file { "${master_file_dir}/${file_name}":
		content => template('ss_sushi/apache.erb'),
		owner   => $owner,
		group   => $group,
		mode    => '0600',
		notify  => Service[$apache_service_name],
		require => File[$master_file_dir],
	}

}
