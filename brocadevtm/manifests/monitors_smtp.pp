# === Class: brocadevtm::monitors_smtp
#
# This class is a direct implementation of brocadvtm::monitors
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::monitors_smtp (
  $ensure = present,
  $basic__back_off       = true,
  $basic__delay          = 5,
  $basic__failures       = 3,
  $basic__machine        = undef,
  $basic__note           = undef,
  $basic__scope          = "pernode",
  $basic__timeout        = 5,
  $basic__type           = "tcp_transaction",
  $basic__use_ssl        = false,
  $basic__verbose        = false,
  $http__authentication  = undef,
  $http__body_regex      = undef,
  $http__host_header     = undef,
  $http__path            = "/",
  $http__status_regex    = "^[234][0-9][0-9]\\\$",
  $rtsp__body_regex      = undef,
  $rtsp__path            = "/",
  $rtsp__status_regex    = "^[234][0-9][0-9]\\\$",
  $script__arguments     = [],
  $script__program       = undef,
  $sip__body_regex       = undef,
  $sip__status_regex     = "^[234][0-9][0-9]\\\$",
  $sip__transport        = "udp",
  $tcp__close_string     = "QUIT\r\n",
  $tcp__max_response_len = 2048,
  $tcp__response_regex   = "^220 [^\n]+\n",
  $tcp__write_string     = undef,
  $udp__accept_all       = false,
){
  include brocadevtm
  $ip      = $brocadevtm::rest_ip
  $port    = $brocadevtm::rest_port
  $user    = $brocadevtm::rest_user
  $pass    = $brocadevtm::rest_pass

  info ("Configuring monitors_smtp ${name}")
  vtmrest { "monitors/SMTP":
    ensure     => $ensure,
    endpoint   => "https://${ip}:${port}/api/tm/3.3/config/active",
    username   => $user,
    password   => $pass,
    content    => template('brocadevtm/monitors.erb'),
    type       => 'application/json',
    internal   => 'monitors_smtp',
    debug      => 0,
  }
}
