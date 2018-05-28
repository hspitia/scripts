#!/bin/bash

file_list=$1;
genes_dir=$2;
out_file=$3;

IFS= read -d '' usage << "EOF"
usage: ./get_genes_from_list.sh <file_list> <genes_dir> <out_file>
EOF

if [[ $file_list == "" || $file_list == "-h" || $file_list == "--help" ]]; then
    echo $usage;
    exit 1;
fi

# nfiles=$(cat $file_list | wc -l);

# echo $nfiles;

# command="cat $file_list | sed 's/.fasta/.genes.fna/g' | ";
# cat $file_list | sed 's/.fasta/.genes.fna/g' | 
if [[ -e "$out_file" ]]; then
    rm $out_file;
fi

for i in $(cat $file_list); do
    fname=$(basename $i | sed 's/.fasta/.genes.fna/g');
    genes_file=${genes_dir}/${fname};
    cat ${genes_file} >> ${out_file};
done