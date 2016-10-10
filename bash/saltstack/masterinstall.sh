#!/bin/bash

# Functions

function echos {
  echo -e " \n  $1 $2"
}

function install {
  for i in $1 $2 $3 $4
    do
      apt-get install -y $i
    done
}

# Body 

echos ...installing add-apt
install python-software-properties software-properties-common
add-apt-repository ppa:saltstack/salt
apt-get update

echos ...installing salt
install salt-master salt-minion salt-ssh salt-cloud salt-doc
echos ...done
