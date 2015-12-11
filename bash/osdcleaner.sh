#!/bin/bash
#
#

# Functions 
function count {
  for i in `seq 1 $1`
    do 
      sleep $1 && echo "."
    done
}

function echos {
  echo -e " \n OSD.$nu $1 "
}


# The main functionality
read  -p "Welcome! Please enter the OSD number like osd." nu

if ! [[ $nu =~ ^[0-9]+$ ]]
  then
    echo "Try again" && exit
fi

echos ...preparing
count 2

#Out OSD
echos is going out
ceph osd out osd.$nu
count 2

# stop OSD
echos ...stopping
service ceph stop osd.$nu
count 4

# Crush rm OSD
echos ...remooving from CRUSH
ceph osd crush remove osd.$nu
count 4

# Auth delete OSD
echos ...deleting auth
ceph auth del osd.$nu
count 4

# Rm OSD
echos ...removing
ceph osd rm osd.$nu
count 1

echos ...done
