!SLIDE subsection 
#~~~SECTION:MAJOR~~~ CephFS


~~~SECTION:notes~~~
https://www.sebastien-han.fr/blog/2012/12/03/ceph-and-mds/
~~~ENDSECTION~~~

!SLIDE noprint smbullets
# Objectives

* after this section you will know
 * the components of CephFS
 * how CephFS maps the POSIX interface to an object store
 * how to create a CephFS Filesystem

!SLIDE noprint
# Holistic
<center><img src="./../../_images/holistic.png" style="width:800px;height:600px " alt="matrixofhell"/></center>

!SLIDE
# CephFS

* POSIX compatible filesystem
* shared filesystem
* stable since Jewel release (April 2016)
* be cautious with snapshotting (still valid with Mimic)
