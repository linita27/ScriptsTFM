#!/bin/bash


#Reads all .sac files in a folder and saves a list of all station names.


#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
cd $path

rm -f url_list.txt

for rec in `ls *.SAC | awk -F. 'BEGIN {OFS=""}{print $2}' | sort | uniq `
do
  echo $rec
  echo $rec  >> url_list.txt

done
