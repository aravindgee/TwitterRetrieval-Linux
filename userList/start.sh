#!/bin/sh

rm ./output/output-*.tsv
export idx=1

#No of iterations to run
itr=5

for i in `seq 1 $itr`
do
	echo -n "$i:"
	./getRandomTweets.sh

	export idx=`expr $idx + 1`
	if [ $idx -eq 10 ]
	then
        	export idx=1
	fi

	sleep 6
done

#Combine output
cat output/output-*.tsv > output/merged.tsv
sed -i 's/{"statuses":\[{"metadata"://g' output/merged.tsv

#Remove carriage returns
#sed -i 's/\r/ /g' output/merged.tsv

#Apply time range
#grep -P "(2013)$" output/merged.tsv > output/merged2.tsv

#Remove duplicates
sort -u -k1 output/merged.tsv > final.tsv
