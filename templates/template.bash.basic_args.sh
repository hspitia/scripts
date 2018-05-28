#!/bin/bash

# =============================================================
# This script ...
# 
# Author:      Héctor Fabio Espitia Navarro
# Date:        
# Version:     
# Institution: Georgia Intitute of Technology
#              
# =============================================================

# Input arguments to variables
inArg=$1;
# =======================================================
# Functions
# -------------------------------------------------------
# Usage message
usage() 
{
    scriptNameSize=${#0};
    line="";
    for i in $(seq 1 $scriptNameSize); do 
        line="${line}="; 
    done;

cat << EOF
$0
$line

This script ...

Usage: 
    $0 [options] <in_file>

Arguments:
    in_file     Description of file.
    
Options:
    -h --help   Show this message.
EOF
}
# =======================================================
# Arguments checking
if [[ $inArg == "" || $inArg == "-h" || $inArg == "--help" ]]; then
    usage;
    exit 1;
fi
# =======================================================
# Begin of code 
echo "Hola"

# End of code 
# =======================================================