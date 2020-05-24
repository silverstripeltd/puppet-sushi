define ss_sushi::cli (
	$env_vars,
	$domain_name,
	$ops_env_vars = undef,
	$root_dir = '/etc/platform-variables',
	$vhost_root = '/var/www',
	$vhost_name = 'mysite',
	$file_name = '10-master.conf',
	$owner = 'www-data',
	$group = 'www-data',
) {

	if ($vhost_name != undef) {
		file { "${root_dir}/${vhost_name}":
			ensure  => directory,
			owner   => $owner,
			group   => $group,
			mode    => '0644',
			require => File[$root_dir],
		}
		$master_file_dir = "${root_dir}/${vhost_name}"
	} else {
		$master_file_dir = $root_dir
	}

	file { "${master_file_dir}/${file_name}":
		content => template('ss_sushi/cli.erb'),
		owner   => $owner,
		group   => $group,
		mode    => '0600',
		require => File[$master_file_dir],
	}



}
