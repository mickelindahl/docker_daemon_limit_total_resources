# Docker daemon limit resource

Limit total memory and cpu consumption for all docker containers on a server with cgroup

**Note!** This setup works for redhat 7.6. Might need to change MemoryLimit to 
MemoryHigh and MemoryMax ifor distributinos with higher kernal versions.
 (https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html)

## Install

Run
`cp sample.env .env`

Edit `.env`

Run
`sudo ./install.sh`

Run
`more /sys/fs/cgroup/memory/docker_limit.slice/memory.limit_in_bytes`
And confirm output equals the memory limit you set (in bytes)

Run
`more /sys/fs/cgroup/cpu/docker_limit.slice/cpu.cfs_quota_us`
And confirm output equals percent the cpu limit time in procent % 
multiplied with 1000 that you set. See https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/resource_management_guide/sec-cpu why multiplied with 1000

To check that is is working run 
`docker run -it --rm -d containerstack/alpine-stress stress -c X -i 1 -m 1 --vm-bytes Y -t 60s`
where X should be cpu limits in number of cpus (not procent) and Y equalt meory load 
e.g. 4000M or 3G

Then check with `docker stats` that the limits are kept 

## Usefull commands

`sudo system-cgtop` to monitor cgroup usage

