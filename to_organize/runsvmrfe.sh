#!/bin/bash

datestr=$(date +%F_%H-%M-%S);
svmrfe="../run_svmrfe.R";
command="/usr/bin/time -o ${datestr}.time.log -v ${svmrfe} -k 5 --halve_value 500 -o rank_list.txt bsr_matrix.txt classes.csv"
echo $command
$command 2>&1 | tee ${datestr}.svmrfe.log;
