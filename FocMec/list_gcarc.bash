#!/bin/bash

#Makes a list of all station sorted by DISTANCE TO THE EVENT IN DEGREES (gotten from .sac files info) and its distance value.
#Makes also another list of all file names in the current folder.

#Selects .sac files containing BHZ.


#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
cd $path

rm -f 0_gcarc.txt
rm -f w_all_files.txt

sac > 0_gcarc.txt <<EOF

  r *DISP*.SAC

  sort az

  lh gcarc

quit

EOF

ls > w_all_files.txt
