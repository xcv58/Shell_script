#!/bin/bash
TARGET=~/.homebridge

backup() {
    rsync -a -r pi:/var/lib/homebridge/ ${TARGET}
    rsync -a pi:/etc/cloudflared/config.yml ${TARGET}/cloudflared/
    rsync -a pi:/home/pi/.zhistory ${TARGET}/home-dir-pi/
    rsync -a pi:/home/pi/.bash_history ${TARGET}/home-dir-pi/
    cd ${TARGET}
    git add .
    git commit -am "Cron backup"
    git push origin master
}
sendResult() {
    apikey=$(cat ~/.api/mailgun.apikey)
    subject="Homebridge Backup Result from `hostname -s`"
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v3/xcv58.com/messages \
         -F from='Homebridge Backup <homebridge.backup@xcv58.com>' \
         -F to=i@xcv58.com \
         -F subject="${subject}" \
         -F text="Success"
}
backup
sendResult
