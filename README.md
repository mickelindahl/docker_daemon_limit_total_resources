# Docker daemon limit resource

Limit total memory and cpu consumption for all docker containers on a server with cgroup

Note! This work for redhat 7
Might need to change MemLimted -> MexHigh and MemMax in newer kernal versions

## Install

Run
`cp sample.env .env`

Edit `.env`

Run
`sudo ./install.sh`

Run
`more /sys/fs/cgroup/memory/docker_limit.slice/memory.limit_in_bytes`
And confirm that this equals your set limit (in bytes)

Run
`more /sys/fs/cgroup/cpu/docker_limit.slice/cpu.cfs_quota_us`
And confirm it equals percent cpu limit time % by 1000. see https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/resource_management_guide/sec-cpu

To check that is is working run 
`docker run -it --rm -d containerstack/alpine-stress stress -c X -i 1 -m 1 --vm-bytes Y -t 60s`
where X should be cpu limits in numberof cpus (not procent) and Y equalt e.g. 4000M

Then check with `docker stats` that the limits are kept 

## Usefull commands

`sudo system-cgtop` to monitor cgroup usage

