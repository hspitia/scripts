#!/bin/bash

infile=$1;
column=$2;
expression=$3;

# Take the header line
header=$(head -1 ${infile});

# Catch the column names in an array
read -ra columns <<< "$header"; # $IFS defaults to whitespace (space, tab, newline)
# for i in ${columns[@]}; do
    # echo $i;
# done

# Get the index of the column
found=0;
counter=0;
index=-1;
n_columns=${#columns[@]};

while [[ "x${columns[counter]}" != "x" && "$found" == 0 ]]; do # line different from blank line and not found
    # echo $counter ${columns[$counter]};
    if [[ "${columns[counter]}" == "$column" ]]; then
        let found=1;
        let index=$counter;
        # echo "$column found at counter $counter;";
    fi
    let counter=$counter+1;
done

# Check if column was found
if [[ $index == -1 ]]; then
    echo "Column $column is not in the '$infile' file.";
    exit 1;
fi

# Adjust index to field number for awk
let field=${index}+1;

# Construct and evaluate the awk command
command="awk '{if(\$${field} ${expression}){print}}' $infile";
eval $command;