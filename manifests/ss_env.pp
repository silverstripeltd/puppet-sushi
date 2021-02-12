define ss_sushi::ss_env (
	Array                $env_vars     = [],
	String               $domain_name  = undef,
	Optional[Array]      $ops_env_vars = undef,
	Stdlib::Absolutepath $file_dir     = $ss_sushi::env_file_dir,
	String               $file_name    = $ss_sushi::env_file_name,
	String               $file_owner   = $ss_sushi::env_file_user,
	String               $file_group   = $ss_sushi::env_file_group,
	String               $file_mode    = $ss_sushi::env_file_mode,
) {
	if ! defined(Class['ss_sushi']) {
		fail('You must include the ss_sushi base class before using any ss_sushi defined resources')
	}

	file { "${file_dir}/${file_name}":
		content => template('ss_sushi/ss_env.erb'),
		owner   => $file_owner,
		group   => $file_group,
		mode    => $file_mode,
	}
}
