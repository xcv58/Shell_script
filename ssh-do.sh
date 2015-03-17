#!/bin/bash
command="ssh doReverse_`hostname -s` -Nf"
echo ${command}
osascript <<EOF
display notification with title "Reconnect" subtitle "${command}"
EOF
ps aux | grep "${command}" | grep -v grep | awk '{print $2}' | xargs kill
echo "Reconnect ${command}" `date` >> ~/.ssh_do_log
sleep 5
${command}
