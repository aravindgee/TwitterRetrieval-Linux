NOTE: Each heading is a folder.
Prerequisites: twurl, Python

All output files will be created in the same directory as "final.tsv" [Tab-Seperated Values]

randomAll
----------
Get random tweets based on common English words
Output can be adjusted by changing number of iterations in start.sh
Time constraint can be set by modifying both getRandomTweets.sh and start.sh

To run: sh start.sh

userList
--------
Get list of random users by searching for common English words
Output can be adjusted by changing number of iterations in start.sh
Can also apply time constraint (max date) in start.sh

To run: sh start.sh

retrieveUserStream
------------------
Gets tweets using the user list generated from the userList script. Tries to retrieve 200 for each user.
Time constraint can be set by modifying both userStream.sh and start.sh

To run: sh start.sh <userfile>

Example: sh start.sh userTest.sh

The name of this file will be noted as the user group in the output file. For example, if you are using userGreen.txt, the user group column in the output will be marked as "Green". Each run of the script will produce its own output file, which can later be merged manually. 

Output for this script will be final.tsv. Backup before running the script again, or it will be overwritten.

userNames
---------
Gets user information for the given tweets. Time constraint can be set by modifying delay in getUserName.sh

To run: sh getUserName.sh

The list of tweets to be retrieved is provided in input.txt, in the same directory.