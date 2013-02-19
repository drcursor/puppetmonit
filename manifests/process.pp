define monit::process (
	$process_name,
	$process_pid = "/var/run/${process_name}.pid",
	$process_start = "/etc/init.d/${process_name} start",
	$process_stop = "/etc/init.d/${process_name} stop",
	$process_host = "127.0.0.1",
	$process_port,
	$process_protocol,
	$template = 'monit/process.erb',
  ) {

  include monit

  file { "${process_name}-${process_port}.conf":
    path    => "${monit::configdir}/${process_name}-${process_port}.conf",
    content => template($template),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package['monit'],
    notify  => Service['monit'],
  }


}
