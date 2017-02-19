# VM-Configuration of an ambari agent that is monitored by the ambari server.

# Turn off interfering services
class { 'interfering_services': }->
# Install and enable ntp
class { 'ntp': }->

package { 'openssh-server': ensure => 'installed' } ->

hosts::populate { 'add ips to hosts file':
  master_name     => $master_hostname,
  node_base_name  => $node_base_name,
  domain_subfix   => $domain_subfix,
  cluster_size    => $cluster_size,
  base_ip         => $base_ip
}->

/*
# @todo: Refactor the dependencies so that this doesn't get called
# just so that the ssh file structure gets created
ssh::key::generate{ 'slave key':
  user      => $user,
  group     => $user,
  #require   => Identity::User::Add["Add user ${user}"]
} ->

ssh::key::import{ 'import master key to slave':
  user      => $user,
  shareDir  => $share_path,
  key       => $shared_key,
  require   => Ssh::Key::Generate['slave key']
}
*/

# Install and enable ambari agent
class { 'ambari_agent':
  ownhostname    => "${node_base_name}${node_index}${domain_subfix}",
  serverhostname => "${master_hostname}${domain_subfix}"
}
