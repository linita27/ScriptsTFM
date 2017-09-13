#!/bin/bash

#This script copies values stored in variable t2 and changes it to t1, undefining t2 in the process.
#This operation will be performed to original signal files and processed ones.


#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
#echo "$path"
cd $path

# search for available recordings in directory
for rec in `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3}' `
#
# loop over recordings
do
#
# extract current pole-zero file (without header)

#awk '{if ($1!="*") print $0}' SACPZ*$rec* > SACPZ.TMP
#
# say where you are

echo $rec
#
# start SAC.

sac << EOF

r *$rec*BHZ*SAC

evaluate to time &1,t2
ch t1 %time

ch t3 undef
ch t4 undef

wh

r *$rec*DISP*SAC

evaluate to time &1,t2
ch t1 %time

ch t3 undef
ch t4 undef

wh

r *$rec*VELO*SAC

evaluate to time &1,t2
ch t1 %time

ch t3 undef
ch t4 undef


wh

# quit SAC

quit

EOF
#
# next record
done
#
