#!/bin/bash

set -e

# Variables
ucmap="crush-$HOSTNAME.map"
dcmap="crush-$HOSTNAME.txt"


# Functions
function echos {
  echo -e " \n $1 crushmap $2 "
}

# Main Functionality
echos Getting $ucmap
ceph osd getcrushmap -o $ucmap

echos Decompiling $ucmap
crushtool -d $ucmap -o $dcmap 

echos Deleting $ucmap
rm -f $ucmap
vim $dcmap
sleep 1

echos Compile $dcmap
crushtool -c $dcmap -o $ucmap

