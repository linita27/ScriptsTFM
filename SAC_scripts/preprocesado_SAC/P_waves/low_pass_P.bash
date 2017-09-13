#!/bin/bash

#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
#echo "$path"
cd $path

#
# search for available recordings in directory
for rec in `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3}' `
#
# loop over recordings
do
#
# extract current pole-zero file (without header)

awk '{if ($1!="*") print $0}' SACPZ*$rec* > SACPZ.TMP
#
# say where you are

echo $rec
#
# start SAC.

sac << EOF

r OKHOTSK.$rec.P.DISP.SAC

lp c 0.1 p 2 n 4

w LOWPASS.$rec.P.SAC


quit

EOF
#
# next record
done
#
