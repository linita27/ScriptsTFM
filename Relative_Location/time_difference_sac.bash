#!/bin/bash


#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
#echo "$path"
cd $path

# search for available recordings in directory
for rec in `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3}' `
#
# loop over recordings
do

echo $rec

sac << EOF


r *$rec*DISP*SAC

evaluate to c3 &1,t3
evaluate to c1 &1,t1
evaluate to c2 %c1 *(-1)
evaluate to time %c3 +%c2

ch t7 %time
wh

# quit SAC

quit

EOF
#
# next record
done
#

sac > 0_relative_time.txt <<EOF

  r *DISP*.SAC

  sort az

  lh t7

quit

EOF
