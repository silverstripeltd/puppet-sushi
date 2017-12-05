# Puppet Sushi

Consolidates environment variables for Apache, CLI and `_ss_environment.php`.

Introduces the script `/usr/local/bin/sushi` that should replace all calls to `framework/cli-script.php` or `framework/sake` i.e.

```bash
/var/www/mysite/www/framework/sake dev/build

*** becomes ***

vhost=mysite /usr/local/bin/sushi dev/build
```

## How to use it

Define your variables as a key => value array

Hiera (SSP):

```yaml
# environment specific
ss_sushi::vhost_name: "mysite"
ss_sushi::vhost_root: "/var/www"
ss_sushi::apache_service_name: "httpd"
ss_sushi::domain_name: "mysite.sites.silverstripe.com"

ss_sushi::env_vars:
  SS_ENVIRONMENT_TYPE: "live"
  AWS_SYSLOG_LEVEL: "7"
  SS_DATABASE_NAME: "SS_mysite"
  SS_DATABASE_TIMEZONE: "Pacific/Auckland"
  SS_USE_SSL: true
  SS_TRUSTED_PROXY_IPS: "*"
```

Standard puppet (CWP):

```puppet
class { 'ss_sushi':
	env_vars => {
		'SS_ENVIRONMENT_TYPE' => 'live',
		'SS_DATABASE_NAME' => 'SS_mysite'
	},
	domain_name => "mysite.sites.silverstripe.com",
	vhost_name => "mysite",
	vhost_root => "/var/www",
	apache_root => "/etc/apache2/platform-variables",
	cli_root => "/etc/platform-variables"
}
```

## Adding custom vars

### _ss_environment.php

Create a file called `_ss_environment.local.php` in the same dir as `_ss_environment.php` with your variables. This is automatically included.

### CLI

Create a file called `local.conf` in `/etc/platform-variables/<vhost>` - there should be a file called `10-master.conf` there. Once created, it should be called in via sushi - which checks for `*.conf`.

### Apache

Create a file called `local.conf` in `/etc/apache2/platform-variables/<vhost>` - there should be a file called `10-master.conf` there. Once created, make sure you reload apache - `sudo /etc/init.d/apache2 reload` - to add the env vars in.


## Contribute

Use `develop` branch.

Run `puppet-lint --no-hard_tabs-check --no-2sp_soft_tabs-check --fix .` in the module root to get the syntax all nicey.

Install with `gem install puppet-lint` else you might end up with a too-low version of `puppet-lint`.
