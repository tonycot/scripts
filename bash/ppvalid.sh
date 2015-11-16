#!/bin/bash
excode=0

function ppvd {
  cd $1
  echo -e "\n======== Start puppet syntax test in $1 ========\n"
    find . -iname '*.pp' |  xargs puppet parser validate
    if [[ $? -ne "0" ]] 
      then         
        excode=1
    fi  
  cd - 
}

function rbvd {
  cd $1
  echo -e "\n======== Start ruby syntax test in $1 ========\n"  
    find . -iname '*.erb' | erb -x -T '-' | ruby -c
      if [[ $? -ne "0" ]]
        then
          excode=1
      fi
  cd - 
}

# My Puppet repository
for diro in $(find . -name '.git' | grep -oP '.*(?=/)' | sort -u )
  do 
    echo -e "\n======== My Puppet repository is $diro  ========\n"      
    ppvd $diro
    rbvd $diro
  done

exit $excode
