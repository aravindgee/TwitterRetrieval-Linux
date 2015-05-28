#!/bin/bash

#Ready output file
echo -e "Tweet ID\tUser Id\tScreen name\tUsername\tLocation\tDescription\tFollowers\tFollowing" > output.tsv

#Ready error file
echo "" > error.txt

#Read input.txt - this file stores all tweet ids.
while read line           
do           

tweetId=$line

#Send request to twitter API for random tweets and save to file
twurl '/1.1/statuses/show.json?id='$tweetId > singleTweet.json

#Parse and format information
sed -i 's/,"user":/,\n"user":/g' singleTweet.json
sed -i 's/},"geo"/}\n,"geo"/g' singleTweet.json
sed -i '/"user":{/!d' singleTweet.json

#Extract information
userInfo=`sed 's/.*"id_str":"\(.*\)","name":"\(.*\)","screen_name":"\(.*\)","location":"\(.*\)","description":"\(.*\)","url".*,"followers_count":\([0-9]*\),"friends_count":\([0-9]*\),.*/'$tweetId'\t\1\t\2\t\3\t\4\t\5\t\6\t\7/' singleTweet.json  | recode html..ascii`

if [ "$userInfo" != " " ]; then
        echo $userInfo >> output.tsv
else
	echo $tweetId >> error.txt
fi

#Delay to prevent hitting rate limit
sleep 6

done < input.txt 

#Remove new lines and escape sequences
sed -i 's/\\n/ /g' output.tsv
sed -i 's/\\r/ /g' output.tsv
sed -i 's/\\\//\//g' output.tsv
sed -i 's/\t\t/\tN\/A\t/g' output.tsv

#Un-escape special characters
python unicodeConvert.py
