#!/usr/bin/env bash
# Argument = -a argument -v

usage() 
{
cat << EOF
usage: $0 -o OUTDIR [options]

This script creates a project directory structure

required arguments:
    -o   OUTDIR    Output directory

options:
   -h              Show this message
   -v              Verbose 
EOF
}

OUTDIR=
VERBOSE=
while getopts “o:hv” OPT
do
     case $OPT in
         o)
             OUTDIR=$OPTARG
             ;;
         h)
             usage
             exit 1
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

if [[ -z $OUTDIR ]]
then
     usage;
     exit 1; 
fi

ddata="$OUTDIR/data"
dbin="$OUTDIR/bin"
ddocs="$OUTDIR/docs"
dresults="$OUTDIR/results"

test ! -d "$ddata" && mkdir -p "$ddata"
test ! -d "$dbin" && mkdir -p "$dbin"
test ! -d "$ddocs" && mkdir -p "$ddocs"
test ! -d "$dresults" && mkdir -p "$dresults"
