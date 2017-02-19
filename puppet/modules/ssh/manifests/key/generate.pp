# Generates a private-public key pair and the empty ssh config file
define ssh::key::generate($user, $group) {

  if $user == "root" {
    $user_path = "/root"
  }
  else {
    $user_path = "/home/${user}"
  }

  exec { 'Generate common public key':
    command => "ssh-keygen -t rsa -P '' -f ${user_path}/.ssh/id_dsa",
    user    => $user,
    path    => '/bin:/usr/bin:/sbin',
    onlyif  => "test ! -f ${user_path}/.ssh/id_dsa"
  }

  file { "/home/${user}/.ssh/config":
    mode    => '0755',
    owner   => $user,
#    group   => $group,
    require => Exec['Generate common public key']
  }
}
