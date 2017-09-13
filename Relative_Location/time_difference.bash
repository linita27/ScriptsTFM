#!/bin/bash


#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/P_path.txt)
#echo "$path"
cd $path


sac > 0_relative_time1.txt <<EOF

  r *DISP*.SAC

  sort az

  lh t1

quit

EOF

sac > 0_relative_time3.txt <<EOF

  r *DISP*.SAC

  sort az

  lh t3

quit

EOF



#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/S_path.txt)
#echo "$path"
cd $path


sac > 0_relative_time1.txt <<EOF

  r *DISP*.SAC

  sort az

  lh t1

quit

EOF

sac > 0_relative_time3.txt <<EOF

  r *DISP*.SAC

  sort az

  lh t3

quit

EOF




#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/pP_path.txt)
#echo "$path"
cd $path


sac > 0_relative_time1.txt <<EOF

  r *DISP*.SAC

  sort az

  lh t1

quit

EOF

sac > 0_relative_time3.txt <<EOF

  r *DISP*.SAC

  sort az

  lh t3

quit

EOF
