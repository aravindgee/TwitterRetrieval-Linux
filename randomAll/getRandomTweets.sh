#!/bin/bash

#Array of search terms - common english words
searchArray="the be to of and a in that have"

#Get random array index for search term
#idx=$(( $RANDOM % 9 + 1 ))

#Get random search term
searchTerm=`echo $searchArray|cut -d' ' -f$idx`

#Set random date between 2012 and current date for tweet retreival.
tweetDate=$(( $RANDOM%30 + 1))
tweetMonth=$(( $RANDOM%12 + 1))
tweetYear=$(( $RANDOM%3 + 2))

#untilDate="201$(($tweetYear))-$tweetMonth-$tweetDate"
untilDate="2012-12-31"

#Send request to twitter API for random tweets and save to file
twurl '/1.1/search/tweets.json?lang=en&include_rts=false&count=100&q='.$searchTerm.'&untildate='.$untilDate > random.json

#Parse and format information
sed -i 's/{"metadata":/{"metadata":\n/g' random.json
sed 's/.*,"created_at":"\(.*\)","id":.*"id_str":"\([0-9]*\)","text":"\(.*\)","source".*"id_str":"\([0-9]*\)","name":"\(.*\)","screen_name":"\(.*\)","location".*"statuses_count":\([0-9]*\),"lang".*/\2\t\3\t\4\t\5\t\6\t\1/g' random.json | recode html..ascii > random.tsv
sed -i 's/\\n/ /g' random.tsv
sed -i 's/\\\//\//g' random.tsv
sed -i 's/\t\t/\tN\/A\t/g' random.tsv

#Remove RTs
sed -i '/\tRT/d' random.tsv 

#Un-escape special characters
python unicodeConvert.py

#Copy output to folder
cp output.tsv output/output-`date "+%Y%m%d%H%M%S"`.tsv
