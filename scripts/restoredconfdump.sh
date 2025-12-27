#!/bin/bash

#dconf dump / > dconf-backup.txt
dconf load / < ../config/dconf-backup.txt
echo $?

exit 0
