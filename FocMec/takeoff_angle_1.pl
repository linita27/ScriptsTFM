#!/usr/bin/perl

#***************************************************************************

#***************************************************************************

use Path::Tiny;
use File::Copy;
use Fortran::Format;

#Getting the path where script should run.
my $my_path = path("/home/lina/SAC/Z_SCRIPTS/my_path.txt")->slurp;
chomp $my_path; #Delete \n at the end of the string
chdir ($my_path) or die "cannot change: $!\n";

#Writing files into string variable
my $station = path("0_az.txt")->slurp; # Stations sorted by azimuth
my $all_files = path("w_all_files.txt")->slurp; #All files in folder

my $AK135_P = path("/home/lina/AK135/AK135_P_600.txt")->slurp; #AK135 data

my $format_az = Fortran::Format->new('F8.2');
my $format_stat = Fortran::Format->new('A4');


$l=0;
my $header = <$AK135_P>;

while ($AK135_P){ #Reading the string containing AK135 data line by line unitll end of file

  if($l % 2 == 0){  #If the number is odd then gets the gcarc position
  $_ =~ m/(\d{1,3})/g

  }
  else{ #If the number is even gets the slowness value


  }


  $l++;

}


#Open files
open(my $focmec, '>', 'input_FocMec.txt');


     $j=0;


            while ($station =~ m/FILE:\s(.*SAC)/g) {
              @estaciones[$j]=$1;
              $j++;
            }


      $j=0;

            while ($station =~ m/FILE:\sOKHOTSK\.((\w{3})|(\w{4})|(\w{5}))\../g) {
              @stat_code[$j]=$1;
              @stat[$j] = $format_stat->write($1);
              chomp @stat[$j];
              $j++;
            }


      $j=0;
            while ($station =~ m/az\s=\s(.*)\n/g) {
              @azimuth[$j]=$1;
              @az[$j] = $format_az->write($1);
              chomp @az[$j];
              $j++;
              }


            for($k=0;$k<=$j;$k++){
              print $focmec "@stat[$k] \t @az[$k] \n";
            }




            close $focmec;
