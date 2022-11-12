#!/bin/bash

export pmemlocation=$1
export ssdlocation=$2

for i in {0..8} 
do
	# copy [0, i-1] backup to PM 
	if [ $i -lt $1 ]
	then
		#echo $i
		cp /mnt/pmem0/backup_tpcc/tpcc.$i.db_backup $pmemlocation
	else
		#echo 10
		cp /mnt/pmem0/backup_tpcc/tpcc.$i.db_backup $ssdlocation
	fi
done

