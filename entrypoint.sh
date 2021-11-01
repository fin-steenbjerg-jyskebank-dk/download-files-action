#!/bin/sh -l
set -x
echo "transfering file $1 with name $2 and version $3 at" $(date)

filename=$(basename "$1")
filesize=$(stat -c %s "$1")

curl --version
curl -v -X POST -H 'Content-Type: application/octet-stream' --data-binary "@$1" https://artifacts.stonemountain.dk/packages/$2/versions/$3/file/$filename?size=$filesize

time=$(date)
echo "Time: $time"
echo "::set-output name=time::$time"
