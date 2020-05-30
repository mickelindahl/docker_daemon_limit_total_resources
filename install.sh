#! /bin/bash

if [ ! -f .env ]; then

   echo "Missing .env file"
   exit

fi

export $(cat .env | xargs)

NAME=docker_limit

cp sample.docker_limit.slice $NAME.slice

declare -a arr=(\
  "CPU" \
  "MEM" \
)


for var in "${arr[@]}"; do

   sed -i $(eval echo "s#{$var}#\$$var#g") $NAME.slice

done


chown root:root $NAME.slice
chmod 755 $NAME.slice

mv $NAME.slice /etc/systemd/system

systemctl daemon-reload
systemctl start $NAME.slice
#systemctl restart docker_limit

cp daemon.json /etc/docker

# The slice restriction should be loaded in here
systemctl restart docker
