define openldap::server::backup 
(
	Integer $index, 
	String[1] $suffix = $title,
	String[1] $hour='*',
	String[1] $minute='*/5',
	String[1] $weekday='*',
	String[1] $path='/tmp',
	String[1] $email = $::servermonitor
)
{
    
 
  if ! defined(Class['openldap::server']) {
        fail 'class ::openldap::server has not been evaluated'
          }

  $cron_command = "slapcat -b \"${suffix}\"|gzip > \"${path}/openldap-${index}.ldif.gz\""
  
  cron { "slapcat-backup-${index}-cron":
        ensure      => $ensure,
        command     => $cron_command,
        user        => $::os::params::adminuser,
        hour        => $hour,
        minute      => $minute,
        weekday     => $weekday,
        environment => [ 'PATH=/bin:/usr/bin:/usr/sbin', "MAILTO=${email}" ],
  }
 
}
