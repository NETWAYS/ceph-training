#!/bin/bash

set -x

# start the vm
virt-install \
  --name="$(hostname)-vm" \
  --ram=1024 \
  --vcpus=2 \
  --accelerate \
  --cdrom /tmp/debian-netinst.iso \
  --os-type=linux \
  --os-variant=debian \
  --network=bridge=virbr0,model=virtio \
  --graphics=vnc,listen=0.0.0.0 \
  --virt-type=kvm \
  --noautoconsole \
  --nodisks

# virsh-install does not support rbd style format, yet
# attach disk immediately after start
virsh attach-device $(hostname)-vm disk.xml --persistent
