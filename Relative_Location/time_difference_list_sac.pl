#!/usr/bin/perl

#***************************************************************************


use Path::Tiny;
use File::Copy;
use Math::Trig;
use Fortran::Format;

#Getting the path where script should run.
my $my_path = path("/home/lina/SAC/Z_SCRIPTS/my_path.txt")->slurp;
chomp $my_path; #Delete \n at the end of the string
chdir ($my_path) or die "cannot change: $!\n";

my $STATtimedif = path("0_relative_time.txt")->slurp; # entire file in scalar

open(my $reloc, '>', '00_reloc.txt');

$j=0;
while ($STATtimedif =~ m/t7\s=\s(.*)\n/g) {
  @time_difference[$j]=$1;
  $j++; #final $j will be the total number of stations
}

for($k=0;$k<$j;$k++){
  print $reloc "@time_difference[$k]\n";
}
