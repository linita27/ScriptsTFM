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

my $STATt1 = path("0_relative_time1.txt")->slurp; # entire file in scalar
my $STATt3 = path("0_relative_time3.txt")->slurp; # entire file in scalar

open(my $reloc, '>', '00_reloc.txt');

$j=0;
while ($STATt1 =~ m/t1\s=\s(.*)\n/g) {
  @time1[$j]=$1;
  $j++; #final $j will be the total number of stations
}

$j=0;
while ($STATt3 =~ m/t3\s=\s(.*)\n/g) {
  @time3[$j]=$1;
  @time_difference[$j]=@time3[$j]-@time1[$j];
  $j++; #final $j will be the total number of stations
}

for($k=0;$k<$j;$k++){
  print $reloc "@time_difference[$k]\n";
}
