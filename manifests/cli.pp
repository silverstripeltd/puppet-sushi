define ss_sushi::cli (
	Array                $env_vars     = [],
	String               $domain_name  = undef,
	Optional[Array]      $ops_env_vars = undef,
	Stdlib::Absolutepath $file_dir     = undef,
	String               $ini_mode     = '0644',
	String               $file_name    = '10-master.conf',
	String               $file_owner   = 'www-data',
	String               $file_group   = 'www-data',
	String               $file_mode    = '0600',
) {
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
