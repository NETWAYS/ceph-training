!SLIDE small 
# Commands: rados cli 

<br/>

save a $file <file> with name $object_name <object_name> in the $pool

    # rados -p <pool> put <object_name> <file>

list all objects in $pool <pool>

    # rados -p <pool> ls

save the object $object_name <object_name> in $file <file>

    # rados -p <pool> get <object_name> <file>

remove an object

    # rados -p <pool> rm <object_name>


!SLIDE small
# Lab: Where are my data?

* upload a file with rados

* retrieve an uploaded file from your neighbour
* find the object in the filesystem of an osd
 * c.f. [ceph osd map](http://docs.ceph.com/docs/master/man/8/ceph/#osd)

~~~SECTION:notes~~~
ceph osd map pool objectname
~~~ENDSECTION~~~

!SLIDE small
# Steps - put data into cluster

<br/>

create a test.file 

  # cat /var/log/boot.log > $HOSTNAME.file

list all pools

  # ceph osd lspools

put file into pool

  # rados -p $poolname put $hostnametest $HOSTNAME.file

list objects in $pool

  # rados -p $pool ls

retrieve file of your neighbour

 # rados -p $pool get $otherhostnametest \ $otherhostname.file

find object on your OSD

