!SLIDE lrbullets small noprint
#~~~SECTION:MINOR~~~ CRUSH

<br/><br/><br/>

<center><img src="./_images/crush_symbole.png" style="width:300px;" alt="crush"/></center>


!SLIDE lrbullets small printonly
#~~~SECTION:MINOR~~~ CRUSH

<br/><br/><br/>

<center><img src="./_images/crush_symbole.png" style="max-width:100%;height:auto" alt="crush"/></center>


!SLIDE smbullets noprint
# Objectives

* after this section you will
 * know the benefits of CRUSH
 * understand the write processes within the Ceph Storage Cluster
 * know how to manipulate the Crush Map
 * know how to write Crush Rulesets
 * know how to use `crushtool` to build and test a Crush Map

!SLIDE smbullets
# CRUSH - 
# Controlled Replication Under Scalable Hashing

* a fast algorithm
* calculated on the client
* to get data placement (OSDs)
* avoids an intermediate broker
* enables direct communication between clients and OSDs
* can consider local conditions and failure domains, e.g. fire compartments

~~~SECTION:notes~~~
Controlled Replication under scalable Hashing</br>
Crush takes place on the client side. Input is Clustermap + Objectname + poolID<br/>
Metadataserver (broker) Problems: Bottleneck, spof, lookup takes some time<br/>
~~~ENDSECTION~~~

!SLIDE noprint

!SLIDE lrbullets noprint
# Write data

<center><img src="./_images/crush.png" style="max-width:80%;height:auto;" alt="crush"/></center>

~~~SECTION:notes~~~
Hashing Problems: must be fast, gets more complicated with replica, distribution according to Failure Domains<br/>
Input objects distributed according to Crushmap<br/>
pool + hash(name) = 6.45 (PG); Crush(6.45) => OSDs<br/>
writes/reads always against Primary OSD/ Journal. You can favorite OSD (e.g. SSD) -> Primary Affinity!<br/>
If Primary fails, are Replica on secondary and tertiary OSD. Clustermap is rebuilt instantly.
~~~ENDSECTION~~~

!SLIDE lrbullets printonly
# Write data

<center><img src="./_images/crush_rotated.png" style="max-width:100%;height:auto" alt="crush"/></center>

!SLIDE noprint
# Write process
<center><img src="./_images/write_process.png" style="max-width:80%;height:auto;" alt="write process"/></center>

~~~SECTION:notes~~~
Write ACKs after write against Journal<br/>
Explain Journal / WAL<br/>
Stress Network FrontEnd and Backend again<br/>
~~~ENDSECTION~~~

!SLIDE printonly
# Write process
<center><img src="./_images/write_process_rotated.png" style="max-width:100%;height:auto" alt="write process"/></center>

!SLIDE smbullets noprint
# OSD failure
<center><img src="./_images/osd_failure.png" style="max-width:80%;height:auto;" alt="osd failure"/></center>

~~~SECTION:notes~~~
Example aims at one PG<br/>
blacke Line: cimmunicating OSDs, because they share PGs<br/>
red Line: OSDs report faulty OSDs<br/>
monitors double-check and remove reported OSDs<br/>
clients: send Requests against new primary<br/>
OSDs: can restore replicas<br/>
~~~ENDSECTION~~~

!SLIDE smbullets printonly
# OSD failure
<center><img src="./_images/osd_failure_rotated.png" style="max-width:100%;height:640px" alt="osd failure"/></center>

!SLIDE smbullets
# OSD failure and states

each OSD can be in the state

* in or out
 * describes the cluster participation
* up or down
 * describes the connectivity

State changes on OSD failure

`in+up => in+down => out+down`


!SLIDE
# Crushmap 
* should reflect datacenter components
* CRUSH respects the crushmap for data placement
* part of clustermap


!SLIDE smbullets
# Crushmap - components

<br/>

* rules
 * to define data placement and replication adjusted to your datacenter
* buckets (rack, switch, fire compartment, dc)
 * to map your storage cluster to your datacenter
 * racks, fire compartment, switches
* devices
 * hard disks used for the data storage

~~~SECTION:notes~~~
use next slide to explain again
~~~ENDSECTION~~~

!SLIDE noprint smaller
<center><img src="./_images/crushmap.png" style="max-width:80%;height:auto;" alt="crushmap"/></center>

<br/> 

 # crushtool -o crushmap --build --num_osds 32 node straw 2 rack straw 2 switch straw 2 datacenter straw 2 root straw 0

 ~~~SECTION:notes~~~
show dataplacement 
 ~~~ENDSECTION~~~

!SLIDE printonly smaller
# Crushmap - hierarchy

<center><img src="./_images/crushmap_rotated.png" style="max-width:100%;height:640px" alt="crushmap"/></center>

 # crushtool -o crushmap --build --num_osds 32 node straw 2 rack straw 2 switch straw 2 datacenter straw 2 root straw 0

!SLIDE smaller noprint
# Crushmap - example (truncated)

<br/>

[Download: crushmap.txt](../file/_files/share/crushmap.txt)

~~~FILE:share/crushmap.txt~~~

!SLIDE printonly smaller smaller
# Crushmap - example 

~~~FILE:share/crushmap.txt~~~


!SLIDE small
# Crushmap - rule

<br/>

    rule simple-rule {
      ruleset 0
      type replicated
      min_size 2
      max_size 4
      step take default
      step chooseleaf firstn 0 type host
      step emit
    }

---

    step choose firstn <number> type <bucket>

    step chooseleaf firstn <number> type <bucket>

    <number> = 0: #replicas
    <number> > 0: #num
    <number> < 0: #replicas - #num


!SLIDE small
# Crushmap Commands: modify

<br/>

extract crushmap

    # ceph osd getcrushmap -o map.current

decompile crushmap

    # crushtool -d map.current -o map.txt

compile crushmap

    # crushtool -c map.txt -o map.new

set crushmap

    # ceph osd setcrushmap -i  map.new
