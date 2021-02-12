define ss_sushi::apache (
	Array                $env_vars            = [],
	String               $domain_name         = undef,
	Optional[Array]      $ops_env_vars        = undef,
	Stdlib::Absolutepath $file_dir            = undef,
	String               $file_name           = $ss_sushi::apache_file_name,
	String               $file_owner          = $ss_sushi::apache_file_owner,
	String               $file_group          = $ss_sushi::apache_file_group,
	String               $file_mode           = $ss_sushi::apache_file_mode,
	String               $apache_service_name = $ss_sushi::apache_service_name,
) {
	if ! defined(Class['ss_sushi']) {
		fail('You must include the ss_sushi base class before using any ss_sushi defined resources')
	}

	file { "${file_dir}/${file_name}":
		content => template('ss_sushi/apache.erb'),
		owner   => $file_owner,
		group   => $file_group,
		mode    => $file_mode,
		notify  => Service[$apache_service_name],
	}
}
