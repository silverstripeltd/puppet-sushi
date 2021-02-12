define ss_sushi::vhost (
	Array            $env_vars     = [],
	String           $domain_name  = undef,
	Optional[Array]  $ops_env_vars = undef,
	String           $vhost_name   = $name,
	Optional[String] $apache_root  = undef,
	Optional[String] $cli_root     = undef,
) {
	if ! defined(Class['ss_sushi']) {
		fail('You must include the ss)sushi base class before using any apache defined resources')
	}

	# Install Apache vars

	if $apache_root {
		ss_sushi::apache { "${vhost_name}/10-master.conf":
			env_vars            => $env_vars,
			domain_name         => $domain_name,
			ops_env_vars        => $ops_env_vars,
			file_dir            => $apache_root,
			apache_service_name => $apache_service_name,
			owner               => $apache_owner,
			group               => $apache_group
		}
	}

	if $cli_root {
		ss_sushi::cli { "${vhost_name}/10-master.conf":
			env_vars     => $env_vars,
			domain_name  => $domain_name,
			ops_env_vars => $ops_env_vars,
			file_dir     => $cli_root,
			owner        => $cli_owner,
			group        => $cli_group
		}
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
