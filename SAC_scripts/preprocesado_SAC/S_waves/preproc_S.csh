#!/bin/csh
#

#Specify directory where working and move there.
set path_file = /home/lina/SAC/Z_SCRIPTS/my_path.txt
#echo "$path_file"
set my_path = `cat $path_file`
#echo "$my_path"
cd $my_path

rm *VELO* *DISP*
# search for available recordings in directory
set reclist = `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3}' | sort | uniq `
#
#BK.CMB.00.BHN.M.2013.144.055557
#CN.SCHQ..BHN.M.2013.144.055732.SAC
#SACPZ.IC.SSE.10.BH2
#SACPZ.CN.SCHQ.--.BHE


# loop over recordings
foreach rec ($reclist)
# say where you are
echo $rec
#
# search for available components
set cmplist = `ls *$rec*SAC | awk -F. 'BEGIN {OFS=""}{print $4}' | sort | uniq `
echo $cmplist
#
# process first two components (BHE,BHN or BH1,BH2)
#
# extract current pole-zero file (without header)
awk '{if ($1!="*") print $0}' SACPZ*$rec*$cmplist[1] > SACPZ1.TMP
awk '{if ($1!="*") print $0}' SACPZ*$rec*$cmplist[2] > SACPZ2.TMP
# start SAC
sac << EOF
# read traces, remove instr. response
cut off
r *$rec*$cmplist[1]*SAC
taper w 0.3
trans from polezero subtype SACPZ1.TMP to none freq 0.001 0.0042 200 201
# write output
w TMP1.SAC
# other component
r *$rec*$cmplist[2]*SAC
taper w 0.3
trans from polezero subtype SACPZ2.TMP to none freq 0.001 0.0042 200 201
w TMP2.SAC
r TMP1.SAC TMP2.SAC
synch
w over
cuterr fillz
cut b b +900
r TMP1.SAC TMP2.SAC
rotate to gcp
#
# write output
w DUMMY.SAC OKHOTSK.$rec.SH.DISP.SAC
#
# make velocity
dif
w DUMMY.SAC OKHOTSK.$rec.SH.VELO.SAC
#
# quit SAC
quit
EOF
#
rm TMP1.SAC TMP2.SAC DUMMY.SAC SACPZ1.TMP SACPZ2.TMP
# next record
end
#
