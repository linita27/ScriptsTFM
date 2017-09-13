#!/bin/csh
#

#Specify directory where working and move there.
set path_file = /home/lina/SAC/Z_SCRIPTS/my_path.txt
set my_path = `cat $path_file`
cd $my_path


rm 0_stations.txt
# search for available recordings in directory
set reclist = `ls *SAC | awk -F. '{print $2}' | sort | uniq `
#
# loop over recordings
foreach rec ($reclist)
#
# avoid duplications
set file = `ls *$rec*BHZ*SAC | awk '{if (NR==1) print $0}' `
#
# say where you are
echo $rec $file
#
# start SAC
sac << EOF
# read file and store station name, lattitude and longitude
r $file
setbb name &1,kstnm
getbb TO temp.file names off newline off name
#
# quit SAC
quit
EOF
#
# writing the temp file into list
cat temp.file >> 0_stations.txt
\rm -f temp.file
#
# next record
end
#

#Delete first and last character of every line, as SAC gives as output 'Station_name' and we need just Station_name.
#Also removing any character in position 5 or higher, as FOCMEC needs Station input names with just 4 characters.
rev 0_stations.txt | cut -c2- | rev | cut -c2- | cut -c1-4 > stations.txt
