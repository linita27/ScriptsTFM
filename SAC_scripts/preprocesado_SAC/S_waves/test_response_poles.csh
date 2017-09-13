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
echo $rec
#
# search for available pole-zero files
set pzlist = `ls SACPZ*$rec* `
#
# compare horizontal component files without header
#grep INSTTYPE $pzlist[1]
awk '{if ($1!="*") print $0}' $pzlist[1] | awk '{if ($1!="CONSTANT") print $0}' > TMP1.TMP
awk '{if ($1!="*") print $0}' $pzlist[2] | awk '{if ($1!="CONSTANT") print $0}' > TMP2.TMP
diff TMP1.TMP TMP2.TMP
#
# next record
end
#
