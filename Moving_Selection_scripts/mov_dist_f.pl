#!/usr/bin/perl

#***************************************************************************
#Reads the set of stations sorted by distance in KM and its values from a file "w_dist.txt"
#Stores files names and distance in two vectors @estaciones and @distancias.
#Given a distance limit, moves all files with a higher distance to a folder created (0_Out_of_distance).
#Also, stores name of the stations in another vector called @stat_code.
#***************************************************************************



$dist_lim = 7.897744e+03; #Distancia límite hasta la que son útiles los datos.

#open(DIST, "<w_gcarc.txt");
#$station = slurp "w_gcarc.txt";

use Path::Tiny;
use File::Copy;
use File::chdir;
use Cwd;

#Getting the path where script should run.
my $my_path = path("/home/lina/SAC/Z_SCRIPTS/my_path.txt")->slurp;

#Move to path
chdir $my_path;

my $station = path("w_gcarc.txt")->slurp; # entire file in scalar
my $all_files = path("w_all_files.txt")->slurp;


     $j=0;
     $k=-1;

            while ($station =~ m/FILE:\s(.*SAC)/g) {
              @estaciones[$j]=$1;
              $j++;
            }

      $j=0;

            while ($station =~ m/FILE:\s(\w{2}\.\w{3}.)|(\w{2}\.\w{4}.)./g) {
              @stat_code[$j]=$1;
              $j++;
            }

            print "@stat_code \n";

      $j=0;

            while ($station =~ m/dist\s=\s(.*)\n/g) {
              @distancias[$j]=$1;
              $j++;

              if ($1<=$dist_lim){
                $k++;
              }
            }

            print "$k \t $dist_lim \n";

            mkdir "0_Out_of_distance";

            for ($i=$k+1;$i<=$j;$i++){
              print "@estaciones[$i]   @distancias[$i] \n";
          #    move("home/lina/SAC/P-waves_Peak_Ins2/$estaciones[$i]","home/lina/SAC/P-waves_Peak_Ins2/0_Signals/@estaciones[$i]") or die "The move operation failed: $!";
              move("$estaciones[$i]","/0_Out_of_distance/@estaciones[$i]") or die "The move operation failed: $!";
            }
