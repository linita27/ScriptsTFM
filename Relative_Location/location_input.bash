#!/bin/bash

#---------------------
#
#---------------------

echo "Creating list of azimuths..."
./list_az.bash
echo "Creating list of distances in degrees (gcarc)..."
./list_gcarc.bash
echo "Creating list of times..."
./time_difference.bash
echo "Creating input file..."
./relative_location.pl

echo "Done :)"
