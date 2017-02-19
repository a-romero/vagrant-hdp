# Move the public key to a folders that is supposed to be shared between
# the cluster's node. This way, the slaves can import the master's
# public key
define ssh::key::export($user, $shareFolder, $key, $export_private_key) {

  if $user == "root" {
    $user_path = "/root"
  }
  else {
    $user_path = "/home/${user}"
  }

  Exec {
    path  => '/bin:/usr/bin:/sbin',
    user  => 'root'
  }

  exec { 'Clean destination':
    command => "rm -f ${shareFolder}/${key} && rm -f ${shareFolder}/private_${key}"
  }

  exec { 'Copy public key to shared location':
    command => "cp ${user_path}/.ssh/id_dsa.pub ${shareFolder}/${key}",
    require => Exec['Clean destination']
  }

  if ($export_private_key) {
    exec { 'Copy private key to shared location':
      command => "cp ${user_path}/.ssh/id_dsa ${shareFolder}/private_${key}",
      require => Exec['Clean destination']
    }
  }
}
