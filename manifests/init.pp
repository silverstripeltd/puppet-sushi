class ss_sushi (
	$env_vars,
	$ops_env_vars = undef,
	$domain_name,
	$vhost_name = "mysite",
	$vhost_root = "/var/www",
	$apache_root = "/etc/apache2/platform-variables",
	$cli_root = "/etc/platform-variables",
	$apache_service_name = "apache"
) {

	ss_sushi::vhost { $vhost_name:
		env_vars => $env_vars,
		ops_env_vars => $ops_env_vars,
		domain_name => $domain_name,
		vhost_name => $vhost_name,
		vhost_root => $vhost_root,
		apache_root => $apache_root,
		cli_root => $cli_root,
		apache_service_name => $apache_service_name
	}

	file { $apache_root:
		ensure => directory,
		owner => "root",
		group => "root",
		mode => "0644",
	}

	file { $cli_root:
		ensure => directory,
		owner => "www-data",
		group => "www-data",
		mode => "0644",
	}

	file { "/usr/local/bin/sushi":
		ensure => present,
		content => template("ss_sushi/sushi_script.erb"),
		owner => "root",
		group => "root",
		mode => "0700",
	}
}
