#!/bin/sh
for i in $(seq 1 10)
do
    date +"%H:%M:%S"
    ps -ef | awk 'NR>1' | wc -l
    sleep 1
done
cat /proc/cpuinfo > cpu_info.txt
grep '^NAME=' /etc/os-release > os_info.txt
grep '^NAME=' /etc/os-release | cut -d '=' -f2 | tr -d '"' > os_name.txt

for i in $(seq 50 100)
do
    touch "${i}.txt"
done
