#!/bin/bash
#Makes a list of all station sorted by azimuth

#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
cd $path

rm -f 0_az.txt
rm -f w_all_files.txt

sac > 0_az.txt <<EOF

  r *BHZ*.SAC

  sort az

  lh az

quit

EOF

ls > w_all_files.txt
