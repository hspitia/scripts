#!/bin/bash

infile=$1;

awk '{OFS="\t"; if (NF == 10){ $3 = $3$4; print $1,$2,$3,$5,$6,$7,$8,$9,$10} else {print $0}}' ${infile};