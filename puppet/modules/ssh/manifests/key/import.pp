# Take a public key from the common share folder and import it
# into the hosts's authorized hosts. This way the node to which the key
# belongs to can connect to the current node.
# Note: Using shareDir becuase it's shorter than shareFolder
define ssh::key::import($user, $shareDir, $key) {

  if $user == "root" {
    $user_path = "/root"
  }
  else {
    $user_path = "/home/${user}"
  }

  file { "${user_path}/.ssh/authorized_keys":
    mode    => '0755',
    owner   => $user
  }

  exec { 'Add key to authorized hosts':
    command => "cat ${shareDir}/${key} >> ${user_path}/.ssh/authorized_keys",
    path    => '/bin:/usr/bin:/sbin',
    user    => $user,
    require => File["${user_path}/.ssh/authorized_keys"]
  }
}
