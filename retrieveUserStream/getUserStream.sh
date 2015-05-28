#!/bin/bash

userId=$1

#Set random date between 2012 and current date for tweet retreival.
tweetDate=$(( $RANDOM%30 + 1))
tweetMonth=$(( $RANDOM%12 + 1))
tweetYear=$(( $RANDOM%3 + 2))

#untilDate="201$(($tweetYear))-$tweetMonth-$tweetDate"
untilDate="2014-12-31"

#Send request to twitter API for random tweets and save to file
twurl '/1.1/statuses/user_timeline.json?user_id='$userId'&count=200&include_rts=false&until='$untilDate > singleUser.json

#Parse and format information
sed -i 's/{"created_at":/\n{"created_at":/g' singleUser.json
sed 's/.*"created_at":"\(.*\)",.*"id_str":"\(.*\)","text":"\(.*\)","source":.*,"user":{.*"id_str":"\(.*\)",.*"name":"\(.*\)","screen_name":"\(.*\)","location".*/\2\t\3\t\4\t\5\t\6\t'$2'\t\1/g' singleUser.json | recode html..ascii > singleUser.tsv
sed -i 's/\\n/ /g' singleUser.tsv
sed -i 's/\\\//\//g' singleUser.tsv
sed -i 's/\t\t/\tN\/A\t/g' singleUser.tsv

#Remove RTs
#sed -i '/\tRT/d' singleUser.tsv 
#sed -i '/'$userId'/!d' singleUser.tsv 

#Un-escape special characters
python unicodeConvert.py

#Copy output to folder
if [ `cat output.tsv|wc -l` -ge 1 ]
then
	cp output.tsv output/output-`date "+%Y%m%d%H%M%S"`.tsv
	echo "Pass"
else
	echo "Fail"
fi
