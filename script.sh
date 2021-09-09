#!/bin/bash

# find free space on root file system
output=(`df / | grep -vE '^Filesystem|udev|tmpfs|cdrom' | awk '{ print $4 }'`)
# reserve 5 MB of space to not crash the system
output=$(($output - 5000))
echo $output
# Write the zero file
dd if=/dev/zero of=zero bs=1K count=$output status=progress
# delete the zero file
rm zero
echo "done"
