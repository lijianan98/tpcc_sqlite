#!/bin/bash

#usage example: ./run2.sh /mnt/pmem0/tpcc_w_4 /home/mania/tpcc_w_4

export pmemlocation=$1
export ssdlocation=$2

# i is warehouse number
for i in 4 16 64 
do
	let j=640/$i
	echo $j
	# load every tables into backup (/mnt/pmem0/backup_tpcc)
	./load.sh $i 1 1 1 9 /mnt/pmem0/backup_tpcc /home/mania/tpcc_w_$i $j
	
	# performing experiment
	if [ $i -eq 4 ]
	then
		t=6000
	elif [ $i -eq 16 ]
	then
		t=20000
	elif [ $i -eq 64 ]
	then
		t=60000
	fi
	echo t=$t
	./auto.sh $i $t $pmemlocation $ssdlocation $j
	sleep 20
	rm -f /mnt/pmem0/backup_tpcc/tpcc.*
done

