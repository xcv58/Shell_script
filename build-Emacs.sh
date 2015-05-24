#!/bin/bash
TARGET=~/.emacs/nextstep/Emacs.app
BAK=/Applications/EmacsBAK.app
INSTALL=/Applications/Emacs.app

build() {
    start_timestamp=$(date "+%s")
    cd ~/.emacs
    git reset --hard HEAD
    git remote | xargs -n 1 git pull
    ./configure --with-ns
    result=$(make install 2>&1)
    time=$(date "+%m/%d/%y %H:%M:%S")
    echo "${result}"
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
    subject="Emacs Build Result from `hostname -s`"
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v2/xcv58.com/messages \
         -F from='Emacs Building System <emacs.build@xcv58.com>' \
         -F to=i@xcv58.com \
         -F subject="${subject}" \
         -F text="${result}"
}
build
sendResult >> /dev/null
