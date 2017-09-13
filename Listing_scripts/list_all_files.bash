#!/bin/bash
#Makes a list of all station sorted by azimuth

#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
cd $path

#rm -f all_files.txt

ls > all_files.txt
