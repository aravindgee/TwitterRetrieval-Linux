#!/bin/sh

rm ./output/output-*.tsv

#Set User ID source
group=$1

while read line
do
	./getUserStream.sh $line $group
	echo $line | sed '/\r/d'
	echo -n ":"

	sleep 6
done < users$group.txt

#Combine output
cat output/output-*.tsv > output/merged.tsv

#Remove carriage returns
sed -i 's/\r/ /g' output/merged.tsv
sed -i '/\[/d' output/merged.tsv

#Apply time range
#grep -P "(2013)$" output/merged.tsv > output/merged2.tsv

#Remove duplicates
sort -u -k3 output/merged.tsv > final.tsv
