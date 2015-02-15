#!/bin/bash
TARGET=~/macvim/src/MacVim/build/Release/MacVim.app
BAK=/Applications/MacVimBak.app
INSTALL=/Applications/MacVim.app

build() {
    cd ~/macvim/src
    git fetch --all
    ./configure
    make
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
    result=$(tail -3 ~/.macvimBuildLog)
    apikey=$(cat ~/.api/mailgun.apikey)
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v2/xcv58.com/messages \
         -F from='MacVim Building System <macvim.build@xcv58.com>' \
         -F to=i@xcv58.com \
         -F subject='MacVim Build Result' \
         -F text="${result}"
}
build
date "+%m/%d/%y %H:%M:%S"
sendResult >> /dev/null
