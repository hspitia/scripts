#!/usr/bin/perl -w
use strict;
use warnings;
#this script takes in three files in this order
# 1) cluster filenames list
# 2) matrix to filter rows from
# 3) list of genomes to preserve

my @fields;
my @pieces;
my %clusters;
my $cluster;
my $rowName;
my @rowCluster;
my $genomeName;

### BUILD CLUSTER HASH ###
open FILE, shift; #file containing list of filenames
while(my $filename = <FILE>) { #loop through files
	chomp($filename);
	open CLUSTER_FILE, '<', $filename;
	
	$cluster = <CLUSTER_FILE>; #set first line (name of cluster) equal to hash key
	chomp($cluster);
	chomp(my @a = <CLUSTER_FILE>); #subsequent lines are genomes belonging to cluster
	push(@a, $cluster);
	$clusters{$cluster} = [@a]; #set cluster equal to list of genomes
	
	close CLUSTER_FILE;
}
close FILE;
### BUILD CLUSTER HASH ###


open OFILE, ">filteredByColByRowMatrix.txt";
open MATRIX, shift; #matrix file to filter rows from
my $line = <MATRIX>; #extract header to print
print OFILE $line;

#create list of genomes to preserve
open GENOMES, shift; #file containing list of target genomes of interest (to preserve)
chomp(my @genomes = <GENOMES>);
close GENOMES, shift;

while(my $line = <MATRIX>) { #for every row in matrix
	@fields = split(/\t/, $line); #extract row name	
	@pieces = split(/;/, $fields[0]);
	@pieces = split(/=/, $pieces[0]);
	$rowName = ">".$pieces[1];
	@pieces = split(/_/, $pieces[1]);
	#print $genomeName = $pieces[0];
	#print "\n", @{$clusters{$rowName}}, "\n";
	foreach my $clusterGenome (@{$clusters{$rowName}}) { #loop through every genome belonging to the cluster (row)
		#print $clusterGenome, "\t";
		@pieces = split(/>/, $clusterGenome);
		@pieces = split(/_/, $pieces[1]);
		$genomeName = $pieces[0];
		#print "\n";
		if($genomeName ~~ @genomes) { #check if cluster genome exists in target genome list
			#print "yes";
			print OFILE $line; #if so, print line
			last;
		}
	}

}
close MATRIX;
close OFILE;

exit;
foreach (sort keys %clusters) {
        print "$_\t@{$clusters{$_}}\n";
	if(">M12252_0:277572-283023(-)" ~~ @{$clusters{$_}}) {
		print "yes\n";
	}
	#my @b = @{$clusters{$_}};
	#print "@b\n";
}

