#!/bin/csh
#

#Specify directory where working and move there.
set path_file = /home/lina/SAC/Z_SCRIPTS/my_path.txt
set my_path = `cat $path_file`
cd $my_path


rm coord_list.lst
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
setbb lat &1,stla
setbb lon &1,stlo
getbb TO temp.file names off newline off name lat lon
#
# quit SAC
quit
EOF
#
# writing the temp file into list
cat temp.file >> coord_list.lst
\rm -f temp.file
#
# next record
end
#
