# === Define: brocadevtm::traffic_managers
#

define brocadevtm::traffic_managers (
  $ensure,
  $basic__adminMasterXMLIP                = "0.0.0.0",
  $basic__adminSlaveXMLIP                 = "0.0.0.0",
  $basic__appliance_sysctl                = [],
  $basic__authenticationServerIP          = "0.0.0.0",
  $basic__cloud_platform                  = "",
  $basic__location                        = "",
  $basic__nameip                          = "",
  $basic__num_aptimizer_threads           = 0,
  $basic__num_children                    = 0,
  $basic__numberOfCPUs                    = 0,
  $basic__restServerPort                  = 0,
  $basic__trafficip                       = [],
  $basic__updaterIP                       = "0.0.0.0",
  $appliance__gateway_ipv4                = "",
  $appliance__gateway_ipv6                = "",
  $appliance__hostname                    = "",
  $appliance__hosts                       = [],
  $appliance__if                          = [],
  $appliance__ip                          = [],
  $appliance__ipv4_forwarding             = false,
  $appliance__licence_agreed              = false,
  $appliance__manageec2conf               = true,
  $appliance__manageiptrans               = true,
  $appliance__managereturnpath            = true,
  $appliance__managevpcconf               = true,
  $appliance__name_servers                = [],
  $appliance__ntpservers                  = ["0.riverbed.pool.ntp.org", "1.riverbed.pool.ntp.org", "2.riverbed.pool.ntp.org", "3.riverbed.pool.ntp.org"],
  $appliance__routes                      = [],
  $appliance__search_domains              = [],
  $appliance__shim_client_id              = "",
  $appliance__shim_client_key             = "",
  $appliance__shim_enabled                = false,
  $appliance__shim_ips                    = "",
  $appliance__shim_load_balance           = "round_robin",
  $appliance__shim_log_level              = "notice",
  $appliance__shim_mode                   = "portal",
  $appliance__shim_portal_url             = "",
  $appliance__shim_proxy_host             = "",
  $appliance__shim_proxy_port             = "",
  $appliance__ssh_enabled                 = true,
  $appliance__ssh_port                    = 22,
  $appliance__timezone                    = "US/Pacific",
  $appliance__vlans                       = [],
  $cluster_comms__allow_update            = true,
  $cluster_comms__bind_ip                 = "*",
  $cluster_comms__external_ip             = "",
  $cluster_comms__port                    = 9080,
  $ec2__trafficips_public_enis            = [],
  $fault_tolerance__ospfv2_ip             = "",
  $fault_tolerance__ospfv2_neighbor_addrs = ["%gateway%"],
  $java__port                             = 9060,
  $rest_api__bind_ips                     = ["*"],
  $rest_api__port                         = 9070,
  $snmp__allow                            = ["all"],
  $snmp__auth_password                    = "",
  $snmp__bind_ip                          = "*",
  $snmp__community                        = "public",
  $snmp__enabled                          = false,
  $snmp__hash_algorithm                   = "md5",
  $snmp__port                             = "default",
  $snmp__priv_password                    = "",
  $snmp__security_level                   = "noauthnopriv",
  $snmp__username                         = "",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring traffic_managers ${name}")
  vtmrest { "traffic_managers/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/traffic_managers.erb'),
    internal => 'traffic_managers',
    debug => 0,
  }
}