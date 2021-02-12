define ss_sushi::ss_env (
	Array                $env_vars     = [],
	String               $domain_name  = undef,
	Optional[Array]      $ops_env_vars = undef,
	Stdlib::Absolutepath $file_dir     = '/var/www',
	String               $file_name    = '_ss_environment.php',
	String               $file_owner   = 'www-data',
	String               $file_group   = 'www-data',
	String               $file_mode    = '0640',
) {
	file { "${file_dir}/${file_name}":
		content => template('ss_sushi/ss_env.erb'),
		owner   => $file_owner,
		group   => $file_group,
		mode    => $file_mode,
	}
}
