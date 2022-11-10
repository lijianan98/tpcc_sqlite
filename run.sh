#!/bin/bash

 
# Declare a string array with type
declare -a ws=(4 16 64 600)
declare -a NDB=(0 3 9 )

# Read the array values with space
for w in "${ws[@]}"; do
	for sw in "${NDB[@]}"; do
		echo $w $sw
		./experiment.sh $w tpcc.db 1 200000 $NDB /mnt/pmem0/tpcc_w_4 /home/mania
		sleep 20
	done
done
