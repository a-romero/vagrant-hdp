# The master configuration for the hosts when connecting to the slaves
define hosts::populate(
    $master_name,
    $node_base_name,
    $domain_subfix,
    $cluster_size,
    $base_ip
) {

  resources { 'host':
    purge => true
  }

  host { 'add master':
    name  => "${master_name}${domain_subfix}",
    ip    => "${base_ip}0"
  }

  hosts::addnodes { "add ${node_base_name}${cluster_size}${domain_subfix}":
    count => $cluster_size,
    base_ip  => $base_ip,
    base_name => $node_base_name,
    domain_subfix => $domain_subfix
  }
}
