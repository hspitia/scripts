#!/usr/bin/perl

#extractSequence.pl
#Marten Boetzer

#This script reads a .fasta file and extracts the sequences containing a certain pattern in the header
#run as follows: perl extractSequence.pl <INFILE> <MATCH_PATTERN>
#Input; fasta file with contigs, pattern for extract sequences
#Output: all sequences containing the pattern

use strict;
use File::Basename;

my $input_file = $ARGV[0];
my $match = $ARGV[1];

#check on empty input parameters)
print "please provide valid input file, such as \"velvet-contigs.fa\"\n" if (!$input_file);
print "please provide valid input file, such as \"chr1\"\n" if (!$match);

open (IN, $input_file) || die "Can't open input file. Please provide a valid input filename.\n";
my ($seq, $prevhead) = (0, "", '');
while(<IN>){
  my $line = $_;
  $line =~ s/\r\n/\n/;
  chomp $line;
  $seq.= uc($line) if(eof(IN));
  if (/\>(.*)/ || eof(IN)){
    my $head=$1;
    print ">$prevhead\n$seq\n" if($prevhead =~ /$match/);
    $prevhead = $head;
    $seq='';
  }else{
     $seq.=$line;
  }
}
close (IN);
