#!/bin/bash
TARGET=~/.macvim/src/MacVim/build/Release/MacVim.app
BAK=/Applications/MacVimBak.app
INSTALL=/Applications/MacVim.app

build() {
    start_timestamp=$(date "+%s")
    cd ~/.macvim/src
    git reset --hard HEAD
    git remote | xargs -n 1 git pull
    ./configure --enable-pythoninterp=yes
    exec 5>&1
    result=$(make 2>&1 | tee /dev/fd/5)
    time=$(date "+%m/%d/%y %H:%M:%S")
    echo "${time}"
    end_timestamp=$(date "+%s")
    result=$(echo "${result}" | tail -1 && echo "${time}" && echo "${end_timestamp}-${start_timestamp}=$(expr ${end_timestamp} - ${start_timestamp})")
    if [ -d ${TARGET} ]
    then
        if [ -d ${BAK} ]
        then
            rm -rf ${BAK}
        fi
        if [ -d ${INSTALL} ]
        then
            mv ${INSTALL} ${BAK}
        fi
        mv ${TARGET} ${INSTALL}
    fi
}
sendResult() {
    apikey=$(cat ~/.api/mailgun.apikey)
    subject="MacVim Build Result from `hostname -s`"
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v2/xcv58.com/messages \
         -F from='MacVim Building System <macvim.build@xcv58.com>' \
         -F to=i@xcv58.com \
         -F subject="${subject}" \
         -F text="${result}"
}
build
sendResult >> /dev/null
