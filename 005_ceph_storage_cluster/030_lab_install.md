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
if applicable: participants provision neighbour's node<br/>
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

    # visudo 

adjust/disable firewall

    # systemctl stop firewalld.service
    # systemctl disable firewalld.service

adjust/disable SELinux/AppArmor

    # setenforce 0

~~~SECTION:notes~~~
not needed in Netways Ecosphere:<br/>
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm<br/>
sudo yum --enablerepo=elrepo-kernel install kernel-ml<br/>
sudo yum install yum-plugin-priorities --enablerepo=rhel-7-server-optional-rpms<br/>
passwordless sudo/disable requiretty<br/>
Absolutely disable firewall!
~~~ENDSECTION~~~

!SLIDE small
# Commands: ceph-deploy - 1 

<br/>

push the config to the storage nodes

    $ ceph-deploy config push node-{1,2,3,4,5}

list and zap disks

    $ ceph-deploy disk list <node>
    $ ceph-deploy disk zap <node>:<device>
     

!SLIDE small
# Commands: ceph-deploy - 2 


<br/>

prepare OSDs

    $ ceph-deploy osd prepare <node>:sdb:/dev/ssd
    $ ceph-deploy osd prepare <node>:sdc:/dev/ssd

activate OSDs (maybe udev handles this automatically)

    $ ceph-deploy osd activate <node>:/dev/sdb1:/dev/ssd1
    $ ceph-deploy osd activate <node>:/dev/sdc1:/dev/ssd2

or create (prepare+activate)

    $ ceph-deploy osd create <node>:sdb:/dev/ssd1
    $ ceph-deploy osd create <node>:sdc:/dev/ssd2

swift and easy:
   
    $ ceph-deploy osd create --data /dev/sdX $hostname
    
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

    $ ssh-keygen
    $ ssh-copy-id training@training-0xx

<br/>

create .ssh/config for easier deployment 

    $ cat .ssh/config
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

    # cat << EOM > /etc/yum.repos.d/ceph-deploy.repo<br/>
      [ceph-noarch]<br/>
      name=Ceph noarch packages<br/>
      baseurl=https://download.ceph.com/rpm-mimic/el7/noarch<br/>
      enabled=1<br/>
      gpgcheck=1<br/>
      type=rpm-md<br/>
      gpgkey=https://download.ceph.com/keys/release.asc<br/>
      EOM<br/>

    # yum update -y && yum install ntp ntpdate ntp-doc ceph-deploy screen -y

~~~SECTION:notes~~~
swift check with 'yum provides ceph-deploy'
~~~ENDSECTION~~~

!SLIDE small
# Lab: Steps - deploy the cluster - 1

generate default config and monitor keyring

    $ mkdir my-cluster; cd my-cluster
    $ ceph-deploy new training-0xx [training-0xy]

set public and cluster network
    
    $ vim ceph.conf
    ...
    [global]
    mon_host: $localIP
    public_network = 192.168.78.0/24
    cluster_network = 192.168.78.0/24
    rbd_default_features = 1
    ...

reset clusterid/fsid (just in the LAB!)

    fsid = dfbabe59-8ae3-4f41-896e-c0032c60e7dc

---

overwrite [ceph.mon.keyring](../file/_files/share/ceph.mon.keyring) (just in the LAB!)


!SLIDE small
# Lab: Steps - deploy the cluster - 2
<br/>

install ceph on your other nodes

    $ ceph-deploy install training-0xx [training-0xy]

<br/>

deploy the monitor, admin and mgr nodes

    $ ceph-deploy mon create-initial
    $ ceph-deploy admin [$HOSTNAME]
    $ ceph-deploy mgr [$HOSTNAME]
 
~~~SECTION:notes~~~

~~~ENDSECTION~~~

!SLIDE small
# Lab: Steps - deploy the cluster - 3
<br/>
On all nodes!

create OSD directory (just in the lab! Use "real" block devices in a real setup)
    
    $ mkdir -p ~/my-cluster/osd-$HOSTNAME

create a file for later use
    
    $ fallocate -l 30G 30GB.img

test it 

    # losetup -l -P /dev/loop1 "/home/training/my-cluster/osd-$HOSTNAME/30GB.img"
    # wipefs -a /dev/loop1
    # lsblk

!SLIDE small
# Lab: Steps - deploy the cluster - 4
<br/>
make it reboot safe via [rebloop.sh](../file/_files/share/rebloop.sh) and [rebloop.service](../file/_files/share/rebloop.service)
    
    # chmod +x rebloop.*
    # cp rebloop.sh /usr/bin/rebloop.sh
    # cp rebloop.service /etc/systemd/system
    # systemctl enable rebloop.service
    # systemctl start rebloop.service

replace cephs original disk.py with the modified [disk.py](../file/_files/share/disk.py)
    
    # cp disk.py /usr/lib/python2.7/site-packages/ceph_volume/util/disk.py

~~~SECTION:notes~~~
you may want to use /etc/rc.local instead
~~~ENDSECTION~~~

!SLIDE small
# Lab: Steps - deploy the cluster - 4
<br/>

deploy OSDs

    $ ceph-deploy osd create --data /dev/loop1 $HOSTNAME

create your first pool
     
    # ceph osd pool create rbd 100 100 replicated

examine ceph status
    
    # ceph status

tag the pool with an application

    # ceph osd pool application enable rbd rbd      

   
~~~SECTION:notes~~~
rbd pool init <poolname> might work as well<br/>
Tagging's not necessary yet. Meant to prevent confusion within the admins.
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
