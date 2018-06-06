<!SLIDE> subsection
#~~~SECTION:MAJOR~~~ RADOS Gateway

!SLIDE noprint smbullets
# Objectives

* after this section you will know
 * the components of RadosGW
 * how to deploy RadosGW

!SLIDE lrbullets
# RADOS Gateway

* Object Store
* REST Interface
* S3/SWIFT dialect
* Quota and Usage tracking
* Auth and User management
* Multi-site deployment
* Disaster recovery


!SLIDE
# Components

* 1+ radosgw
* RADOS pools for
 * data
 * bucket indices
 * user management
 * quota
 * logs

!SLIDE smbullets
# radosgw

<br/>

a single process ties together

* frontend
 * Civetweb (default)
 * Apache +fastcgi
* auth
* quota
* librados

!SLIDE lrbullets 
#RADOS vs RGW

<br/>

| RADOS    | RGW |
|---|---|
| not indexed    | index needed    |
|  permissions per pool/rbd   |  permissions per object    |
| mutable | immutable |

!SLIDE
# RGW objects
* Head
 * metadata
 * acls
 * user attributes
 * start of data

* Tail
 * data striped

!SLIDE
# Bucket Index
* index of objects
* sorted list of objects in the bucket
* multizone replication

!SLIDE small
# Commands to deploy a radosgw

<br/>

install and create an RGW

    # ceph-deploy install --rgw radosgw-1
    # ceph-deploy rgw create radosgw-1

    # ceph osd lspools

create an S3 user

    # radosgw-admin user create --uid="training" \
      --display-name="Training User"

review

    http://radosgw-1:7480

!SLIDE  smaller
# S3 python example

~~~FILE:share/s3_example.py~~~

    # radosgw-admin bucket list --bucket=my-bucket

!SLIDE small
# S3 python example

* get [s3_example.py](../file/_files/share/s3_example.py)
* add credentials, host and a file and execute
* install missing python module

&nbsp;

    # sudo yum/apt-get install python-boto
