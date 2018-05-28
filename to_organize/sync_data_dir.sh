#!/bin/bash

action=$1;
servername=$2;

usage="usage: $0 action (push|pull) server_name (thebeast|compgenome2016)";

if [[ $action == "" || $action == "-h" || $action == "--help" ]]; then
    echo $usage;
    exit 1;
fi

case $servername in
    # aldebaran)
    #     user=hspitia;
    #     host=$(ifconfig vpn0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://');
    #     dir_path="/data/home/hfen3/projects/nthi/data/";
    #     ;;
    
    thebeast)
        host=thebeast.biology.gatech.edu;
        dir_path="/data/home/hfen3/projects/nthi/data/";
        ;;

    compgenome2016)
        host=compgenome2016.biology.gatech.edu;
        dir_path="/data/home/hfen3/nthi/data/";
        ;;
    *)
        echo "ERROR: Server not valid. Valid options are 'thebeast' and 'compgenome2016'.";
        exit 1;
        ;;
esac

user=hfen3;
local_path=$DATA/;
remote_path=${user}@${host}:${dir_path};
command="rsync -azPh --delete";

case $action in
    push)
        command="${command} ${local_path} ${remote_path}";
        ;;
    pull)
        command="${command} ${remote_path} ${local_path}";
        ;;
    *)
        echo "ERROR: Action not valid. Valid actions are 'push' and 'pull'." ;
        exit 1;
        ;;
esac

echo $command;
$command

exit 0;
