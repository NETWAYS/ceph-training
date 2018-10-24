#!/bin/bash
sudo losetup -l -P /dev/loop1 "/home/training/my-cluster/osd-$HOSTNAME/30GB.img"
