#!/bin/bash

matrix_filename=$1;
names_filename=$2;
classes_filename=$3;
metadata_filename=$4;

fixnamesscript="/home/hspitia/projects/nthi/scripts/fix_bsr_matrix_genome_names.sh";
getclassesscript="/home/hspitia/projects/nthi/scripts/get_classes.R"

command="${fixnamesscript} ${matrix_filename}";
echo ${command};
${command};
echo ;

command="head -1 ${matrix_filename} | perl -pe 's/\t/\n/g' | perl -pe 's/^\n//g' | sort > ${names_filename}";
echo ${command};
eval ${command};
echo ;

# column 17: "Caused invasive case (Y=Yes) [Epi team classification]"
command="${getclassesscript} -o ${classes_filename} ${names_filename} ${metadata_filename} 17";
echo ${command};
${command};
echo ;


