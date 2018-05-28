#!/bin/bash

names=$1;
instruction=$2;
exe=$3;

IFS= read -d '' usage << "EOF"
usage: ./generic_operations.sh file 'command'\\n
\\n
examples:\\n
    \\t./generic_operations.sh name.txt 'echo \"ln -s \$first \$second\"'\\n
    \\t./generic_operations.sh name.txt 'ln -s \$first \$second\'\\n
EOF

if [[ $names == "" || $names == "-h" || $names == "--help" ]]; then
    echo -e $usage;
    exit 1;
fi

# if [[ $exe == "" ]]; then
#     $exe=0;
# fi

# while IFS='' read -r line || [[ -n "$line" ]]; do
while IFS=$'\t' read -r first second
do
    # printf "%s", $first
    if [[ ! -z "${first// }" ]]; then
        eval $instruction
        # echo 
    fi
    # echo "Text read from file: $line"
    # first=$(echo -e $line | cut -d " " -f1); 
    # second=$(echo -e $line | cut -d " " -f2);
    # instruction="ls -lh $first"; 
    # instruction="mv $first $second"; 
    # if [[ $exe == 1 ]]; then
        # echo executing $instruction; 
    #     $instruction
    # # else
    #     # echo $instruction;
    # fi
    # eval $instruction
done <"$names"
