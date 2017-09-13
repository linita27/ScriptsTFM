#!/bin/bash

#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
#echo "$path"
cd $path

#
rm *DISP* *VELO*
# search for available recordings in directory
for rec in `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3}' `
#set reclist = `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3}' | sort | uniq `
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

cut b b +280

r *$rec*SAC

evaluate to level &1,depmen
#
# read entire trace, subtract stored amplitude, remove instr. response

cut off

r *$rec*SAC

sub %level
# Writes in a file after sub depmen
#w TEST.$rec.SAC
# We find right spline after this

taper w 0.5

trans from polezero subtype SACPZ.TMP to none freq 0.001 0.0042 200 201

# write output.

w OKHOTSK.$rec.P.DISP.SAC
#
# make velocity.

dif

w OKHOTSK.$rec.P.VELO.SAC
#
# quit SAC

quit

EOF
#
# next record
done
#
