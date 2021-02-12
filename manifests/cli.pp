define ss_sushi::cli (
	Array                $env_vars     = [],
	String               $domain_name  = undef,
	Optional[Array]      $ops_env_vars = undef,
	Stdlib::Absolutepath $file_dir     = undef,
	String               $ini_mode     = $ss_sushi::cli_ini_mode,
	String               $file_name    = $ss_sushi::cli_file_name,
	String               $file_owner   = $ss_sushi::cli_file_owner,
	String               $file_group   = $ss_sushi::cli_file_group,
	String               $file_mode    = $ss_sushi::cli_file_mode,
) {
	if ! defined(Class['ss_sushi']) {
		fail('You must include the ss_sushi base class before using any ss_sushi defined resources')
	}

	file { "${file_dir}/deploy.ini":
		ensure => present,
		owner  => $file_owner,
		group  => $file_group,
		source => 'puppet:///modules/ss_sushi/deploy.ini',
		mode   => $ini_mode,
	}

	file { "${file_dir}/${file_name}":
		content => template('ss_sushi/cli.erb'),
		owner   => $file_owner,
		group   => $file_group,
		mode    => $file_mode,
	}
}
