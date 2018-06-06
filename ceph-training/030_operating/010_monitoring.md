!SLIDE 
#~~~SECTION:MINOR~~~ Monitoring

!SLIDE smbullets
# ceph health

<br/>

ceph status translated to Icinga states

<center><img src="./_images/ceph_health.png" style="max-width:80%;height:auto;" alt="ceph monitoring"/></center>

<br/>

* warning: action needed
* critical: outage of PGs (read-only, at best)


e.g. [ceph-plugins](https://github.com/valerytschopp/ceph-nagios-plugins)

!SLIDE
# ceph health osd

<br/>

monitor all OSDs on a server

<center><img src="./_images/ceph_health_osd.png" style="max-width:80%;height:auto;" alt="ceph osd health"/></center>


!SLIDE smbullets
# SSD monitoring

<br/>

SSD journals - sentenced to death

<center><img src="./_images/ssd_mwi.png" style="max-width:80%;height:auto;" alt="ssd mwi"/></center>

<br/>

* Intel: Media Wearout Indicator (100-0)
* Samsung: Wear Leveling Count (0+)
