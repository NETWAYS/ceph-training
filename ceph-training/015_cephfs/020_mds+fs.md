!SLIDE small
# Commands to create a CephFS filesystem

<br/><br/>

create pools

    # ceph osd pool create metadata 128
    # ceph osd pool create data 128

create MDS

    # ceph-deploy mds create server1 server2 server3
    # ceph mds stat
    e60: 1/1/1 up {0=server2=up:active}, 2 up:standby

create filesystem

    # ceph fs new share metadata data

