#!/bin/bash
#Makes a list of all station sorted by azimuth

#Specify directory where working and move there.
path=$(</home/lina/SAC/Z_SCRIPTS/my_path.txt)
cd $path


#List of files to move -> files_Densidad.txt, files_fuera.txt

mkdir "0_Excedente_Densidad"
mkdir "0_Fuera"

while read file ; do mv "$file" /home/lina/SAC/FocMec/S/0_Excedente_Densidad ; done < 0_files_densidad.txt
while read file ; do mv "$file" /home/lina/SAC/FocMec/S/0_Fuera ; done < 0_files_fuera.txt
