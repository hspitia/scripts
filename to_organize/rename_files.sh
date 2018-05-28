#!/bin/bash

names=$1;
exe=$2;

if [[ $exe == "" ]]; then
    $exe=0;
fi

while IFS='' read -r line || [[ -n "$line" ]]; do
    # echo "Text read from file: $line"
    old=$(echo -e $line | cut -d " " -f1); 
    new=$(echo -e $line | cut -d " " -f2);
    # command="ls -lh $old"; 
    command="mv $old $new"; 
    if [[ $exe == 1 ]]; then
        echo executing $command; 
        $command
    else
        echo $command;
    fi

done < "$names"

