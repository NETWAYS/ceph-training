!SLIDE
#~~~SECTION:MINOR~~~ Metrics


!SLIDE noprint
# cluster performance metrics

    # ceph status -f json{-pretty}


<center><img src="./_images/ceph_performance.png" style="max-width:100%;height:auto;" alt="ceph performance"/></center>

!SLIDE printonly
# cluster performance metrics

    # ceph status -f json{-pretty}


<center><img src="./_images/ceph_performance_rotated.png" style="height:500px;" alt="cephfs performance"/></center>

!SLIDE noprint
# PGs state

    # ceph status -f json

<center><img src="./_images/pg_states.png" style="max-width:100%;height:auto;" alt="ceph PG"/></center>

!SLIDE printonly
# PGs state

    # ceph status -f json

<center><img src="./_images/pg_states_rotated.png" style="max-width:100%;height:520px;" alt="ceph PG"/></center>

!SLIDE noprint
# OSD performance

disk timings

<center><img src="./_images/disk_timings.png" style="max-width:100%;height:auto;" alt="timings"/></center>

!SLIDE printonly
# OSD performance
disk timings

<center><img src="./_images/disk_timings_rotated.png" style="max-width:100%;height:520px;" alt="timings"/></center>

!SLIDE noprint 
# OSD usage

disk usage

<center><img src="./_images/osd_usage.png" style="max-width:100%;height:auto;" alt="usage"/></center>

!SLIDE printonly
# OSD usage

disk usage

<center><img src="./_images/osd_usage_rotated.png" style="max-width:100%;height:520px;" alt="usage"/></center>

!SLIDE
# cluster usage

pool statistics

    # rados df --format json

<br/>

    # ceph df --format json
