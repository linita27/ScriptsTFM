#!/bin/bash

#---------------------
#PREPARES FOCMEC INPUT
#Creates a list of station azimuths
#Creates a list of station gcarc
#Three possible flags: -P, -S and -p. First runs script for P waves, second for S waves and third for pP waves.
#---------------------

echo "Creating list of azimuths..."
./list_az.bash
echo "Creating list of distances in degrees (gcarc)..."
./list_gcarc.bash

# Giving executing options. Three flags P,S,p.
while getopts "PSp" o; do
    case "${o}" in
        P)
            echo "P waves"
            ./takeoff_angle_P.pl
            ;;
        S)
            echo "S waves"
            ./takeoff_angle_S.pl
            ;;
        p)
            echo "pP waves"
            ./takeoff_angle_pP.pl
            ;;
        *)
            echo "Not a valid flag"
            ;;
    esac
done
shift $((OPTIND-1))

echo "Done :)"
