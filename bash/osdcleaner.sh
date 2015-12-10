#!/bin/bash
#
#
echo "\n Welcome to OSD auto removing tool \n "
read  -p "Please enter the OSD number like \"osd.1\" : " osd 
echo "\n Your OSD is  $osd , starting... \n"

#Out OSD
echo -e " \n $osd is going out \n"
sleep 5
# stop OSD
service ceph stop $osd
sleep 5

# Crush rm OSD
echo -e " \n The $osd is going out from CRUSH \n "
ceph osd crush remove $osd
sleep 5

# Auth delete OSD
echo -e " \n The Auth of $osd is going to be deleted \n "
ceph auth del $osd
sleep 5 

# Rm OSD
echo -e " \n Deleting $osd \n"
ceph osd rm $osd
sleep 5

echo "Done"
