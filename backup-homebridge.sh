#!/bin/bash
TARGET=~/.homebridge
TEMP_FILE=$(mktemp)

backup() {
    rsync -av -r pi:/var/lib/homebridge/ ${TARGET}
    rsync -av -r pi:/etc/cloudflared/ ${TARGET}/cloudflared
    rsync -av -r pi:/home/pi/.cloudflared/ ${TARGET}/home-dir-pi/cloudflared
    rsync -av pi:/home/pi/homeassistant/ ${TARGET}/home-dir-pi/homeassistant
    rsync -av pi:/home/pi/.zhistory ${TARGET}/home-dir-pi/
    rsync -av pi:/home/pi/.bash_history ${TARGET}/home-dir-pi/
    rsync -av pi:/home/pi/compose.yml ${TARGET}/home-dir-pi/
    cd ${TARGET}
    git add .
    git commit -am "Cron backup"
    git push origin master
}
sendResult() {
    apikey=$(cat ~/.api/mailgun.apikey)
    subject="Homebridge Backup Result from `hostname -s`"
    text=$(cat ${TEMP_FILE})
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v3/xcv58.com/messages \
         -F from='Homebridge Backup <homebridge.backup@xcv58.com>' \
         -F to=i@xcv58.com \
         -F subject="${subject}" \
         -F text="${text}"
}
backup 2>&1 | tee ${TEMP_FILE}
sendResult
