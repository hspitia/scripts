#!/bin/bash

dir=$1;

for i in $(ls ${dir}/*); do 
  fp=$(realpath $i); 
  nme=$(basename $i); 
  ext=${nme##*.}; 
  nme=${nme%.*}; 
  command="ln -s $fp ${nme}.fasta"; 
  $command; 
done
