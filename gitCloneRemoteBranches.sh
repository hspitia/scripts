#!/bin/bash

for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master `; do
   git branch --track ${branch#remotes/origin/} $branch
done

#for remote in `git branch -r `; do git branch --track $remote; done
#for remote in `git branch -r `; do git checkout $remote ; git pull; done

