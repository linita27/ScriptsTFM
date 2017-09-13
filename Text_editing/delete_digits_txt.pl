#!/usr/bin/perl

#***************************************************************************
#Gives an output with some of the digits of every line from an input txt file.
#***************************************************************************

use Path::Tiny;
use File::Copy;
use File::chdir;

#Getting the path where script should run.
my $my_path = path("/home/lina/SAC/Z_SCRIPTS/my_path.txt")->slurp;
chomp $my_path; #Delete \n at the end of the string
chdir ($my_path) or die "cannot change: $!\n";

$fichero="AK135_P_600.txt";
open(FICH, $fichero) or die("Error al abrir el fichero");
open(SALIDA, ">AK135_P_600_slim.txt");
while(<FICH>){
    $linea=$_;
#    $basura=substr($linea, 0, 3);
    $a=5;
    $b=8;
    $texto=substr($linea, $a, $b); #Picks digits from a to b
    printf SALIDA $texto;
}
close FICH;
close SALIDA;
