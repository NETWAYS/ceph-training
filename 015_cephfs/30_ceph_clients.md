!SLIDE small
# CephFS clients commands

<br/><br/>

Kernel module:

    # mount -t ceph monitor:6789: /mnt \
      -o name=admin,secret=SUpeRAQDishwaems/fritzenfoob0elg==

    # mount -t ceph monitor:6789: /mnt \
      -o name=admin,secretfile=/etc/ceph/mysecret

<br/>

Fuse clients (needs ceph.conf and keyring):

    # ceph-fuse -m monitor:6789 /mnt


