First version of openldap::server::backup that creates crontab backups

Add this in site.pp

openldap::server::backup { 'dc=test,dc=verhoeks,dc=nl':
    index => 1,
    email => 'root',
}

openldap::server::backup { 'cn=config':
     index  => 0,
     email => 'root',
 }

 
 Available Parameters
 
 Integer $index, 
	String[1] $suffix = $title,
	String[1] $hour='*',
	String[1] $minute='5',
	String[1] $weekday='*',
	String[1] $path='/tmp',
	String[1] $email = $::servermonitor
