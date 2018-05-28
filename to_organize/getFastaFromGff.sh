#!/bin/bash

# in_fasta=$1;
# gff=$2;
# out_fasta=$3;

# command="bedtools getfasta -fi $in_fasta -bed ${gff} -fo ${out_fasta}";

# echo ${command};
# ${command};

in_dir=$1;
gff_dir=$2;
out_dir=$3;

for i in $(ls ${in_dir}/*.fasta); do
    filename=$(basename $i);
    filename=${filename%.*};

    # fasta="${in_dir}/${i}";
    gff=${gff_dir}/${filename}.gff
    out_filename=${out_dir}/${filename}.genes.fna
    
    # command="bedtools getfasta -fi ${fasta} -bed ${gff} -fo ${out_filename}";
    command="bedtools getfasta -fi ${i} -bed ${gff} -fo ${out_filename}";
    echo ${command};
    ${command};
done