#!/bin/bash

matrix=$1;

sed -i 's/RdKW20/Rd-KW20/g' ${matrix}
sed -i 's/86028NP/86-028NP/g' ${matrix}