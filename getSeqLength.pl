#!/usr/bin/perl -w

# =================================================================================
# Author:      Héctor Fabio Espitia Navarro
# Date:        12/25/2016
# Version:     1.0
# Institution: Georgia Intitute of Technology

# Description:
#   This script reports the size of each sequence contained in a 
#   multifasta file. It can process plain and gzipped fasta files.
# 
# Input:    A multifasta file (plain or gzipped)
# Output:   A list of sequences and sequence lenghts in a tab 
#           separated format:
#           
#           seq_1  seq_1_length
#           seq_2  seq_2_length
#           ...    ...
#           seq_n  seq_n_length
# =================================================================================

# Perl packages
use strict;
use Getopt::Long;
# use Data::Dumper qw(Dumper);
use Bio::SeqIO;
use File::Basename;
# use Bio::SeqIO::genbank;
# use List::Util qw[min max];

###################################################################################
# Global settings
# $Data::Dumper::Indent = 1;
# $Data::Dumper::Sortkeys = 1;
###################################################################################
# Global variables
# =================================================================================
# Ussage message:
my $line = "";
# for (1..(length $0)){
#     $line .= "=";
# }
$line =~ s/^(.*)/'=' x (length $0) . $1/mge;
my $usage   = "$0\n$line\n\n";
$usage     .= "This script reports the size of each sequence contained in a fasta file. It can process plain and gzipped fasta files.\n\n";
$usage     .= "Usage: \n    $0 [options] <fasta_file>\n\n";
$usage     .= <<'END_MESSAGE';
Arguments:
    fasta_file  Fasta input file.
    
Options:
    -h --help   Show this message.
END_MESSAGE

# =================================================================================
# Variables for input options
my $help = 0;
# Variables for opsitional arguments
# my ($inFastaFile, $otherOption) = @ARGV;
my $inFastaFile = $ARGV[0];

###################################################################################
# Process arguments
my $args = GetOptions("h|help" => \$help)
or die("Error in command line arguments.\n\n$usage");

###################################################################################
# Check input arguments
# Options:
if ($help) {
    print "$usage";
    exit 0;
}
# Arguments: 
if (! $inFastaFile) {
    print STDERR "$0 ERROR (Line ".__LINE__."): One or more required arguments are missing.\n\n$usage";
    exit 1;
}
###################################################################################
# Check for input file
if (! -e $inFastaFile) {
    print STDERR "$0 ERROR (Line ".__LINE__."): The file '$inFastaFile' does not exist.\n\n";
    exit 1;
}
###################################################################################
# Process file

my ($fileName,$dir,$ext) = fileparse($inFastaFile, qr/\.[^.]*/);

my $inSeq;

if ($ext eq ".gz") {
    open my $zcat, "zcat -f $inFastaFile |" or die "Cannot opendir $inFastaFile$!\n" ;
    $inSeq = Bio::SeqIO->new(-fh => $zcat, -format => 'fasta');
} else {
    $inSeq = Bio::SeqIO->new(-file => "<$inFastaFile", -format => "fasta");
}

while(my $seq = $inSeq->next_seq()) {
  print $seq->id() . "\t" . $seq->length() . "\n";
}

exit 0;