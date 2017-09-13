#!/bin/bash

#---------------------
#PREPARES FOCMEC INPUT
#Creates a list of station azimuths
#Creates a list of station gcarc
#Three possible flags: -P, -S and -p. First runs script for P waves, second for S waves and third for pP waves.
#---------------------



echo "Creating list of station coordinates..."
./get_coord.csh
echo "Creating map on GMT..."
./okhotsk_maps.gmt


echo "Done :)"
