#!/bin/bash

#***********************************************************************************
#This script reads all .sac specified files in a folder (1) and cuts its lenght (2).
#***********************************************************************************

#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
#echo "$path"
cd $path

# iterate over all sac files in directory containing BHZ (1)
#for rec in `ls *BHZ*.SAC`
for rec in `ls *.SAC` #All .SAC files
do

echo $rec

sac <<EOF

  *read file

  r $rec

  * cut file (2)
  cutim 1500 2400

  *overwrite
  w $rec

quit

EOF

done
