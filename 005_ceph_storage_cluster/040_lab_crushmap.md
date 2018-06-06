!SLIDE printonly
# Lab: Crushmap

* Write and test a Crushmap with two datacenters
 * ensure that DC1 will always get 2 out of 3 replicas

!SLIDE smbullets noprint
# Lab: Crushmap

* Write and test a Crushmap with two datacenters
 * ensure that DC1 will always get 2 out of 3 replicas


~~~SECTION:notes~~~
http://cephnotes.ksperis.com/blog/2015/02/02/crushmap-example-of-a-hierarchical-cluster-map

crushtool --test -i crush-new2 --tree --show-mappings --rule 1 --num-rep=3<br/>
~~~ENDSECTION~~~
# Crushmap modifcations<br/>
type 0 osd<br/>
type 1 node<br/>
type 2 rack<br/>
type 3 switch<br/>
type 4 datacenter1<br/>
type 5 datacenter0<br/>
type 6 root<br/>
<br/>
...<br/>
<br/>
datacenter0 datacenter0 {<br/>
        id -29          # do not change unnecessarily<br/>
        # weight 16.000<br/>
        alg straw<br/>
        hash 0  # rjenkins1<br/>
        item switch0 weight 8.000<br/>
        item switch1 weight 8.000<br/>
}<br/>
datacenter1 datacenter1 {<br/>
        id -30          # do not change unnecessarily<br/>
        # weight 16.000<br/>
        alg straw<br/>
        hash 0  # rjenkins1<br/>
        item switch2 weight 8.000<br/>
        item switch3 weight 8.000<br/>
}<br/>
<br/>
...<br/>
<br/>
rule my {<br/>
  ruleset 1<br/>
  type replicated<br/>
  min_size 3<br/>
  max_size 3<br/>
  step take datacenter0<br/>
  step choose firstn 2 type rack<br/>
  step chooseleaf firstn 1 type node<br/>
  step emit<br/>
  step take datacenter1<br/>
  step chooseleaf firstn 1 type node<br/>
  step emit<br/>
}<br/>


