#!/usr/bin/perl

use warnings;
use strict;
use Bio::SeqIO;
use IO::File;

# in:
#   $ARGV[0]: ids list file
#   $ARGV[1]: multifasta reference file
#   $ARGV[2]: output filename
#
# out:
#   the $ARGV[2] multifasta file with the sequences extracted form reference file


my $output_file = $ARGV[2];
my $ids_io = new IO::File();
$ids_io->open( $ARGV[0], "r" ) or die "Cannot open '$ARGV[0]': $!";
my $ids = "";
my @idsArray;
while( my $line = <$ids_io> ) {
    chomp $line;
    $line =~ s/[\r\n]+/|/g;
    $ids .= $line . "|";
    push @idsArray, $line;
}
$ids_io->close();
$ids =~ s/\|+$//;
# print "$ids\n";
my $regexp = qr/$ids/io;

my $fasta = new Bio::SeqIO( -file => $ARGV[1], -format => 'fasta' );
die "Cannot open file '$ARGV[1]': $!" unless $fasta;
#my $output = new Bio::SeqIO( -file => ">output.fasta", -format => 'fasta' );
my $output = new Bio::SeqIO( -file => ">".$output_file, -format => 'fasta' );
die "Cannot write to file '$output_file': $!" unless $output;

my $counter = 0;
while( my $seq = $fasta->next_seq() ) {
    # $output->write_seq( $seq ) if( $seq->id() =~ $regexp );
    if (grep $_ eq $seq->id(), @idsArray) {
    # if ($seq->id() =~ $regexp) {
        $output->write_seq( $seq );
        $counter += 1;
    }
}
print "Seqs extracted: $counter/".(scalar @idsArray)."\n";
exit( 0 );



