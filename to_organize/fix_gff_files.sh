#!/bin/bash

for i in *.gff; do ./fix_trnascan_gff_name_column.sh $i > tmp; mv tmp $i; done;
