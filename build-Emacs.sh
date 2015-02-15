#!/bin/bash
TARGET=~/emacs/nextstep/Emacs.app
BAK=/Applications/EmacsBAK.app
INSTALL=/Applications/Emacs.app

build() {
    cd ~/emacs
    git fetch --all
    ./configure --with-ns
    make install
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
    result=$(tail -2 ~/.emacsbuildlog)
    apikey=$(cat ~/.api/mailgun.apikey)
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v2/xcv58.com/messages \
         -F from='Emacs Building System <emacs.build@xcv58.com>' \
         -F to=i@xcv58.com \
         -F subject='Emacs Build Result' \
         -F text="${result}"
}
build
date "+%m/%d/%y %H:%M:%S"
sendResult >> /dev/null
