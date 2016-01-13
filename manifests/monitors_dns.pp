# === Class: brocadevtm::monitors_dns
#
# This class is a direct implementation of brocadvtm::monitors
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::monitors_dns (
  $ensure                = present,
  $basic__back_off       = true,
  $basic__delay          = 5,
  $basic__failures       = 3,
  $basic__machine        = undef,
  $basic__note           = undef,
  $basic__scope          = 'pernode',
  $basic__timeout        = 5,
  $basic__type           = 'program',
  $basic__use_ssl        = false,
  $basic__verbose        = false,
  $http__authentication  = undef,
  $http__body_regex      = undef,
  $http__host_header     = undef,
  $http__path            = '/',
  $http__status_regex    = '^[234][0-9][0-9]$',
  $rtsp__body_regex      = undef,
  $rtsp__path            = '/',
  $rtsp__status_regex    = '^[234][0-9][0-9]$',
  $script__arguments     = '[{"name":"response_addr","description":"Address to expect in DNS response","value":""},{"name":"request_host","description":"The DNS monitor sends a DNS query to the DNS server running on port 53 on the monitored node.<br>Hostname to look up in DNS:","value":""}]',
  $script__program       = 'dns.pl',
  $sip__body_regex       = undef,
  $sip__status_regex     = '^[234][0-9][0-9]$',
  $sip__transport        = 'udp',
  $tcp__close_string     = undef,
  $tcp__max_response_len = 2048,
  $tcp__response_regex   = '.+',
  $tcp__write_string     = undef,
  $udp__accept_all       = false,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring monitors_dns ${name}")
  vtmrest { 'monitors/DNS':
    ensure   => $ensure,
    before   => Class[Brocadevtm::Purge],
    endpoint => "https://${ip}:${port}/api/tm/3.7/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/monitors.erb'),
    type     => 'application/json',
    internal => 'monitors_dns',
    failfast => $brocadevtm::failfast,
    debug    => 0,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/monitors", {ensure => present})
    file_line { 'monitors/DNS':
      line => 'monitors/DNS',
      path => "${purge_state_dir}/monitors",
    }
  }
}
