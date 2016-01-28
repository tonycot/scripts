#!/bin/bash
dir="logsfs/"

function gripper {
  for i in $(grep -ril $1 /var/log/$2)
    do
      echo "In $i you have $(grep -c $1 $i) $1"
      echo -e "\n File $i \n" $(grep  $1 $i) >> $dir/all.log
  done
#  tar -zcvf $2.tar.gz $dir
}

#Create the directory
mkdir -p $dir

#Some Logs
echo -e "\n === Files ===  \n"

#
# Change the typo var to say what you want to find
# Change the servo var to say where in var/log you want to grep

typo="ERROR"
serv=""
gripper $typo $serv
