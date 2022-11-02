#!/bin/bash

cp tpcc.sql.template tpcc.sql

export w=$1
export d=$2
export c=$3
export t=$4
export NDB=$5
export pmemLocation=$6
export ssdLocation=$7

for i in {9..0}
do
   if [ $NDB -g $i ]
   then
	   echo $i
	   sed -i "1s;^;attach database '${pmemLocation}/tpcc.$i.db_backup' as backup${i}zzz\n;" tpcc.sql
    else 
	   sed -i "1s;^;attach database '${ssdLocation}/tpcc.$i.db_backup' as backup${i}zzz\n;" tpcc.sql
   fi
   sed -i "s/zzz/;/g" tpcc.sql
done



sed -i '1s;^;PRAGMA foreign_keys = Ozzz\n;' tpcc.sql
sed -i "s/zzz/;/g" tpcc.sql


#sqlite3 tpcc.db '.read tpcc.sql'
#./tpcc_load -w $w -d tpcc.db
#./tpcc_start -w $w -c $c -t $t -d tpcc.db
