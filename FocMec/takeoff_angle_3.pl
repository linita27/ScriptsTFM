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


#Extract slowness related with gcarc at 600km from file

#Delete first line of string. It contains headers and hinders us in data processing.
$AK135_P =~/^(?:.*\n){1} ((?:.*\n)*)$/x;
#$AK135_P =~/^(?:.*\n){1} ((?:.*\n)*)$/x;
$AK135_P = $1;
#print "$AK135_P";


$l=0;

while ($AK135_P =~ m/(\d{1,3})\..*/g){ #Getting gcarc values

  if($l % 2 == 0){  #If the number is odd then gets the gcarc position
  @gcarc[$l]=$1;
  #print "$1 \n";
  }
       $l++;
}

$l=0; #Restarting counter

while ($AK135_P =~ m/(\d{1,2}\.\d{2}).{20,25}$/mg){ #Getting slowness values

  if($l % 2 == 1){  #If the number is even then gets the slowness position
  @slowness[$l]=$1;
  print "$1 \n";
  }
       $l++;
}
# m/(\d{1,2}\.\d{2})\s{4,7}(\d{1,2}\.\d{2})/g)
#m/^.*(\d{1,2}\.\d{2})\s*\d{1,2}\.\d{2}\s*\d{1,2}\.\d{2}$/mg)
#m/^.{80,92}(\d{1,2}\.\d{2})/mg


#Compute slowness
