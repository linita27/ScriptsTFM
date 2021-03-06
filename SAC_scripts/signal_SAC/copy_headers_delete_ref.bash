#!/bin/bash

#This script copies the specified headers from unprocessed to processed ones.
#Also, deletes the peaking limit headers.


#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
#echo "$path"
cd $path

#
#rm *DISP* *VELO*
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

r *$rec*2013*SAC OKH*$rec*

synch

copyhdr from 1 t2

ch t8 undef
ch t9 undef

wh

quit

EOF
#
# next record
done
#
