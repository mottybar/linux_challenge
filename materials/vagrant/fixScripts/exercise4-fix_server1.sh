#!/bin/bash
#add fix to exercise4-server1 here

sudo nano /etc/hosts
192.168.60.11 server2
ssh-keygen -t rsa -b 4096 -C "vagrant@server1"
copy key from ~/.ssh/id_rsa.pub
