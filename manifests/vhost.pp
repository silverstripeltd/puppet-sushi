define ss_sushi::vhost (
	$env_vars,
	$ops_env_vars = undef,
	$domain_name,
	$vhost_name = "mysite",
	$vhost_root = "/var/www",
	$apache_root = "/etc/apache2/platform-variables",
	$cli_root = "/etc/platform-variables",
	$apache_service_name = "apache"
) {
	ss_sushi::apache { "$vhost_name/10-master.conf":
		env_vars => $env_vars,
		ops_env_vars => $ops_env_vars,
		vhost_name => $vhost_name,
		root_dir => $apache_root,
		apache_service_name => $apache_service_name
	}

	ss_sushi::cli { "$vhost_name/10-master.conf":
		env_vars => $env_vars,
		ops_env_vars => $ops_env_vars,
		vhost_name => $vhost_name,
		vhost_root => $vhost_root,
		root_dir => $cli_root
	}

	ss_sushi::ss_env { "$vhost_name/_ss_environment.php":
		env_vars => $env_vars,
		vhost_name => $vhost_name,
		ops_env_vars => $ops_env_vars,
		root_dir => $vhost_root
	}
}
