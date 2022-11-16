#!/bin/bash

#usage example: ./run2.sh

# i is warehouse number
for i in 640 # 4 16 64 640
do
	let j=640/$i
	#let j=1
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
		t=40000
	elif [ $i -eq 640 ]
	then
		t=60000
	fi
	echo t=$t
	./auto.sh $i $t /mnt/pmem0/tpcc_w_$i /home/mania/tpcc_w_$i $j
	rm -f /mnt/pmem0/backup_tpcc/tpcc.*
	sleep 20
done

