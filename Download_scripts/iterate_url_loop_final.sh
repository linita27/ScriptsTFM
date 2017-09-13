#!/bin/bash

#****************************************************************************
#This script will download a set of files using a set of url given by three fixed parts (1) and two variables (2).
#The variables change as explained in the usage.
#The downloaded items will be unziped. You can also choose to just unzip some files inside the .zip file (3)
#The .zip files will be removed. Every unziped file will be stored in a folder with the same name of the .zip it came from.
#****************************************************************************

#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
#echo "$path"
cd $path

# Print Usage and exit
usage() {
    echo "Usage: $0" '[-c <command>] [-o <options>] [-x "<x_min> <x_increment> <x_max>"] [-y "<y_min> <y_increment> <y_max>"] [-a arguments]' 1>&2
    echo "" 1>&2
    echo "attention:" 1>&2
    echo "  This script must be tunned by editing the URL variables" 1>&2
    exit 1
}

# URL variables (1)
# FINAL_URL = MY_URL_1 + X + MY_URL_2 + Y + MY_URL_3
MY_URL_1="http://service.iris.edu/irisws/syngine/1/query?model=ak135f_2s&greensfunction=1&sourcedistanceindegrees="
MY_URL_2="&sourcedepthinmeters="
MY_URL_3=""

# Default parameters (2)
command=wget
x="60 10 150"
y="550000 10000 610000"
a=""

# Get the options
while getopts ":s:c:x:y:a:" o; do
    case "${o}" in
        c)
            command=${OPTARG}
            ;;
        x)
            x=${OPTARG}
            ;;
        y)
            y=${OPTARG}
            ;;
        a)
            a=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))



# Iterate over every line in the file
for X in `seq $x`; do
    for Y in `seq $y`; do
        filename=greenf_$X\_$Y
        $command $a -O $filename.zip $MY_URL_1$X$MY_URL_2$Y$MY_URL_3
        # Check that the file exists
        if [ -f "$filename.zip" ]; then
            mkdir "$filename"
            unzip -d $filename $filename.zip *TSS* *ZSS* # (3) Choosing to unzip just the files with names containing TSS and ZSS.
            rm $filename.zip
            # gnuplot -e "input_path='./$filename/grennsfunction_XX.GF001..TSS.sac';" mi_plot.gnu
        fi
    done
done
