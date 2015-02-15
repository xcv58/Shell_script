#!/bin/bash
build() {
    cd ~/emacs
    git fetch --all
    ./configure --with-ns
    make install
    if [ -d ~/emacs/nextstep/Emacs.app ]
    then
        if [ -d /Applications/EmacsBAK.app ]
        then
            rm -rf /Applications/EmacsBAK.app
        fi
        mv /Applications/Emacs.app /Applications/EmacsBAK.app
        mv ~/emacs/nextstep/Emacs.app /Applications/Emacs.app
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
date
sendResult
