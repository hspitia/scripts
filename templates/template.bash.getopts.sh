#!/bin/bash
# Argument = -a argument -v

usage() 
{
cat << EOF
usage: $0 [options]

This script runs a dummy test for getopts

OPTIONS:
   -h      Show this message
   -a      My argument (required)
   -v      Verbose 
EOF
}

ARGUMENT=
VERBOSE=
while getopts “ha:v” OPT
do
     case $OPT in
         h)
             usage
             exit 1
             ;;
         a)
             ARGUMENT=$OPTARG
             ;;
         v)
             VERBOSE=1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $ARGUMENT ]]
then
     usage;
     exit 1; 
fi

echo -e "Argument from -a:\t$ARGUMENT"
echo -e "Verbose from -v:\t$VERBOSE"