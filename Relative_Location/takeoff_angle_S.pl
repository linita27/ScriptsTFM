#!/usr/bin/perl

#***************************************************************************

#***************************************************************************

use Path::Tiny;
use File::Copy;
use Math::Trig;
use Fortran::Format;

#Getting the path where script should run.
my $my_path = path("/home/lina/SAC/Z_SCRIPTS/S_path.txt")->slurp;
chomp $my_path; #Delete \n at the end of the string
chdir ($my_path) or die "cannot change: $!\n";

my $STATaz = path("0_az.txt")->slurp; # entire file in scalar
my $STATgcarc = path("0_gcarc.txt")->slurp;
my $all_files = path("w_all_files.txt")->slurp;

my $AK135_S = path("/home/lina/AK135/AK135_S_600.txt")->slurp; #AK135 data

#Defining output Fortran-Friendly formats
my $format_az = Fortran::Format->new('F8.2');
my $format_stat = Fortran::Format->new('A4');

open(my $location, '>', '00_input_location_S.txt');


#Extract slowness related with gcarc at 600km from file

#Delete first line of string. It contains headers and hinders us in data processing.
$AK135_S =~/^(?:.*\n){1} ((?:.*\n)*)$/x;
#$AK135_P =~/^(?:.*\n){1} ((?:.*\n)*)$/x;
$AK135_S = $1;
#print "$AK135_P";


$l=0;
$m=0;

while ($AK135_S =~ m/(\d{1,3})\..*/g){ #Getting gcarc values

  if($l % 2 == 0){  #If the number is odd then gets the gcarc position
  @gcarc[$m]=$1;
  #print "$1 \n";

  $m++;
  }
       $l++;
}

$l=0; #Restarting counters
$m=0;

while ($AK135_S =~ m/(\d{1,2}\.\d{2}).{20,25}$/mg){ #Getting slowness values

  if($l % 2 == 1){  #If the number is even then gets the slowness position
  @slowness[$m]=$1;
  #print "$1 \n";
  $m++;
  }
       $l++;
}
# m/(\d{1,2}\.\d{2})\s{4,7}(\d{1,2}\.\d{2})/g)
#m/^.*(\d{1,2}\.\d{2})\s*\d{1,2}\.\d{2}\s*\d{1,2}\.\d{2}$/mg)
#m/^.{80,92}(\d{1,2}\.\d{2})/mg


#Extracting station gcarc values

while ($STATgcarc =~ m/gcarc\s=\s(.*)\n/g) {
  @gcarc[$j]=int($1 +0.5); #Getting closest integer number from real value of gcarc
  $j++; #final $j will be the total number of stations
}

#print "@gcarc";



#Compute take-off angle

$pi=3.14159265359;

$vp=10.03; #P waves velocity (km/s)
$vs=5.50; #S waves velocity (km/s)

$depth=610; #Earquake depth (km)
$Rh=6378-$depth; #Earth radius - depth (km)

$constantP=(180/$pi)*($vp/$Rh);
$constantS=(180/$pi)*($vs/$Rh);

#Para cada estación, encontrar el valor de gcarc más cercano. Opción más fácil, redondeo a dos cifras.
#Una vez encontrado, el valor del slowness correspondiente es simplemente slowness[gcarc], ya que el vector gcarc solo contiene 0,1,2,...,125

#For P-waves


#print "@take_off_angle";

#For S-waves
for($i=0;$i<$j;$i++){
#  print $constantS*@slowness[@gcarc[$i]];
#  print "\n";
@angle[$i]=asin($constantS*@slowness[@gcarc[$i]])*(180/$pi);
@take_off_angle[$i]=$format_az->write(@angle[$i]);
chomp @take_off_angle[$i];
#print "@take_off_angle[$i]\n";
}
#Creating input for FOCMEC



     $j=0;


            while ($STATaz =~ m/FILE:\s(.*SAC)/g) {
              @estaciones[$j]=$1;
              $j++;
            }


      $j=0;

            while ($STATaz =~ m/FILE:\sOKHOTSK\.((\w{3})|(\w{4})|(\w{5}))\../g) {
              @stat_code[$j]=$1;
              @stat[$j] = $format_stat->write($1);
              chomp @stat[$j];
              $j++;
            }


      $j=0;
            while ($STATaz =~ m/az\s=\s(.*)\n/g) {
              @azimuth[$j]=$1;
              @az[$j] = $format_az->write($1);
              chomp @az[$j];
              $j++;
              }


            for($k=0;$k<$j;$k++){
              print $location "@stat[$k]@az[$k]@take_off_angle[$k]\n";
            }


            close $location;
