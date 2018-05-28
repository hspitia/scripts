#!/bin/bash

genes_dir=$1;

for i in $(ls ${genes_dir}/*.fna); do
    fname=$(basename $i | sed 's/.genes.fna/_NT.genes.fna/g');
    # relname=$(basename $i);
    command="ln -s $i $fname"; 
    echo $command;
    $command; 
done;