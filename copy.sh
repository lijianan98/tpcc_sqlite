#!/bin/bash

#for i in {0..8} 
#do
	# copy [0, i-1] backup to PM 
#	if [ $i -lt $1 ]
#	then
		#echo $i
#		cp /mnt/pmem0/backup_tpcc/tpcc.$i.db_backup /mnt/pmem0/tpcc_w_64/
#	else
		#echo 10
#		cp /mnt/pmem0/backup_tpcc/tpcc.$i.db_backup /home/mania/tpcc_w_64/
#	fi
#done

#copy the 3 most accessed to SSD, rest to PM 
	#./tpcc_start ... -n 6 (# of tables on PM)
for i in {0..8}
do
        if [ $i -lt 3 ]
        then
                #copy first 3 to SSD
		let j=$i+6
		echo $j
                cp /mnt/pmem0/backup_tpcc/tpcc.$i.db_backup /home/mania/tpcc_w_64/tpcc.$j.db_backup
        else
                #echo rest to SSD
		let j=$i-3
		echo $j
                cp /mnt/pmem0/backup_tpcc/tpcc.$i.db_backup /mnt/pmem0/tpcc_w_64/tpcc.$j.db_backup
        fi
done

