#!/bin/sh -l
echo "transfering file $1 to $2?$3= at" $(date)
pwd
ls -l $1
time=$(date)
echo "Time: $time"
echo "::set-output name=time::$time"
