#!/usr/bin/perl

#***************************************************************************
#Reads the set of stations sorted by distance given in DEGREES and its values from a file "w_gcarc.txt"
#Stores files names and distance in two vectors @estaciones and @distancias.
#Given two distance limits, moves all files with a higher or lower distance to a folder created (0_Out_of_distance).
#Also, stores name of the stations in another vector called @stat_code.

#THIS SCRIPT WILL ONLY WORK ON UNIX, AS IS USING THE SYSTEM COMMAND WITH UNIX SYNTAX
#***************************************************************************

#Specify directory where working.
#my $my_path = path("/home/lina/SAC/Z_SCRIPTS/my_path.txt")->slurp;


#Límites ondas p, pP.
$deg_min = 0; #Grado a partir del cual son útiles los datos.
$deg_max = 30; #Grado hasta el que son útiles los datos.

use Path::Tiny;
use File::Copy;

#Getting the path where script should run.
my $my_path = path("/home/lina/SAC/Z_SCRIPTS/my_path.txt")->slurp;
chomp $my_path; #Delete \n at the end of the string
chdir ($my_path) or die "cannot change: $!\n";

my $station = path("0_az.txt")->slurp; # entire file in scalar
my $all_files = path("w_all_files.txt")->slurp;


     $j=0;
     $k=-1;

            while ($station =~ m/FILE:\s(.*SAC)/g) {
              @estaciones[$j]=$1;
              $j++;
            }

      $j=0;

            while ($station =~ m/FILE:\s\w{1,2}\.(\w{3,5})\../g) {
              @stat_code[$j]=$1;
              $j++;

            }

            print "@stat_code \n";

      $j=0;
      $pos_min=99999;
      $pos_max=0;

            while ($station =~ m/az\s=\s(.*)\n/g) {
              @grados[$j]=$1;
              $j++;

              if (($1>$deg_min)&&($1<=$deg_max)){

                if($pos_min>$j){$pos_min=$j}
                if($pos_max<$j){$pos_max=$j}

                $k++;
              }
            }

            print "k: $k \t j: $j \t az_min: $deg_min \t az_max: $deg_max \n";
            print "Pos min: $pos_min \t Pos max: $pos_max \n";




            # while ($all_files =~ m/FILE:\s(\w{2}\.\w{3}.)|(\w{2}\.\w{4}.)./g) {
            #   @stat_code[$j]=$1;
            #   $l++;
            # }


            # while(<$fh>) {
            #   my $line = $_ if /\bAPPLE\b/;
            #   # do something with $line
            #   }



            mkdir "0_Azimuth";

            for ($i=$pos_min-1;$i<=$pos_max-1;$i++){
              print "@estaciones[$i] @stat_code[$i] @grados[$i] \n";
            }

            # #Mover azimuths por debajo del límite
            # for ($i=0;$i<=$pos_min-1;$i++){
            #   system ("mv *@stat_code[$i]* 0_Azimuth");
            # #Mover azimuths por encima del límite
            # }
            # for ($i=$pos_max;$i<=$j-1;$i++){
            #   system ("mv *@stat_code[$i]* 0_Azimuth");
            # }
            #Mover azimuths dentro del límite
            for ($i=$pos_min-1;$i<=$pos_max-1;$i++){
              system ("mv *@stat_code[$i]* 0_Azimuth");
            }
