#!/bin/bash
PASS=0
TOTAL_TESTS=4
SCORE=0

echo "describe keyspaces;" | cqlsh > keyspaces.txt
if(($(grep -io "my_index" keyspaces.txt | wc -l)==1)); then PASS=$((PASS+1)); fi;

echo "describe tables;" | cqlsh > tables.txt
if(($(grep -io "riders" tables.txt | wc -l)==1)); then PASS=$((PASS+1)); fi;

echo "describe table my_index.riders;" | cqlsh > tableinfo.txt
if(($(grep -io -e "id" -e "name" -e "phoneno" -e "location" -e "index" -e "riders_location" tableinfo.txt | wc -l)>=6)); then PASS=$((PASS+1)); fi;

echo "select * from my_index.riders;" | cqlsh > details.txt

if(($(grep -io -e "id" -e "name" -e "phoneno" -e "location" -e 1 -e "Alex" -e 12345 -e "Syria" -e 2 -e "Ellen" -e 23451 -e "Paris" -e 3 -e "Jiva" -e 34512 -e "Italy" -e 4 -e "Minie" -e 45123 -e "Europe" -e 5 -e "Humpty" -e 51234 -e "Houston" details.txt | wc -l)>=20)); then PASS=$((PASS+1)); fi;



echo $PASS
SCORE=$((PASS*100 / TOTAL_TESTS))
echo "FS_SCORE:$SCORE%"