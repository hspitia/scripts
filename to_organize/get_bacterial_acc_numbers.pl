#!/usr/bin/perl

use strict;
use LWP::Simple;

# my $query = 'chimpanzee[orgn]+AND+biomol+mrna[prop]';
my $query = 'txid2[Organism:exp]';
my $db = 'protein';

#assemble the esearch URL
my $base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
# my $url = $base . "esearch.fcgi?db=nucleotide&term=$query&usehistory=y";
my $url = $base . "esearch.fcgi?db=$db&term=$query&usehistory=y";

#post the esearch URL
my $output = get($url);

#parse WebEnv, QueryKey and Count (# records retrieved)
my $web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
my $key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);
my $count = $1 if ($output =~ /<Count>(\d+)<\/Count>/);

#open output file for writing
open(OUT, ">bacterial.txt") || die "Can't open file!\n";

#retrieve data in batches of 500
my $retmax = 100000;
for (my $retstart = 0; $retstart < $count; $retstart += $retmax) {
        print "Fetching " + ($retstart+1)*$retmax + "ids";
        my $efetch_url = $base ."efetch.fcgi?db=$db&WebEnv=$web";
        $efetch_url .= "&query_key=$key&retstart=$retstart";
        # $efetch_url .= "&retmax=$retmax&rettype=fasta&retmode=text";
        $efetch_url .= "&retmax=$retmax&rettype=acc&retmode=text";
        my $efetch_out = get($efetch_url);
        print OUT "$efetch_out";
}
close OUT;
