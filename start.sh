#!/bin/bash

pwd=`pwd`
name=`basename $pwd`
docker-machine create -d virtualbox $name
docker-machine stop $name
VBoxManage sharedfolder add $name --name pwd --hostpath $pwd --automount
docker-machine start $name
docker-machine ssh $name sudo mkdir -p /pwd/
docker-machine ssh $name sudo mount -t vboxsf -o defaults,uid=1000,gid=1000 pwd /pwd/
echo "eval \$(docker-machine env $name)" > vars.sh
