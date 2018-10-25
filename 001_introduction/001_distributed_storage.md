!SLIDE subsection
#~~~SECTION:MAJOR~~~ Storage - a quick overview

~~~SECTION:notes~~~
Introduction: which kinds of storage are used/known?
<br/>
take notes and categorize into<br/>
DAS, SAN, NAS/ Shared, Block, Object Store<br/>
~~~ENDSECTION~~~

!SLIDE smbullets noprint
# Objectives

* after this section you will be able to distinct different storage types
<br/><br/>
 shared filesystem <br/>
 <br/>block storage <br/>
 <br/>object store <br/>
 <br/>comparision 

!SLIDE smbullets
# Shared Filesystem

* concurrent access of several clients
* access via network
* usually compatible to POSIX
* integrated as 'local' file system
* e.g. CIFS, NFS and CephFS

~~~SECTION:notes~~~
NFS (usually FS on BlockStorage)<br/>
CephFS (FS on ObjectStore)<br/>

Files organized via path hierachy and metadata<br/>
~~~ENDSECTION~~~

!SLIDE smbullets
# Block Storage

* local disks, iSCSI, RBD
* accessed locally or via network
* fast
* good in random access
* usually with an FS on top

~~~SECTION:notes~~~
DAS (direct attached storage): e.g. local disks <br/>
SAN (Storage Area Network): extension of DAS, iSCSI, RBD (Block devics)<br/>
NAS (Network Attached Storage): FS via Network (CIFS, NFS, CephFS)<br/>

NFS (usually FS on BlockStorage)<br/>
CephFS (FS on ObjectStore)<br/>
~~~ENDSECTION~~~

!SLIDE lrbullets small
# Object Store

* access via API
* stores data in a flat 'hierarchy' like pools
* used for unstructured data
* used for large amount of data
* no posix tools
* easy to scale
* mostly what is sold as cloud storage
* often used for media, documents, archives, images
* an object comprises of Object-ID, Data, Metadata, Attributes

!SLIDE lrbullets small
# Differences Object Store - Block Storage

* no hierarchy by folders
* faster access of unstructured data
* more attributes
* more flexible attributes
* searchable by attributes
* applications have to support different access type
* or storage has to provide gateways

~~~SECTION:notes~~~
Objects (comprised of Metadata, Data, ID) instead of hierarchy<br/>
Metadata (creation time, size, ownership)
Attributes (access patterns, content, retention)
Examples: S3, RADOS, Swift<br/>
~~~ENDSECTION~~~

!SLIDE smbullets
# Visualization



!SLIDE noprint 
# local

<br/>

<center><img src="./_images/storage_1.png" style="height:400px;" alt="local_storage"/></center>


!SLIDE printonly
# local

<br/>

<center><img src="./_images/storage_1_rotated.png"  style="max-width:100%;height:auto" alt="local_storage"/></center>

!SLIDE noprint 
# network
<br/>

<center><img src="./_images/storage_2.png" style="height:400px;" alt="network_storage"/></center>


!SLIDE printonly 
# network
<br/>

<center><img src="./_images/storage_2_rotated.png" style="max-width:100%;height:auto" alt="network_storage"/></center>
~~~SECTION:notes~~~
* e.g. NetApp
~~~ENDSECTION~~~

!SLIDE noprint 
# network, failover
<br/>

<center><img src="./_images/storage_3.png" style="height:400px;" alt="network_failover"/></center>


!SLIDE printonly 
# network, failover
<br/>

<center><img src="./_images/storage_3_rotated.png" style="max-width:100%;height:auto" alt="network_failover"/></center>

~~~SECTION:notes~~~
* e.g. NetApp with two heads
~~~ENDSECTION~~~

!SLIDE noprint 
# network, failover, replicated
<br/>

<center><img src="./_images/storage_4.png" style="height:400px;" alt="network_failover_replicated"/></center>

~~~SECTION:notes~~~
* point out backend replication
~~~ENDSECTION~~~


!SLIDE printonly
# network, failover, replicated
<br/>

<center><img src="./_images/storage_4_rotated.png" style="max-width:100%;height:auto" alt="network_failover_replicated"/></center>

~~~SECTION:notes~~~
* e.g. NetApp MetroCluster?
~~~ENDSECTION~~~

!SLIDE noprint
# network, replicated, distributed, high-available
<center><img src="./_images/storage_5.png" style="width:800px;" alt="ceph"/></center>
~~~SECTION:notes~~~
* e.g. Ceph
~~~ENDSECTION~~~

!SLIDE printonly
# network, replicated, distributed, high-available
<br/>
<center><img src="./_images/storage_5_rotated.png" style="max-width:100%;height:500px" alt="ceph"/></center>

~~~SECTION:notes~~~
stress that Ceph offers all three kinds of Storage.
~~~ENDSECTION~~~
