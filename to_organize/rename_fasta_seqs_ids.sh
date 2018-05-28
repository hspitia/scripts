#!/bin/bash

seqs=$1;
names=$2;

cp $seqs $seqs.copy;
while IFS='' read -r line || [[ -n "$line" ]]; do
    # echo "Text read from file: $line"
    old=$(echo -e $line | cut -d " " -f1); 
    new=$(echo -e $line | cut -d " " -f2);
    # echo "$old --> $new"; 
    # echo "sed -i 's/>$old/>$new/g'"; 
    # sed 's/>'$old'/>'$new'/g' $seqs > new;
    sed -i "s/>$old */>${old}_${new}/" $seqs.copy; 
done < "$names"

cat $seqs.copy;
rm $seqs.copy;
