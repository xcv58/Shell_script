#!/bin/bash
TARGET=~/macvim/src/MacVim/build/Release/MacVim.app
BAK=/Applications/MacVimBak.app
INSTALL=/Applications/MacVim.app

build() {
    cd ~/.macvim/src
    git fetch --all
    ./configure --enable-python3interp=yes --enable-pythoninterp=yes
    result=$(make 2>&1)
    time=$(date "+%m/%d/%y %H:%M:%S")
    echo "${result}"
    echo "${time}"
    result=$(echo "${result}" | tail -2 && echo "${time}")
    if [ -d ${TARGET} ]
    then
        if [ -d ${BAK} ]
        then
            rm -rf ${BAK}
        fi
        mv ${INSTALL} ${BAK}
        mv ${TARGET} ${INSTALL}
    fi
}
sendResult() {
    apikey=$(cat ~/.api/mailgun.apikey)
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v2/xcv58.com/messages \
         -F from='MacVim Building System <macvim.build@xcv58.com>' \
         -F to=i@xcv58.com \
         -F subject='MacVim Build Result' \
         -F text="${result}"
}
build
sendResult >> /dev/null
