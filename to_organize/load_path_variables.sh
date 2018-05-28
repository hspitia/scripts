#!/bin/bash

hostname=$(hostname);

case $hostname in
    aldebaran)
        export SVMRFEPATH="/home/hspitia/projects/nthi";
        ;;
    
    biojordan)
        export SVMRFEPATH=/data/home/hfen3/projects/nthi;
        ;;

    compgenome2016)
        export SVMRFEPATH=/data/home/hfen3/nthi;
        ;;
esac    

# echo $SVMRFEPATH;

export DATA=$SVMRFEPATH/data;
export ALLGENOMES=$DATA/all_genomes;
export ANNOTATION=$DATA/prediction;
export ASSEMBLIES=$DATA/assemblies;
export METADATA=$DATA/metadata;
export PREDICTION=$DATA/prediction;
export REFERENCES=$DATA/references;

export SCRIPTS=$SVMRFEPATH/scripts;