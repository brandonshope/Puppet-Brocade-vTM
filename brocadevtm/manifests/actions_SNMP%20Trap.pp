# === Class: brocadevtm::actions_SNMP%20Trap
#

class brocadevtm::actions_SNMP%20Trap (
  $ensure = present,
  $basic__note                 = "",
  $basic__syslog_msg_len_limit = 1024,
  $basic__timeout              = 60,
  $basic__type                 = "trap",
  $basic__verbose              = false,
  $email__server               = "",
  $email__to                   = [],
  $log__file                   = "",
  $log__from                   = "stingraytrafficmanager@%hostname%",
  $program__arguments          = [],
  $program__program            = "",
  $soap__additional_data       = "",
  $soap__password              = "",
  $soap__proxy                 = "",
  $soap__username              = "",
  $syslog__sysloghost          = "",
  $trap__auth_password         = "",
  $trap__community             = "",
  $trap__hash_algorithm        = "md5",
  $trap__priv_password         = "",
  $trap__traphost              = "",
  $trap__username              = "",
  $trap__version               = "snmpv1",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring actions_SNMP%20Trap ${name}")
  vtmrest { "actions/SNMP%20Trap":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/actions_SNMP%20Trap.erb'),
    internal => 'actions_SNMP%20Trap',
    debug => 0,
  }
}