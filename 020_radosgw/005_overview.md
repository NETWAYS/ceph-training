<!SLIDE> subsection
#~~~SECTION:MAJOR~~~ RADOS Gateway

!SLIDE noprint smbullets
# Objectives

* after this section you will know
 * the components of RadosGW
 * how to deploy RadosGW

!SLIDE lrbullets
# RADOS Gateway

* basically webserver
* Object Store as backend
* REST Interface
* S3/SWIFT dialect
* easy to integrate in applications, e.g. Nextcloud
* Quota and Usage tracking
* Auth and User management
* Multi-site deployment
* Disaster recovery

!SLIDE noprint
# Holistic
<center><img src="./../../_images/holistic.png" style="width:800px;height:600px " alt="matrixofhell"/></center>

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

    $ ceph-deploy install --rgw $HOSTNAME
    $ ceph-deploy rgw create $HOSTNAME

    # ceph osd lspools

create an S3 user

    # radosgw-admin user create --uid="training" \
      --display-name="Training User"
review

    http://$HOSTNAME:7480

!SLIDE small
# Access your radosgw

install s3cmd

    # yum install -y s3cmd

configure s3cmd
   
    $ s3cmd --configure

add access_key, secret_key, host_base including port (default: 443)

create a bucket
   
    $ s3cmd mb s3://$HOSTNAME

put file into it as object
   
    $ s3cmd put $file_name s3://$bucket/$object_name

review your bucket
   
    § s3cmd ls s3://$bucket

~~~SECTION:notes~~~
if it doesn't work, a helpful .s3cfg is at "_files/share_"
~~~ENDSECTION~~~

!SLIDE small
# Add your radosgw to the dashboard

create a system user

    # radosgw-admin user create --uid=<user_id> --display-name=<name> --system

provide credentials 

    # ceph dashboard set-rgw-api-access-key <access_key>
    # ceph dashboard set-rgw-api-secret-key <secret_key>

go have a look!
  
