define ss_sushi::apache (
	Array                $env_vars            = [],
	String               $domain_name         = undef,
	Optional[Array]      $ops_env_vars        = undef,
	Stdlib::Absolutepath $file_dir            = undef,
	String               $file_name           = '10-master.conf',
	String               $file_owner          = 'www-data',
	String               $file_group          = 'www-data',
	String               $file_mode           = '0600',
	String               $apache_service_name = 'httpd',
) {
	file { "${file_dir}/${file_name}":
		content => template('ss_sushi/apache.erb'),
		owner   => $file_owner,
		group   => $file_group,
		mode    => $file_mode,
		notify  => Service[$apache_service_name],
	}
}
