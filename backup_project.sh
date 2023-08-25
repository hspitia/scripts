#!/usr/bin/env bash

project_path=$1;
backup_dir=$CLOUD_PROJECTS_BACKUP_DIR;

project_name=$(basename $project_path)
backup_file="$backup_dir/${project_name}.tgz"

cmd="tar czf \"$backup_file\" \"$project_path\""
echo $cmd

if $(eval $cmd); then
    echo "Project backed up to '$backup_file'"
else
    echo "ERROR: The project could not be backed up. Check the project path and try again"
    test -f "$backup_file" && rm -fr "$backup_file"
fi
