!SLIDE small
# Lab: QEMU and libvirt integration

!SLIDE noprint smbullets
# Lab: Objectives

* after this section you will
 * be able to integrate RBD with QEMU/libvirt
 * know how to use a libvirt secret for authentication  
 * know how to start a virtual machine using an RBD
 * how to find the objects which belong to a VM

!SLIDE small
# Lab: libvirt

* prepare virsh, libvirt and QEMU-KVM
* start a VM for testing libvirt
* create a new pool for libvirt
* provide the ceph credentials as libvirt secret
* install a VM on your rbd

!SLIDE small
# Steps: prepare virsh, libvirt and QEMU-KVM

<br/>

install qemu-kvm virsh and virt-install

    # yum install -y kvm virt-manager libvirt virt-install \
      qemu-kvm xauth dejavu-lgc-sans-fonts

enable ip_forward

    # echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/99-forward.conf
    # sysctl -p /etc/sysctl.d/99-forward.conf
      net.ipv4.ip_forward = 1

test virsh

    # virsh list

~~~SECTION:notes~~~
sudo -i might be needed for echo command <br/>
ovirt - http://paste.openstack.org/show/163327/
~~~ENDSECTION~~~

!SLIDE small
# Steps: testing libvirt

download debian netinstaller

    # wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.5.0-amd64-netinst.iso -O /tmp/debian-netinst.iso

start a VM with virt-install

    # virt-install --connect qemu:///system -n vmdeb -r 512 \
    --disk path=/var/lib/libvirt/images/vmdeb.img,size=2 \
    --graphics vnc,listen=0.0.0.0 --noautoconsole --os-type linux \
    --os-variant generic --accelerate --network=bridge:virbr0 \
    --cdrom /tmp/debian-netinst.iso --vcpus=1 --hvm 

get VNC port

    # virsh vncdisplay vmdeb
    

~~~SECTION:notes~~~
VNC Viewer e.g. remmina, default port 5900, Ctrl+Alt uncaptures mouse<br\>
if using vinagre F10<br\>
get rid of VM via<br\>
virsh list<br\>
virsh shutdown <index><br\>
virsh undefine <index><br\>
virsh destroy <index><br\>
~~~ENDSECTION~~~

!SLIDE small
# Commands: testing for RBD support

<br\>
    
test qemu-kvm for RBD support

    # /usr/libexec/qemu-kvm -drive format=?
    # /usr/bin/qemu-system-x86_64 -drive format=?
    
test qemu-img for RBD support

    # qemu-img -h | grep "Supported formats"

!SLIDE small
# Lab Steps: create a new pool for libvirt

<br/>

create a pool with 128 PGs

    # ceph osd pool create libvirt 128

create an image within the pool

    # qemu-img create -f rbd rbd:libvirt/new-libvirt-image 2G

!SLIDE noprint
# Holistic
<center><img src="./../../_images/holistic.png" style="width:800px;height:600px " alt="matrixofhell"/></center>

~~~SECTION:notes~~~
qemu-img uses admin keyring
~~~ENDSECTION~~~

!SLIDE smaller
# Lab: ceph integration Step 1

create libvirt secret.xml

    # cat > secret.xml <<EOF
    <secret ephemeral='no' private='no'>
            <usage type='ceph'>
                    <name>client.libvirt secret</name>
            </usage>
    </secret>
    EOF

<br/>

import secret.xml ($secret holds an UUID)

    # secret=$(virsh secret-define --file secret.xml | cut -d " " -f 2)
    # echo $secret

<br/>


get the key for the libvirt ceph client (needs keyring in /etc/ceph)

    # ceph auth get-or-create client.libvirt mon 'allow r' \
      osd 'allow class-read object_prefix rbd_children, allow rwx pool=libvirt'

    # ceph auth get-key client.libvirt > client.libvirt.key

!SLIDE smaller
# Lab: ceph integration Step 2

set the libvirt ceph client key to our new libvirt secret

    # virsh secret-set-value --secret $secret --base64 $(cat client.libvirt.key)
    # rm client.libvirt.key secret.xml


!SLIDE smaller
# Lab: create VM helper script


[install-vm.sh](../file/_files/share/install-vm.sh)

~~~FILE:share/install-vm.sh~~~


!SLIDE smaller
# Lab: libvirt: rbd disk definition

<br/>

adapt [disk.xml](../file/_files/share/disk.xml) to your host name. pool/image name  and libvirt secret 

~~~FILE:share/disk.xml~~~

<br/>
<br/>

watch the disk growing

    # rbd -p libvirt info $(hostname)-vm
    # rados -p libvirt ls | grep <prefix> | wc -l

!SLIDE
# Lab: Snapshot

* create a clone of your VM
* create a new VM using the clone

!SLIDE
# Lab: VM live resize

* resize your VM
* extend the RBD and the FS inside the VM
