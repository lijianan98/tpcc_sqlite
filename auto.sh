#!/bin/bash

#usage: perform tests of 9/8/6/3/0 most accessed tables on PM and 3 most accessed on SSD

export w=$1		# warehouse number
export t=$2		# trancsation number
export pmemlocation=$3
export ssdlocation=$4
export j=$5		# scale factor

for i in 9 8 6 3 0	# 9 8 6 3 0
do
	rm -f $pmemlocation/tpcc.*
	rm -f $ssdlocation/tpcc.*

	#copy tables to PM and SSD location	
	for k in {0..8}
	do
       	 	# copy tables 0,1...i-1 from backup to PM 
        	if [ $k -lt $i ]
        	then
                	cp /mnt/pmem0/backup_tpcc/tpcc.$k.db_backup $pmemlocation
        	else
                	cp /mnt/pmem0/backup_tpcc/tpcc.$k.db_backup $ssdlocation
        	fi
	done

	./tpcc_start -w $w -r 60 -i 10 -l 240 -c 1 -t $t -n $i -p $pmemlocation -s $ssdlocation -j $j -d tpcc.db >> output_w_$w.txt
	echo warehouse number is $w, num_on_pmem is $i >> output_w_$w.txt
	sleep 20
done

rm -f $pmemlocation/tpcc.*
rm -f $ssdlocation/tpcc.*
:'
for i in {0..8}
do
        if [ $i -lt 3 ]
        then
               #copy top 3 accessed tables to SSD
               let j=$i+6
               echo $j
               cp /mnt/pmem0/backup_tpcc/tpcc.$i.db_backup $ssdlocation/tpcc.$j.db_backup
        else
               #copy rest to PM
               let j=$i-3
               echo $j
               cp /mnt/pmem0/backup_tpcc/tpcc.$i.db_backup $pmemlocation/tpcc.$j.db_backup
        fi
done
./tpcc_start -w $w -r 120 -i 10 -l 240 -c 1 -t $t -n 6 -p $pmemlocation -s $ssdlocation -j $j -d tpcc.db >> output_w_$w.txt
echo warehouse number is $w, top 3 accessed on ssd >> output_w_$w.txt

rm -f $pmemlocation/tpcc.*
rm -f $ssdlocation/tpcc.*
'
