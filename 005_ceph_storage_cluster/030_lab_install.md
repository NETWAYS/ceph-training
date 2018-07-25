!SLIDE
#~~~SECTION:MINOR~~~ Lab: Install and deploy


!SLIDE smbullets noprint
# Lab: Objectives

* after this section you will know
 * how to prepare and deploy a new cluster with ceph-deploy
 * how to put and retrieve objects with the rados cli
 * how to examine where the objects get stored

~~~SECTION:notes~~~
what is needed for a cluster?

Lab Setup:<br/>

one collective Cluster<br/>
OSDs on Laptops<br/>
Monitor on Trainer's Laptop <br/>

Later: Laptops as KVM Nodes
Further steps: Cluster expansion, recreate failures
~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab: Installation

ceph-deploy 

* helper to deploy cluster and nodes from a central point (e.g. your laptop)
* well documented
* suitable for small and midsized clusters

<br/>

puppet, chef, ansible, whatever

* good if you use uniform hardware setups
* Modules/Cookbooks are available and actively maintained
* Puppet: https://github.com/ceph/puppet-ceph


!SLIDE
# Lab: Installation with ceph-deploy

<center><img src="./_images/ceph-deploy.png" style="max-width:70%;height:auto;" alt="ceph-deploy"/></center>

~~~SECTION:notes~~~
every laptop is Adminnode<br/>
for this we need a common Keyring<br/>
if applicable: participants provision neghbour's node<br/>
~~~ENDSECTION~~~

!SLIDE smbullets
# Tasks: prepare storage nodes

* test connectivity to all nodes
* add training-XX.netways.local to /etc/hosts
* allow passwordless sudo
* install screen
* disable requiretty for ssh logins
* adjust firewall

!SLIDE small
# Lab: Steps - prepare storage nodes - 1

test connectivity to all nodes

    # ping training-xxx.netways.local

add training-xxx.netways.local to /etc/hosts

    # cat /etc/hosts
    192.168.78.1 training-001 training-001.netways.local
    192.168.78.2 training-002 training-002.netways.local
    192.168.78.33 training-033 training-033.netways.local

install screen

    # sudo yum install -y  screen

!SLIDE small
# Lab: Steps - prepare storage nodes - 2

allow passwordless sudo

    # echo "training ALL = (root) NOPASSWD:ALL" | sudo tee \
      /etc/sudoers.d/training
    # sudo chmod 0440 /etc/sudoers.d/training

disable requiretty for ssh logins (!requiretty)

    # sudo visudo 

adjust/disable firewall

    # sudo systemctl stop firewalld.service
    # sudo systemctl disable firewalld.service

adjust/disable SELinux/AppArmor

    # sudo vim /etc/sysconfig/selinux

~~~SECTION:notes~~~
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm<br/>
sudo yum --enablerepo=elrepo-kernel install kernel-ml<br/>

//sudo yum install yum-plugin-priorities --enablerepo=rhel-7-server-optional-rpms
~~~ENDSECTION~~~

!SLIDE small
# Commands: ceph-deploy - 1 

<br/>

push the config to the storage nodes

    # ceph-deploy config push node-{1,2,3,4,5}

list and zap disks

    # ceph-deploy disk list <node>
    # ceph-deploy disk zap <node>:<device>
     

!SLIDE small
# Commands: ceph-deploy - 2 


<br/>

prepare OSDs

    # ceph-deploy osd prepare <node>:sdb:/dev/ssd
    # ceph-deploy osd prepare <node>:sdc:/dev/ssd

activate OSDs (maybe udev handles this automatically)

    # ceph-deploy osd activate <node>:/dev/sdb1:/dev/ssd1
    # ceph-deploy osd activate <node>:/dev/sdc1:/dev/ssd2

or create (prepare+activate)

    # ceph-deploy osd create <node>:sdb:/dev/ssd1
    # ceph-deploy osd create <node>:sdc:/dev/ssd2


!SLIDE smbullets small
# Tasks: Steps - prepare admin node

* create a password-less key pair on the admin machine and copy the pub key to the nodes
* create .ssh/config for easier deployment

* Install ceph-deploy on your machine
* generate default config and key
 * set network config 
 * we overwrite the key and fsid
* install ceph on your neighbour's machine
* deploy a monitor on your neighbour's machine
* deploy an osd on your neighbour's machine

!SLIDE small
# Lab: Steps - prepare admin node - 1

* ssh into trainers notebook
* start screen session "screen -L -S $name"
* screen -list -> screen -x $Session-ID

create a password-less key pair only on the admin machine and copy the pub key to the previously prepared nodes

    # ssh-keygen
    # ssh-copy-id training@training-0xx

<br/><br/>

create .ssh/config for easier deployment 

    # cat .ssh/config
    Host training-*
     User training

    # chmod 0600 .ssh/config
~~~SECTION:notes~~~
no need in Netways Basic setup
~~~ENDSECTION~~~

!SLIDE small
# Lab: Steps - prepare admin node - 2

<br/><br/>

Install ceph-deploy on your machine

Create ceph-deploy.repo
<br/><br/>
   # cat /etc/yum.repos.d/ceph-deploy.repo
   
  [ceph-noarch] <br/>
  name=Ceph noarch packages <br/>
  baseurl=http://download.ceph.com/rpm-luminous/el7/noarch <br/>
  enabled=1 <br/>
  gpgcheck=1 <br/>
  type=rpm-md <br/>
  gpgkey=https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc<br/>

 # sudo yum update && sudo yum install ceph-deploy-1.5.39-0.noarch


!SLIDE small
# Lab: Steps - deploy the cluster - 1

generate default config and monitor keyring

    # mkdir my-cluster; cd my-cluster
    # ceph-deploy new training-0xx [training-0xy]

set public and cluster network
    
    # vim ceph.conf
    ...
    [global]
    mon_host: $localIP
    public_network = 192.168.78.0/24
    cluster_network = 192.168.78.0/24
    rbd_default_features = 1
    ...

---

overwrite [ceph.mon.keyring](../file/_files/share/ceph.mon.keyring) (just in the LAB!)


reset clusterid/fsid (just in the LAB!)

    # fsid = dfbabe59-8ae3-4f41-896e-c0032c60e7dc

!SLIDE small
# Lab: Steps - deploy the cluster - 2
<br/>

install ceph on your other nodes

    # ceph-deploy install training-0xx [training-0xy]

<br/>

deploy the monitor, admin and mgr nodes

    # ceph-deploy mon create-initial
    # ceph-deploy admin [$HOSTNAME]
    # ceph-deploy mgr [$HOSTNAME]
Mgr only for Luminous! 
~~~SECTION:notes~~~
For Luminous (may the Gods be with you) <br/>

ceph-deploy install training-0xx [training-0xy] --repo-url=http://download.ceph.com/rpm-luminous/el7 --gpg-url=https://download.ceph.com/keys/release.asc
<br/>

ceph-deploy gatherkeys monhost <br/>

ceph-deploy admin monhost <br/>

~~~ENDSECTION~~~

!SLIDE small
# Lab: Steps - deploy the cluster - 3
<br/><br/>
On all nodes!

create OSD directory (just in the lab! Use block devices in a real setup)

    # sudo mkdir /var/local/osd-$HOSTNAME
    # sudo chown ceph. /var/local/osd-$HOSTNAME

<br/>

deploy OSDs

    # ceph-deploy osd prepare training-$ID:/var/local/osd-$HOSTNAME
    # ceph-deploy osd activate training-$ID:/var/local/osd-$HOSTNAME
~~~SECTION:notes~~~
Luminous: fallocate 10GB .img, loseteup it to loop0 device, mount it, mkf.xfs it, unmount it and try to deploy osd there <br/>

May break!
~~~ENDSECTION~~~

!SLIDE noprint
# Holistic
<center><img src="./../../_images/holistic.png" style="width:800px;height:600px " alt="matrixofhell"/></center>

!SLIDE small
# Commands: Examine your Ceph Storage Cluster - 1

list all pools

    # ceph osd lspools
  
get number of replicas for a pool

    # ceph osd pool get <pool> size

get the min_size for a pool

    # ceph osd pool get <pool> min_size

list the PGs

    # ceph pg dump

get PG distribution

    # ceph osd utilization

!SLIDE small
# Commands: Examine your Ceph Storage Cluster - 2

list all objects

    # ceph pg ls

list the cluster capacity

    # rados df

get osd stat

    # ceph osd stat

get osd usage

    # ceph osd df
