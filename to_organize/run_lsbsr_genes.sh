#!/bin/bash

# -d directory of fasta files (could be symbolic links to genomes)
# -c clustering program 
# -b blast program
# -p number of processors

datestr=$(date +%F_%H-%M-%S);
command="/usr/bin/time -o ${datestr}.time.log -v ls_bsr.py -d fasta -g consensus.fasta -p 8 -y tmp -k T 2>&1 | tee ${datestr}.lsbsr.log";
echo $command;
$command;
