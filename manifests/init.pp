class ss_sushi (
	$env_vars,
	$domain_name,
	$ops_env_vars = undef,
	$vhost_name = 'mysite',
	$vhost_root = '/var/www',
	$apache_root = undef,
	$apache_owner = 'root',
	$apache_group = 'root',
	$cli_root = undef,
	$cli_owner = 'www-data',
	$cli_group = 'www-data',
	$ss_env_owner = 'www-data',
	$ss_env_group = 'www-data',
	$apache_service_name = 'apache'
) {

	ss_sushi::vhost { $vhost_name:
		env_vars            => $env_vars,
		ops_env_vars        => $ops_env_vars,
		domain_name         => $domain_name,
		vhost_name          => $vhost_name,
		vhost_root          => $vhost_root,
		apache_root         => $apache_root,
		apache_owner        => $apache_owner,
		apache_group        => $apache_group,
		cli_root            => $cli_root,
		cli_owner           => $cli_owner,
		cli_group           => $cli_group,
		ss_env_owner        => $ss_env_owner,
		ss_env_group        => $ss_env_group,
		apache_service_name => $apache_service_name
	}

	file { '/usr/local/bin/sushi':
		ensure  => present,
		content => template('ss_sushi/sushi_script.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0700',
	}

	if $cli_root {
		file { "${cli_root}/deploy.ini":
			ensure => present,
			owner  => $cli_owner,
			group  => $cli_group,
			source => 'puppet:///modules/ss_sushi/deploy.ini',
			mode   => '0644',
		}
	}
}
