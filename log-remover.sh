#!/usr/bin/env bash
# zip one day old logs and remove one week old logs

set -x -e

min=1
cd /home/<LOG_LOCATION>
files=$(find . -name "*.log" -type f -mmin +"$min")
for files in ${files[*]}
do
  echo $files
  zip $files-$(date --date="0 days" +%F)_.zip $files
  rm $files
done

zmin=10080
zfiles=$(find . -name "*.zip" -mmin +"$zmin")
for zfiles in ${zfiles[*]}
do
  echo $zfiles
  rm $zfiles
done
