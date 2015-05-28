#!/bin/bash

#Array of search terms - common english words
searchArray="the be to of and a in that have"

#Get random array index for search term
idx=$(( $RANDOM % 9 + 1 ))

#Get random search term
searchTerm=`echo $searchArray|cut -d' ' -f$idx`

#Set random date between 2012 and current date for tweet retreival.
tweetDate=$(( $RANDOM%30 + 1))
tweetMonth=$(( $RANDOM%12 + 1))
tweetYear=$(( $RANDOM%3 + 2))

#untilDate="201$(($tweetYear))-$tweetMonth-$tweetDate"
untilDate="2014-12-31"

#Send request to twitter API for random tweets and save to file
twurl '/1.1/search/tweets.json?lang=en&include_rts=false&count=100&q='.$searchTerm.'&untildate='.$untilDate > searchAll.json

#Parse and format information
sed -i 's/{"metadata":/{"metadata":\n/g' searchAll.json
sed -i 's/\(\\n\|\\r\\n\|\\r\)/ /g' searchAll.json
sed 's/.*"id_str":"\(.*\)","name":"\(.*\)","screen_name":"\(.*\)","location":"\(.*\)","description":"\(.*\)","url".*,"created_at":"\(.*\)","favourites_count".*,"verified":\(.*\),"statuses_count":\(.*\),"lang":"\(.*\)","contributors_enabled".*/\1\t\2\t\3\t\4\t\5\t\6\t\7\t\8\t\9/g' searchAll.json | recode html..ascii > searchAll.tsv
sed -i 's/\\\//\//g' searchAll.tsv
sed -i 's/\t\t/\tN\/A\t/g' searchAll.tsv

#Un-escape special characters
python unicodeConvert.py

#Copy output to folder
cp output.tsv output/output-`date "+%Y%m%d%H%M%S"`.tsv

