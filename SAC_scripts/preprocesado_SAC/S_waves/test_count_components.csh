#!/bin/csh
#
#Specify directory where working and move there.
set path_file = /home/lina/SAC/Z_SCRIPTS/my_path.txt
#echo "$path_file"
set my_path = `cat $path_file`
#echo "$my_path"
cd $my_path

# search for available recordings in directory
set reclist = `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3,"."}' | sort | uniq `
#
# loop over recordings
foreach rec ($reclist)
#
# search for available components
set wordcount = `ls *$rec*SAC |  wc `
#
# output
echo $rec $wordcount
#
# next record
end
#
