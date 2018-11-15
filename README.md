# Ceph Training

This training is designed as a two days hands-on training introducing Ceph,
its basics, cluster setup and many best practices.

The training participants will get an in-depth insight into the Ceph basics and configuration. 
They also learn about Ceph Cache Tier, Rados Gateway, RBD, CephFS, Monitoring and Sizing.

Target audience are experienced Linux administrators.


We have developed our training material based on years of experience in
professional service and training. To support our work, please join the official
training sessions and get your ticket at [NETWAYS](https://www.netways.de/en/trainings/home/).

## Procedure

You migth want to use the provided Docker container to present the slides.
You can also use showoff version 0.9.11.1 locally.

Edit showoff.json to alter the credentials for the presenter mode.
When using the "update follower mode", the "display window" can follow by pressing "g".
This is also applicable for the audience, you simply have to direct them to $presenterIP:9090.

The slides have sections like "Command" and "Labs".
While "Labs" indicates a task which should be finished during the training, "Commands" instead just demonstrate some possibilities.

For setting up the cluster, please use wired network connections, WiFi latency can make it really akward.
Also please be sure to use long IP leases, so your cluster network won't break.
Alternatively you might want to use fixed IPs instead of relying on an unreliable DHCP-Server.

Disclaimer:
This training has been set up while Luminous was not released as LTS.
While several changes have been made, you might find some relics from the jewel era.
Feel free to let us know about them. 
All installation steps have been run on CentOS 7. 


### Provide your training

Requirements:

* Docker

#### Start Showoff in Docker

```
./start.sh
```

#### Print Static Content

```
./print.sh
```

##### Contribution

Patches to fix mistakes or add optional content are always appreciated. If you want to see
changes on the default content of the training we are open for suggestions but keep in mind
that the training is intended for a two day hands-on training.

The rendered content will be updated at least if we do a newer version of the material which
will also be tagged on git.

Material is licensed under [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-nc-sa/4.0/).


