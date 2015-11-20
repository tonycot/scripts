#!/bin/bash
#
# version alfa 0.2
# Put this script near by of your local repository folders.
# The common strategy of this script is to find repository via .git folder and after activate the checks of puppet code  and ruby.
#

# Exit code defenition
excode=0

# Functions

# Puppet validation function 
# You can modify the function to change the validation activity

function ppvd {
  cd $1
  echo -e "\n=== Start puppet syntax test in $1 ===\n"
  ignor="zabbix/manifests/profiles/agent.pp"
  find . -iname '*.pp' |  grep -v $ignor | xargs puppet parser validate
  if [[ $? -ne "0" ]] 
    then         
      excode=1
  fi  
  cd - 
}

# Ruby validation function 
# You can modify the function to change the validation activity

function rbvd {
  cd $1
  echo -e "\n=== Start ruby syntax test in $1 ===\n"  
  find . -iname '*.erb' | erb -x -T '-' | ruby -c
  if [[ $? -ne "0" ]]
    then
      excode=1
  fi
  cd - 
}

# Puppet-lint validation function
# You can modify the function to change the validation activity
function plvd {
  cd $1
  echo -e "\n=== Start puppet-lint syntax test in $1 ===\n"
  fs=$(find . -iname '*.pp')
  if [[ -n $fs ]]
    then
      echo $fs | xargs puppet-lint --error-level error
  fi
  cd -
}

# Main functionality
 
for diro in $(find . -name '.git' | grep -oP '.*(?=/)' | sort -u )
  do 
    echo -e "\n======== Current Puppet repository is $diro  ========\n"      
    ppvd $diro
    rbvd $diro
    plvd $diro
  done

# Exit code defenition
if [[ $excode -eq "1" ]]
  then
    echo "TRACE: Crash with ERROR"
  else
    echo "Validation is Successful"
fi
exit $excode
