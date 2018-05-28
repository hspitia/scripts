#!/bin/bash

files=$1;
names=$2;

while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ "$line" != "" ]]; then
    name=$(echo -e $line | cut -d " " -f1);
    type=$(echo -e $line | cut -d " " -f2);
    
    old="${name}.fasta";
    new="${type}-${name}.fasta";
    
    command="mv $old $new";
    echo $command;
    $command;
  fi
done < "$names"