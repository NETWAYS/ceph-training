!SLIDE noprint
# Holistic
<center><img src="./../../_images/holistic.png" style="width:800px;height:600px " alt="matrixofhell"/></center>

!SLIDE smbullets
# Pools 
<br/>
<center><img src="./_images/pool.png" style="max-width:100%;height:auto;" alt="pools"/></center>

* logical divided data
* has attributes like
 * number of replica
 * resilience
 * rules for data placement
* many pools share the same resources
* pool size is infinite

!SLIDE small
# Commands: manage pools

show pools

    # ceph osd lspools

create a pool
    
    # ceph osd pool create <name> <pg-num>
    # sudo ceph osd pool application enable <name> <app>

show pool usage

    # rados df

delete pool

    # ceph osd pool delete <name> --yes-i-really-really-mean-it (twice)


~~~SECTION:notes~~~
"#" indicates a CLI command, executed with elevated rights,  above is a short explanation
~~~ENDSECTION~~~



!SLIDE small
# Commands: pool attributes
<br/>

get attributes

    # ceph osd pool get <name> size
    # ceph osd pool get <name> min_size
    # ceph osd pool get <name> crush_ruleset

<br/>

set attributes

    # ceph osd pool set <name> min_size 1


~~~SECTION:notes~~~
"#" indicates a CLI command, executed with elevated rights, above is a short explanation
~~~ENDSECTION~~~

!SLIDE noprint
# Holistic
<center><img src="./../../_images/holistic.png" style="width:800px;height:600px " alt="matrixofhell"/></center>

!SLIDE smbullets
# Placement Groups
<center><img src="./_images/pg.png" style="max-width:100%;height:auto;" alt="pg"/></center>

* logical collection of objects 
* Pools have many PGs, OSDs get mapped to them
* Number of PGs is specified at creation time
* Number of PGs/OSD depends on number and size of OSDs

~~~SECTION:notes~~~
~~~ENDSECTION~~~


!SLIDE smbullets
# Placement Groups ctd.

* PGs get mapped to OSDs via CRUSH<br/>
* the pool settings are used for the mappings, e.g. size<br/>
* a single object is mapped to a PG by its name and pool ID<br/>
* https://ceph.com/pgcalc



!SLIDE smbullets noprint
# Pools, PGs and OSDs 
<center><img src="./_images/pool-pg-osd.png" style="max-width:80%;height:auto;" alt="osd"/></center>

~~~SECTION:notes~~~
transition to CRUSH -> how are data mapped to Pools, PGs, OSDs<br/>
Please let participants rephrase the slides

all PGs for OSD 192: ceph pg dump | awk '{print $1"  "$15}' | egrep "\[.*192.*\]" | wc -l<br/>
Info for one PG: ceph pg 4.0 query<br/>
~~~ENDSECTION~~~

!SLIDE smbullets printonly
# Pools, PGs and OSDs 
<center><img src="./_images/pool-pg-osd_rotated.png" style="max-width:100%;height:550px" alt="osd"/></center>

!SLIDE smbullets noprint
# Lunch?! smoking break?!


<br>
<center><b> # yum update </b></center> <br/><br/><br/>
<center><img src="./_images/break.png" style="width:300px;" alt="break"/></center>
