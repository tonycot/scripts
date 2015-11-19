#!/bin/bash
#
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
    find . -iname '*.pp' |  xargs puppet parser validate --render-as yaml
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
    find . -iname '*.pp' |  xargs puppet-lint
    if [[ $? -ne "0" ]]
      then
        excode=1; echo $excode
    fi
  cd -
}

# Main functionality
 
for diro in $(find . -name '.git' | grep -oP '.*(?=/)' | sort -u )
  do 
    echo -e "\n======== Current Puppet repository is $diro  ========\n"      
    ppvd $diro
#    rbvd $diro
#    plvd $diro
  done

exit $excode
