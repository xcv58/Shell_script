#!/usr/bin/env sh
cd ~/Dropbox
FILE=".ip_`hostname -s`"
[ -f ${FILE} ] || touch ${FILE}

exe() {
    echo ${@} | tee -a ${FILE}
    eval ${@} | tee -a ${FILE}
    echo "\n" | tee -a ${FILE}
}

exe date
exe /sbin/ifconfig
exe curl ifconfig.co
exe curl ipv4.icanhazip.com
