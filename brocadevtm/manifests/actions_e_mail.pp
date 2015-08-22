# === Class: brocadevtm::actions_e_mail
#
# This class is a direct implementation of brocadvtm::actions
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::actions_e_mail (
  $ensure = present,
  $basic__note                 = undef,
  $basic__syslog_msg_len_limit = 1024,
  $basic__timeout              = 60,
  $basic__type                 = "email",
  $basic__verbose              = false,
  $email__server               = undef,
  $email__to                   = [],
  $log__file                   = undef,
  $log__from                   = "stingraytrafficmanager@%hostname%",
  $program__arguments          = [],
  $program__program            = undef,
  $soap__additional_data       = undef,
  $soap__password              = undef,
  $soap__proxy                 = undef,
  $soap__username              = undef,
  $syslog__sysloghost          = undef,
  $trap__auth_password         = undef,
  $trap__community             = undef,
  $trap__hash_algorithm        = "md5",
  $trap__priv_password         = undef,
  $trap__traphost              = undef,
  $trap__username              = undef,
  $trap__version               = "snmpv1",
){
  include brocadevtm
  $ip      = $brocadevtm::rest_ip
  $port    = $brocadevtm::rest_port
  $user    = $brocadevtm::rest_user
  $pass    = $brocadevtm::rest_pass

  info ("Configuring actions_e_mail ${name}")
  vtmrest { "actions/E-Mail":
    ensure     => $ensure,
    endpoint   => "https://${ip}:${port}/api/tm/3.3/config/active",
    username   => $user,
    password   => $pass,
    content    => template('brocadevtm/actions.erb'),
    type       => 'application/json',
    internal   => 'actions_e_mail',
    debug      => 0,
  }
}