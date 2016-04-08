define openldap::server::backup 
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
     content => template('openldap/backup-openldap.sh.erb'),
  }

  

  cron { "openldap-backup--cron":
        ensure      => $ensure,
        command     => "/usr/local/sbin/backup-openldap.sh ${path}",
        user        => $::os::params::adminuser,
        hour        => $hour,
        minute      => $minute,
        weekday     => $weekday,
        environment => [ 'PATH=/bin:/usr/bin:/usr/sbin', "MAILTO=${email}" ],
  }
 
}
