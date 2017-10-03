# Puppet Sushi

Provides the ability to define ENV Vars for apache and CLI. Particularly important for SS4.

## How to use it

Define your variables as a key => value array

Hiera:

```yaml
ss_sushi::env_vars:
  SS_ENVIRONMENT_TYPE: "live"
  AWS_REGION_NAME: "ap-southeast-2"
  AWS_SYSLOG_LEVEL: "7"
  SS_DATABASE_SERVER: "localhost"
  SS_DATABASE_NAME: "SS_mysite"
  SS_DATABASE_TIMEZONE: "Pacific/Auckland"
  SS_USE_SSL: true
  SS_TRUSTED_PROXY_IPS: "*"
ss_sushi::vhost: "mysite"
ss_sushi::vhost_root: "/var/www/"
```

Standard puppet (I think this is wrong):

```puppet
ss_sushi {
  env_vars => [
    "SS_ENVIRONMENT_TYPE" => "live",
    "AWS_REGION_NAME" => "ap-southeast-2",
    "AWS_SYSLOG_LEVEL" => "7",
    "SS_DATABASE_SERVER" => "localhost",
    "SS_DATABASE_NAME" => "SS_mysite",
    "SS_DATABASE_TIMEZONE" => "Pacific/Auckland",
    "SS_USE_SSL" => true,
    "SS_TRUSTED_PROXY_IPS" => "*",
  ],
  vhost => "mysite",
  vhost_root => "/var/www/"
}
```
