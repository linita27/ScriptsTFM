#!/usr/bin/perl
#***********************
#This script writes a path in a file (1) choosen among some options (2).
#***********************


#Deletes the file where the path is stored.
unlink ("my_path.txt"); #(1)

#Path options (2)
$PW="/home/lina/SAC/P";
$SW="/home/lina/SAC/S";
$GF="/home/lina/SAC/GF";

open(DATA, ">my_path.txt") or die "Couldn't open file file.txt, $!";

print "@ARGV[0] \n";


if (("@ARGV[0]"eq"P")||("@ARGV[0]"eq"p")){
  print DATA $PW;
} else{
  if (("@ARGV[0]"eq"S")||("@ARGV[0]"eq"s")){
    print DATA $SW;
  } else{
    if ((@ARGV[0]eq"GF")||(@ARGV[0]eq"gf")){
      print DATA $GF;
    }

}


close(DATA) || die "Couldn't close file properly";
