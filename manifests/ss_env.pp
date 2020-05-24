define ss_sushi::ss_env (
	$env_vars,
	$domain_name,
	$ops_env_vars = undef,
	$root_dir = '/var/www',
	$vhost_name = 'mysite',
	$file_name = '_ss_environment.php',
	$owner = 'www-data',
	$group = 'www-data',
) {

	if ($vhost_name != undef) {
		$master_file_dir = "${root_dir}/${vhost_name}"
	} else {
		$master_file_dir = $root_dir
	}

	file { "${master_file_dir}/${file_name}":
		content => template('ss_sushi/ss_env.erb'),
		owner   => $owner,
		group   => $group,
		mode    => '0640',
		require => File[$master_file_dir],
	}

}
