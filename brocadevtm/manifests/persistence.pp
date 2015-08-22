# === Define: brocadevtm::persistence
#
# Session Persistence Class
# A session persistence class is used to identify the session a new connection belongs too and deliver it to the same backend node.
#
# === Parameters
#
# [*basic__cookie*]
# The cookie name to use for tracking session persistence.
#
# [*basic__delete*]
# Whether or not the session should be deleted when a session failure occurs. (Note, setting a failure mode of 'choose a new node' implicitly deletes the session.)
#
# [*basic__failure_mode*]
# The action the pool should take if the session data is invalid or it cannot contact the node specified by the session.
#
# [*basic__note*]
# A description of the session persistence class.
#
# [*basic__type*]
# The type of session persistence to use.
#
# [*basic__url*]
# The redirect URL to send clients to if the session persistence is configured to redirect users when a node dies.
# 
# === Examples
# 
# brocadevtm::persistence { 'example': 
#     ensure => present,
# }
# 
# 
# === Authors
# 
# Mark Boddington <mbodding@brocade>
# 
# === Copyright
# 
# Copyright 2015 Brocade
# 
define brocadevtm::persistence (
  $ensure,
  $basic__cookie       = "",
  $basic__delete       = true,
  $basic__failure_mode = "new_node",
  $basic__note         = "",
  $basic__type         = "ip",
  $basic__url          = "",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring persistence ${name}")
  vtmrest { "persistence/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/persistence.erb'),
    type => 'application/json',
    internal => 'persistence',
    debug => 0,
  }
}
