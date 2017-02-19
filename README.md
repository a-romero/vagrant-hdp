# vagrant-hdp
 
This vagrant file will deploy a cluster with an Ambari Server and whichever defined number of nodes with the Ambari Agent service installed. From that point, blueprints can be created and applied.

By default:

- Ambari Server has 2GB RAM
- The cluster nodes has 3GB RAM

To change the number of cluster nodes edit the VagrantFile and change the parameter *cluster_size*

>cluster_size = 1


## How to create the cluster using Vagrant and VirtualBox ##

1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads "VirtualBox Downloads")
2. Download and install [Vagrant](https://www.vagrantup.com/downloads.html "Vagrant Downloads")
3. Open a console and navigate to the folder where the *Vagrantfile* file is located
4. Run the command `vagrant up` to launch the machines creation and provision.
5. Once the process finishes, check the Ambari Server IP address and you can access it from the browser:

 ssh ambarimaster.cluster -c "ip address show <iface> | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//'"

6. It's possible to suspend and resume the cluster machines using the commands `vagrant suspend` and `vagrant resume`
7. To ssh into the nodes: `ssh node-x.cluster`
8. To destroy the cluster use the command `vagrant destroy`

## Applying Blueprints ##

Example to create cluster:

curl -H "X-Requested-By: admin" --user admin:admin -X POST http://ambarimaster.cluster:8080/api/v1/blueprints/4-NODE_BLUEPRINT?validate_topology=false --data "@4-node-blueprint.json"

curl -H "X-Requested-By: admin" --user admin:admin -X POST http://ambarimaster.cluster:8080/api/v1/clusters/ARTEST25 --data "@host_mapping.json"

