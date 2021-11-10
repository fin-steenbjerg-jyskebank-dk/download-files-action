#!/bin/sh -l
#set -x

echo "transfering file $1 with name $2 and version $3 at" $(date)

filename=$(basename "$1")
filesize=$(stat -c %s "$1")
url="https://artifacts.stonemountain.dk/packages/$2/versions/$3/file/$filename?size=$filesize"

access_token=$(\
    curl -s -X POST 'https://auth.stonemountain.dk/realms/house/protocol/openid-connect/token' \
    -H 'content-type: application/x-www-form-urlencoded' \
    -d "client_id=$4" \
    -d "client_secret=$5" \
    -d 'grant_type=client_credentials' | jq --raw-output '.access_token' \
)

echo "Invoking url: $url"

curl -s -o /dev/null -w "Status code=%{http_code}\n" -X POST -H 'Content-Type: application/octet-stream' -H "Content-Length: $filesize" --data-binary "@$1" $url -H "Authorization: Bearer $access_token"

time=$(date)

echo "Time: $time"
echo "::set-output name=time::$time"
