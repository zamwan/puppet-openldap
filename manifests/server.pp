class openldap::server::backup 
(
	String[1] $hour='*',
	String[1] $minute='*/5',
	String[1] $weekday='*',
	String[1] $path='/tmp',
	String[1] $email =  'root',
)
{


  if ! defined(Class['openldap::server']) {
        fail 'class ::openldap::server has not been evaluated'
          }
 
 file { 'backup-openldap.sh':
     ensure  => $ensure,
     path    => '/usr/local/sbin/backup-openldap.sh',
     mode    => '0700',
     owner   => 'root',
     group   => $mysql::params::root_group,
     content => template('mysql/backup-openldap.sh.erb'),
  }

<<<<<<< HEAD
  class { '::openldap::server::slapdconf': }
  case $provider {
    'augeas': {
      Class['openldap::server::install'] ->
      Class['openldap::server::slapdconf'] ~>
      Class['openldap::server::service'] ->
      Class['openldap::server']
    }
    'olc': {
      Class['openldap::server::service'] ->
      Class['openldap::server::slapdconf'] ->
      Class['openldap::server']
    }
    default: {
      fail 'provider must be one of "olc" or "augeas"'
    }
=======
  

  cron { "openldap-backup--cron":
        ensure      => $ensure,
        command     => "/usr/local/sbin/backup-openldap.sh ${path}",
        user        => $::os::params::adminuser,
        hour        => $hour,
        minute      => $minute,
        weekday     => $weekday,
        environment => [ 'PATH=/bin:/usr/bin:/usr/sbin', "MAILTO=${email}" ],
>>>>>>> 0ea53d4b18bf508cf114256318257ce12c0351c5
  }
 
}
