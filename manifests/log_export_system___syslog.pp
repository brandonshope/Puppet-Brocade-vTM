# === Class: brocadevtm::log_export_system___syslog
#
# This class is a direct implementation of brocadvtm::log_export
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::log_export_system___syslog (
  $ensure                = present,
  $basic__appliance_only = true,
  $basic__enabled        = true,
  $basic__files          = '["/var/log/syslog*"]',
  $basic__history        = 'none',
  $basic__history_period = 10,
  $basic__metadata       = '[{"name":"sourcetype","value":"syslog"},{"name":"source","value":"syslog"}]',
  $basic__note           = 'The operating system\'s syslog.',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring log_export_system___syslog ${name}")
  vtmrest { 'log_export/System%20-%20syslog':
    ensure   => $ensure,
    before   => Class[Brocadevtm::Purge],
    endpoint => "https://${ip}:${port}/api/tm/4.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/log_export.erb'),
    type     => 'application/json',
    internal => 'log_export_system___syslog',
    failfast => $brocadevtm::failfast,
    debug    => 0,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/log_export", {ensure => present})
    file_line { 'log_export/System%20-%20syslog':
      line => 'log_export/System%20-%20syslog',
      path => "${purge_state_dir}/log_export",
    }
  }
}