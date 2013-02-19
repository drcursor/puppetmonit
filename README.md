puppetmonit
===========

Monit module for Puppet

Usage
-----

A simple example might be:

        class {'monit':}

        monit::process { 'papache2':
                process_name => 'apache2',
                process_port => '80',
                process_protocol => 'http',
        }

An example with some more options

        class {'monit':
                daemon_refresh => '120',
        }
	
	monit::process { 'papache2':
                process_name => 'apache2',
                process_port => '80',
                process_protocol => 'http',
		process_host => '192.168.0.2',
		process_start => '/etc/init.d/apache start',
		process_stop => '/etc/init.d/apache stop',
		process_pid => '/var/run/apache.pid',
        }
