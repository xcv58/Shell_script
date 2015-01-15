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

while :
do
    result=$(lsof -i ":${port}")
    if [ -z "${result}" ]; then
        break
    fi
    ((port++))
    if [ ${port} -eq 65535 ]; then
        echo "No available port, EXIT."
        exit
    fi
done

address=$(ifconfig | grep -o "inet [a-z:]*[0-9\.]*" | grep -v "127.0.0.1" | sed -e "s/inet [a-z:]*//g" | head -1)
echo
url="${address}:${port}"
echo "${url}"
if [ "$unamestr" = 'Darwin' ]; then
    echo "${url}" | pbcopy
    osascript <<EOF
display notification with title "Copy to Clipboard" subtitle "${url}"
EOF
fi

nodeServer=$(which http-server)
if [ ${nodeServer} ]; then
    http-server . -p ${port}
else
    python -m SimpleHTTPServer ${port}
fi
