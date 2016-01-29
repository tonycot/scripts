#!/bin/bash

# Put this script on the controller node
# to test your floating IPs

# Include credentials
source openrc


# Read values
read  -p "Enter the count of floating IP: " fip
read -p "Enter the count of tries: " try

nova floating-ip-list

# Main functionality

for k in `seq $try`
  do 
    nova floating-ip-list | awk '{print $2}' > ip1.tmp
    echo "Creating $fip floating IP"

    for i in `seq $fip`
      do
        nova floating-ip-create
    done

    nova floating-ip-list | awk '{print $2}' > ip2.tmp && diff ip1.tmp ip2.tmp | awk '{print $2}' > ip3.tmp

    echo "Deleting $fip floating IP"

    for i in `cat ip3.tmp`
      do
        echo "deleting floating IP $i"
        nova floating-ip-delete $i
     done 
    rm -f ip*.tmp

    nova floating-ip-list
    echo "Try $k is done ..." && sleep 2
  done
