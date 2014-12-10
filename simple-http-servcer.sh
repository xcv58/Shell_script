#!/bin/bash
unamestr=`uname`

if [ $# -eq 1 ]; then
    if [ $1 -gt 1023 ] && [ $1 -lt 65535 ]; then
        port=${1}
    else
        echo "${1} is not valid port. Set default port 8000"
    fi
fi

if [ -z "${port}" ]; then
    port=8000
fi

address=$(ifconfig | grep -o "inet [a-z:]*[0-9\.]*" | grep -v "127.0.0.1" | sed -e "s/inet [a-z:]*//g")
echo
echo "${address}:${port}"
if [ "$unamestr" = 'Darwin' ]; then
    echo "${address}:${port}" | pbcopy
fi

python -m SimpleHTTPServer ${port}
