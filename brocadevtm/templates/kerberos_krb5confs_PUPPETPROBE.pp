# === Define: brocadevtm::kerberos_krb5confs_PUPPETPROBE
#

define brocadevtm::kerberos_krb5confs_PUPPETPROBE (
  $ensure,
  $file,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring kerberos_krb5confs_PUPPETPROBE ${name}")
  vtmrest { "kerberos/krb5confs/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => file($file),
    type => 'application/octet-stream',
    debug => 0,
  }
}