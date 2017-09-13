#!/bin/bash

#****************************************************************************
#This script will download a set of files using urls given in two fixed pieces and a changing piece stored in the lines of a file.
#It also unzips the downloaded file in a folder with its name and removes the original .zip file.
#****************************************************************************

#Usage in terminal
#./iterate_url_file_f.sh -c wget url_list.txt

#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
#echo "$path"
cd $path

# Print Usage and exit
usage() {
    echo "Usage: $0 [-c <command>] <url.list>" 1>&2
    echo "" 1>&2
    echo "example:" 1>&2
    echo "  $0 -c wget my_url.list" 1>&2
    exit 1
}

# URL variables
MY_URL_1="http://service.iris.edu/irisws/syngine/1/query?model=ak135f_2s&network=II&station="
MY_URL_2="&eventid=GCMT:C201305240544A"

# http://service.iris.edu/irisws/syngine/1/query?model=ak135f_2s&network=II&station=BFO&eventid=GCMT:C201305240544A

#awk make list
#ls *2013*SAC | awk 'BEGIN{FS="."} {print $1,$2}'



# Default command
command=echo

# Get the options
while getopts ":s:c:" o; do
    case "${o}" in
        c)
            command=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


# Check that a file was specified
if [ -z "$1" ]; then
    usage
fi

# Check that the file exists
if [ ! -f "$1" ]; then
    echo "$0: $1: file not found" 1>&2
    exit 1
fi

#Iterate over every line in the file
for i in $( cat $1 ); do
    filename=seism_sintetic_$i
#    $command "$MY_URL_1""$i""$MY_URL_2"
     $command -O $filename.zip "$MY_URL_1""$i""$MY_URL_2"
#      $command $a -O $filename.zip $MY_URL_1$X$MY_URL_2$Y$MY_URL_3
    # Unzip
    if [ -f "$filename.zip" ]; then
        mkdir "$filename"
        unzip -d $filename $filename.zip
        rm $filename.zip
    fi
done
