#!/bin/bash

#This script reads position of variable t1 (P wave start) using SAC, and records other two variables in header t8, t9,
#placed at t1+96 and t1+120.
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

#Making a linear regression for pP auto-peaking from P arrival time (stored in t9)
#pP theorical arrival will be stored in t8


sac << EOF


r *$rec*BHZ*SAC

evaluate to c0 &1,gcarc -70
evaluate to c1 %c0 *0.425
evaluate to c2 %c1 +121
evaluate to tpp %c2 +&1,t9

ch t8 %tpp
wh


r *$rec*DISP*SAC

evaluate to c0 &1,gcarc -70
evaluate to c1 %c0 *0.425
evaluate to c2 %c1 +121
evaluate to tpp %c2 +&1,t9

ch t8 %tpp
wh

r *$rec*VELO*SAC

evaluate to c0 &1,gcarc -70
evaluate to c1 %c0 *0.425
evaluate to c2 %c1 +121
evaluate to tpp %c2 +&1,t9

ch t8 %tpp
wh

r *LOW*$rec*SAC

evaluate to c0 &1,gcarc -70
evaluate to c1 %c0 *0.425
evaluate to c2 %c1 +121
evaluate to tpp %c2 +&1,t9

ch t8 %tpp
wh

# quit SAC

quit

EOF
#
# next record
done
#
