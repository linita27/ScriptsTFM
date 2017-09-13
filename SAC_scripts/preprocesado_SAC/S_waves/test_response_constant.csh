#!/bin/csh
#
#Specify directory where working and move there.
set path_file = /home/lina/SAC/Z_SCRIPTS/my_path.txt
#echo "$path_file"
set my_path = `cat $path_file`
#echo "$my_path"
cd $my_path
# search for available recordings in directory
set reclist = `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3}' | sort | uniq `
#
# loop over recordings
foreach rec ($reclist)
#
# search for available pole-zero files
set pzlist = `ls SACPZ*$rec* `
#
# compare horizontal component files without header
#grep INSTTYPE $pzlist[1]
awk '{if ($1!="*") print $0}' $pzlist[1] > TMP1.TMP
awk '{if ($1!="*") print $0}' $pzlist[2] > TMP2.TMP
#
# compute ratio:
set consta = `grep CONSTANT TMP1.TMP | awk '{print $2}' `
set constb = `grep CONSTANT TMP2.TMP | awk '{print $2}' `
set ratio = `echo $consta $constb | awk '{print (1 - $1 / $2) * 100 }' `
set iratio = `echo $ratio | awk '{print int(sqrt($1*$1)+0.5)}' `
echo $rec $iratio
#
# next record
end
#
