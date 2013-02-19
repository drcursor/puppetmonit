class monit (
	$daemon_refresh = "120"
) {

    $configdir = "/etc/monit/conf.d"

    case $operatingsystem {
        'Ubuntu': { $config = "/etc/monitrc" }
	'Debian': { $config = "/etc/monit/monitrc" }
        'CentOS': { $config = "/etc/monit.conf" }
        default: { fail("\$operatingsystem of ${fqdn} is not recognized ( '${operatingsystem}' ). ") }
    }

    $monitrc = "monit/monitrc.erb"

    package {
        "monit": ensure => installed;
    }

    service { monit:
        ensure => running,
        require => Package["monit"],
        provider => init;
    }

    file { 
        $configdir:
            ensure => directory;
        $config:
            ensure => present,
            content => template($monitrc),
            group => root,
            require => File[$configdir],
            notify => Service[monit],
            mode => 0700;
    }    
}

define monit::package()
{
    file { $name:
            path => "$monit::configdir/${name}.conf",
            ensure => present,
            content => template("monit/${name}.conf.erb"),
            group => root,
            require => File[$monit::configdir],
            notify => Service[monit],
            mode => 0700;
    }
}


