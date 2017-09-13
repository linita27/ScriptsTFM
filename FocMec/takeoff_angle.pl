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


my $AK135_P = path("/home/lina/AK135/AK135_P_600.txt")->slurp; #AK135 data

my $format_az = Fortran::Format->new('F8.2');
my $format_stat = Fortran::Format->new('A4');


$l=0;
my $header = <$AK135_P>;

while ($AK135_P =~ m/(\d{1,3})\..*/g){ #Reading the string containing AK135 data line by line unitll end of file

  #if(m/(\d{1,3})./g){
      print "$1 \n";
  #}
  $l++;

}

# while ($AK135_P){ #Reading the string containing AK135 data line by line unitll end of file
#
#   if($l % 2 == 0){  #If the number is odd then gets the gcarc position
# #  $_ =~ m/(\d{1,3})/g
# #  print "$1 \n";
# #  print $_;
#   }
#   else{ #If the number is even gets the slowness value
#
#
#   }
#
#
#   $l++;
#
# }
