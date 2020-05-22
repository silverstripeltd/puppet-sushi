define ss_sushi::vhost (
	$env_vars,
	$domain_name,
	$ops_env_vars = undef,
	$vhost_name = 'mysite',
	$vhost_root = '/var/www',
	$apache_root = '/etc/apache2/platform-variables',
	$apache_owner = 'root',
	$apache_group = 'root',
	$cli_root = '/etc/platform-variables',
	$cli_owner = 'www-data',
	$cli_group = 'www-data',
	$ss_env_owner = 'www-data',
	$ss_env_group = 'www-data',
	$apache_service_name = 'apache'
) {
	ss_sushi::apache { "${vhost_name}/10-master.conf":
		env_vars            => $env_vars,
		domain_name         => $domain_name,
		ops_env_vars        => $ops_env_vars,
		vhost_name          => $vhost_name,
		root_dir            => $apache_root,
		apache_service_name => $apache_service_name,
		owner               => $apache_owner,
		group               => $apache_group
	}

	ss_sushi::cli { "${vhost_name}/10-master.conf":
		env_vars     => $env_vars,
		domain_name  => $domain_name,
		ops_env_vars => $ops_env_vars,
		vhost_name   => $vhost_name,
		vhost_root   => $vhost_root,
		root_dir     => $cli_root,
		owner        => $cli_owner,
		group        => $cli_group
	}

	ss_sushi::ss_env { "${vhost_name}/_ss_environment.php":
		env_vars     => $env_vars,
		domain_name  => $domain_name,
		vhost_name   => $vhost_name,
		ops_env_vars => $ops_env_vars,
		root_dir     => $vhost_root,
		owner        => $ss_env_owner,
		group        => $ss_env_group
	}
}
