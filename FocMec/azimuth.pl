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

my $station = path("0_az.txt")->slurp; # entire file in scalar
my $all_files = path("w_all_files.txt")->slurp;


my $format_az = Fortran::Format->new('F8.2');
my $format_stat = Fortran::Format->new('A4');

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
