#!/bin/csh
#
#Specify directory where working and move there.
set path_file = /home/lina/SAC/Z_SCRIPTS/my_path.txt
#echo "$path_file"
set my_path = `cat $path_file`
#echo "$my_path"
cd $my_path

#rm *VELO* *DISP*
# search for available recordings in directory
set reclist = `ls *SAC | awk -F. 'BEGIN {OFS=""}{print $2,".",$3,"."}' | sort | uniq `
#
# loop over recordings
foreach rec ($reclist)
# say where you are
echo $rec
#
# search for available components
set cmplist = `ls *$rec*SAC | awk -F. 'BEGIN {OFS=""}{print $4}' | sort | uniq `
#
# process first two components (BHE,BHN or BH1,BH2)
#
# start SAC
sac << EOF
* read traces,
cut off
r *$rec*$cmplist[1]*SAC *$rec*$cmplist[2]*SAC
*
* get true angle between supposedly orthogonal components
evaluate to angle1 &1,cmpaz
evaluate to angle2 &2,cmpaz
evaluate to angled &1,cmpaz - &2,cmpaz
* convert the difference to orthogonal +-90 or +-270 (doesnt work for deviation > 5 degrees)
evaluate to iangle 5 * %angled / ( ABSOLUTE  %angled )
evaluate to iangle2 ( INTEGER ( ( %angled + %iangle ) / 10 ) )
evaluate to iangle3 %iangle2 * 10
* compute new, orthogonal azimuth for component 1, and check difference to original azimuth
evaluate to newaz1 &2,cmpaz + %iangle3
evaluate to azdiff %newaz1 - &1,cmpaz
* write log file
setbb system $cmplist[1]
setbb station $rec
getbb TO angle.log names off newline off station system angle1 angle2 angled iangle3 newaz1 azdiff
*
* apply correction
ch file 1 cmpaz %newaz1
wh
*
* quit SAC
quit
EOF
#
# next record
end
#
