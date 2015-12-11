#!/bin/bash
#
#
echo "\n Welcome to OSD auto removing tool \n "
read  -p "Please enter the OSD number like osd." nu
echo "\n Your OSD is  osd.$nu , starting... \n"

#Out OSD
echo -e " \n osd.$nu is going out \n"
sleep 5
# stop OSD
service ceph stop osd.$nu
sleep 5

# Crush rm OSD
echo -e " \n The osd.$nu is going out from CRUSH \n "
ceph osd crush remove osd.$nu
sleep 5

# Auth delete OSD
echo -e " \n The Auth of osd.$nu is going to be deleted \n "
ceph auth del osd.$nu
sleep 5

# Rm OSD
echo -e " \n Deleting osd.$nu \n"
ceph osd rm osd.$nu
sleep 5

echo "Done"
