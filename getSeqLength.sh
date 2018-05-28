#!/bin/bash

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

# Input arguments to variables
inFile=$1;
# =================================================================================
# Functions
usage() 
{
    scriptNameSize=${#0};
    line="";
    for i in $(seq 1 ${scriptNameSize}); do 
        line="${line}="; 
    done;

cat << EOF
$0
$line

This script reports the size of each sequence contained in a multifasta file. It can process plain and gzipped fasta files.

Usage: 
    $0 [options] <fasta_file>

Arguments:
    fasta_file  Multifasta file
    
Options:
    -h --help   Show this message
EOF
}
# =================================================================================
# Arguments checking
if [[ $inFile  == "" || $inFile == "-h" || $inFile == "--help" ]]; then
    usage;
    exit 1;
fi
# =================================================================================
# File checking
if [[ ! -e "$inFile" ]]; then
    echo "Error: The file '${inFile}' does not exist.";
    exit 1;
fi
# =================================================================================
# Begin of code 

extension=${inFile##*.};

command="cat";

if [[ $extension == "gz" ]]; then
    command="zcat";
fi

${command} ${inFile} | awk '$0 ~ ">" {print c; c=0; printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }'

exit 0;

# End of code 
# =================================================================================
