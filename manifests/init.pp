class ss_sushi (
	Optional[Array[Stdlib::Compat::Hash]] $vhosts              = undef,
	String                                $apache_service_name = $ss_sushi::params::apache_service_name,
	String                                $apache_file_name    = '10-master.conf',
	String                                $apache_file_owner   = $ss_sushi::params::apache_file_owner,
	String                                $apache_file_group   = $ss_sushi::params::apache_file_group,
	String                                $apache_file_mode    = '0600',
	String                                $cli_ini_mode        = '0644',
	String                                $cli_file_name       = '10-master.conf',
	String                                $cli_file_owner      = $ss_sushi::params::cli_file_owner,
	String                                $cli_file_group      = $ss_sushi::params::cli_file_group,
	String                                $cli_file_mode       = '0600',
	Stdlib::Absolutepath                  $env_file_dir        = $ss_sushi::params::env_file_dir,
	String                                $env_file_name       = '_ss_environment.php',
	String                                $env_file_owner      = $ss_sushi::params::env_file_owner,
	String                                $env_file_group      = $ss_sushi::params::env_file_group,
	String                                $env_file_mode       = '0640',
) inherits ::ss_sushi::params {
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
