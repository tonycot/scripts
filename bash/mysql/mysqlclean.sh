#!/bin/bash

LIMIT=1000

let any_deleted=`mysql -D keystone -e "SELECT COUNT(*) FROM token" -s -N`
let RUNS="$any_deleted/$LIMIT"
while [[ $RUNS -gt "0" ]]
  do
    let RUNS=--RUNS
    mysql keystone -e "DELETE FROM token WHERE token.expires < \"$(date --date='2 days ago' +'%Y-%m-%d %H:%M:%S')\" limit $LIMIT;"
    sleep 2
  done
echo exit
