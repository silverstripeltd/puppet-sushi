class ss_sushi (
	$env_vars,
	$ops_env_vars = undef,
	$domain_name,
	$vhost_name = "mysite",
	$vhost_root = "/var/www",
	$apache_root = "/etc/apache2/platform-variables",
	$cli_root = "/etc/platform-variables"
) {

	ss_sushi::vhost { $vhost_name:
		env_vars => $env_vars,
		ops_env_vars => $ops_env_vars,
		domain_name => $domain_name,
		vhost_name => $vhost_name,
		vhost_root => $vhost_root,
		apache_root => $apache_root,
		cli_root => $cli_root
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


	file { $vhost_root:
		ensure => directory,
		owner => "root",
		group => "root",
		mode => "0755",
		onlyif => "test ! -d $vhost_root"
	}

	file { "$vhost_root/$vhost_name/shared":
		ensure => directory,
		owner => "www-data",
		group => "www-data",
		mode => "0644",
		onlyif => "test ! -d $vhost_root/$vhost_name/shared"
	}

	file { "$vhost_root/$vhost_name/releases":
		ensure => directory,
		owner => "www-data",
		group => "www-data",
		mode => "0644",
		onlyif => "test ! -d $vhost_root/$vhost_name/releases"
	}

	file { "/usr/local/bin/sushi":
		ensure => present,
		content => template("ss_sushi/sushi_script.erb"),
		owner => "root",
		group => "root",
		mode => "0700",
	}

	file { "/var/www/html":
		ensure => absent,
		recurse => true,
		force => true
	}

}
