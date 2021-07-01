#!/bin/bash
TARGET=~/.homebridge

backup() {
    rsync -a -r pi:/var/lib/homebridge/ ${TARGET}
    cd ${TARGET}
    git add .
    git commit -am "Cron backup"
    git push origin master
}
sendResult() {
    apikey=$(cat ~/.api/mailgun.apikey)
    subject="Homebridge Backup Result from `hostname -s`"
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v2/xcv58.com/messages \
         -F from='MacVim Building System <homebridge.backup@xcv58.com>' \
         -F to=i@xcv58.com \
         -F subject="${subject}" \
         -F text="${result}"
}
backup
sendResult >> /dev/null
