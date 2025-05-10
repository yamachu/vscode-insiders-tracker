#!/bin/bash -e

if [ $# != 2 ]; then
    echo "Usage: $0 platform output"
    exit 1
fi

latest_version=$(curl -s https://update.code.visualstudio.com/api/commits/insider/$1 | jq -r '.[0]')
if $(grep -q "$latest_version" $2); then
    exit 0
fi

curl -s https://update.code.visualstudio.com/api/versions/commit:${latest_version}/$1/insider \
    | jq -r '[.url, .version, .productVersion, .timestamp]|@csv' >> $2
