#!/usr/bin/perl

use strict;
use LWP::Simple;

my $inFileName  = $ARGV[0];
my $outFileName = $ARGV[1];

# my $query = 'chimpanzee[orgn]+AND+biomol+mrna[prop]';
my $query = 'txid2[Organism:exp]';
my $db    = 'protein';
# my $id_list = '194680922,50978626,28558982,9507199,6678417';

open(FILE, "<:crlf", $inFileName) or die "$0 ERROR. Could not open file '$inFileName' $!\n";
my @inFile = <FILE>;
close FILE;

chomp @inFile;
my $ids = join(",", @inFile);

# print $ids."\n";


#assemble the efetch URL
my $base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
# my $url = $base . "esearch.fcgi?db=nucleotide&term=$query&usehistory=y";
my $url = $base . "efetch.fcgi?db=$db&id=$ids&rettype=fasta&retmode=text";

print $url."\n";

#post the esearch URL
# my $output = get($url);
my $efetch_out = get($url);

#open output file for writing
open(OUT, ">$outFileName") || die "Can't open file '$outFileName'!\n";

print OUT "$efetch_out";

# #parse WebEnv, QueryKey and Count (# records retrieved)
# my $web   = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
# my $key   = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);
# my $count = $1 if ($output =~ /<Count>(\d+)<\/Count>/);

# #open output file for writing
# open(OUT, ">$outFileName") || die "Can't open file '$outFileName'!\n";

# #retrieve data in batches of 100
# my $retmax = 100;
# for (my $retstart = 0; $retstart < $count; $retstart += $retmax) {
#         print "Fetching " . ($retstart+1)*$retmax . "ids\n";
#         my $efetch_url = $base ."efetch.fcgi?db=$db&WebEnv=$web";
#         $efetch_url .= "&query_key=$key&retstart=$retstart";
#         # $efetch_url .= "&retmax=$retmax&rettype=fasta&retmode=text";
#         $efetch_url .= "&retmax=$retmax&rettype=seqid&retmode=text";
#         my $efetch_out = get($efetch_url);
        # print OUT "$efetch_out";
# }
close OUT;