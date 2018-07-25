!SLIDE 
#~~~SECTION:MINOR~~~ Ceph Storage Cluster 

!SLIDE noprint smbullets

# Objectives

* after this section you will unterstand the <br/>
 structure of the main components of a Ceph Storage Cluster <br/>
  * RADOS<br/>


* use and interplay between the components<br/>
  * OSD
  * Monitors
  * Pools
  * Placement Groups

!SLIDE noprint
# Holistic
<center><img src="./../../_images/holistic.png" style="width:800px;height:600px " alt="matrixofhell"/></center>



!SLIDE noprint
# Components
<center><img src="./_images/stack.png" style="width:800px;" alt="ceph_stack"/></center>

!SLIDE printonly
# Components
<center><img src="./_images/stack_rotated.png" style="height:540px;" alt="ceph_stack"/></center>

!SLIDE tdbullets
# RADOS

<br/>

* R_eliable
<br/>
* A_utonomic
<br/>
* D_istributed
<br/>
* O_bject 
<br/>S_tore


~~~SECTION:notes~~~
reliable: because it's replicated and can handle failures<br/>
autonomic: self-healing on failures<br/>
distributed: distributed to failure domains => datacenters, racks, switch, server<br/>
~~~ENDSECTION~~~

!SLIDE lrbullets 
# RADOS FEATURES

* highly scaleable
* self healing
* flexible
* unified
* no SPoF
* commodity hardware

~~~SECTION:notes~~~
flexible: data placement (Failure Domains, fast OSDs vs slow OSDs)<br/>
unified und flexible because of block, cephfs and object<br/>
no SPoF correct for RADOS,RBD and RADOSGW BUT not CephFS (mds)<br/>
~~~ENDSECTION~~~

!SLIDE smbullets
# RADOS Components
<br/>

* Object Storage Daemons (OSDs)
 * essentially represent a disk
 * store data (objects)

* Monitors
 * are aware of the cluster state
 * form the quorum 

* Pools
 * logical partition of data

* Placement Groups (PG)
 * one pool has many PGs


~~~SECTION:notes~~~
osd: reads + writes data. communicate to each other for self-healing.<br/>
osd: communicates to monitors to deliver state<br/>
mons: manage and know the osd states <br/>
pgs: logical abstraction layer, needed for calculation of data placement 
~~~ENDSECTION~~~
