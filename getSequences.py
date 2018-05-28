#!/usr/bin/env python
"""                                                                                 
%prog some.fasta wanted-list.txt                                                    
"""                                                                                 
from Bio import SeqIO                                                               
import sys                                                                          

if (len(sys.argv) < 3):
    print("usage: getSequences.py <fasta_file> <seqs_ids_list>")
else:
    fasta_file   = sys.argv[1]
    seq_ids_list = sys.argv[2]
    
    wanted = [line.strip() for line in open(seq_ids_list)]                               
    seqiter = SeqIO.parse(open(fasta_file), 'fasta')                                    
    SeqIO.write((seq for seq in seqiter if seq.id in wanted), sys.stdout, "fasta")
    


