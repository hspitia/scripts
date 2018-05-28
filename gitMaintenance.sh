#!/bin/bash


# Verifies the connectivity and validity of the objects in the database
git fsck --unreachable

# Manage reflog information
git reflog expire --expire=0 --all

# Pack unpacked objects in a repository
git repack -a -d -l

# Prune all unreachable objects from the object database
git prune

# Cleanup unnecessary files and optimize the local repository
git gc --aggressive

