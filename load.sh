#!/bin/bash

cp tpcc.sql.template tpcc.sql

# usage example: ./load.sh 4 1 1 1 9 /mnt/pmem0/tpcc_w_4 /home/mania/tpcc_w_4 2
# meaning: 4: # of warehouses, 9:# of tables on PM, pmem location, ssd location, 2: scale ratio of database size 

export w=$1
export d=$2
export c=$3
export t=$4
export NDB=$5
export pmemLocation=$6
export ssdLocation=$7
export j=$8	# database size scale ratio


for i in {9..0}
do
	if [ $(($NDB)) -gt $i ]
   then
	   echo $i
	   echo $(($NDB))
	   sed -i "1s;^;attach database '${pmemLocation}/tpcc.$i.db_backup' as backup${i}zzz\n;" tpcc.sql
    else 
	   sed -i "1s;^;attach database '${ssdLocation}/tpcc.$i.db_backup' as backup${i}zzz\n;" tpcc.sql
   fi
   sed -i "s/zzz/;/g" tpcc.sql
done



sed -i '1s;^;PRAGMA foreign_keys = Ozzz\n;' tpcc.sql
sed -i "s/zzz/;/g" tpcc.sql

rm -f tpcc.db 




sqlite3 tpcc.db '.read tpcc.sql';
./tpcc_load -w $w -c $(($NDB)) -p $pmemLocation -s $ssdLocation -j $j -d tpcc.db;	# -c means how many databases on PM
