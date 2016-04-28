#!/bin/zsh
function link_file() {
    [[ $# != 2 ]] && { echo "You should use:\nlink_file <source> <target>"; return; }
    [[ ! -f ${1} ]] && { echo "${1} isn't a valid file."; return; }
    [[ -f ${2} ]] && { echo "${2} is already there"; return; }
    ln -s ${1} ${2}
}

function link_build_scripts() {
    link_file ${PWD}/build-Emacs.sh /usr/local/bin/buildEmacs
    link_file ${PWD}/build-MacVim.sh /usr/local/bin/buildMacVim
}

function link_bin() {
    for file in ${PWD}/bin/*; do
        command="ln -fs ${file} /usr/local/bin/${file:t:s/.sh//}"
        echo ${command}
        eval ${command}
    done
}

function link_reverse_SSH_tunneling() {
    link_file ${PWD}/ssh-do-daemon.sh /usr/local/bin/ssh-do-daemon
    link_file ${PWD}/ssh-ngrok-daemon.sh /usr/local/bin/ssh-ngrok-daemon
}

function prepare_applescript() {
    python AppleScript/link-AppleScript.py
}

function link_plist_for_launchctl() {
    local LAUNCHCTL_PATH="~/Library/LaunchAgents"
    local PLIST_PATH="${PWD}/plist"
    for plist_file in "${PLIST_PATH}"/*.plist; do
        link_command="ln -sf ${plist_file} ${LAUNCHCTL_PATH}/${plist_file:t}"
        echo ${link_command}
        eval ${link_command}
    done
}

SCRIPT_FILE=$0
SCRIPT_PATH=$(dirname $SCRIPT_FILE)
cd ${SCRIPT_PATH}
source ./base.zsh

SPLIT_LINE="----------------------------------------------------------------"

echo ${SPLIT_LINE}
echo "prepare applescript"
echo ${SPLIT_LINE}
prepare_applescript

echo
echo ${SPLIT_LINE}
echo "link build scripts"
echo ${SPLIT_LINE}
link_build_scripts
link_reverse_SSH_tunneling

echo
echo ${SPLIT_LINE}
echo "link bin files"
echo ${SPLIT_LINE}
link_bin

echo
echo ${SPLIT_LINE}
echo "link plist for launchctl"
echo ${SPLIT_LINE}
link_plist_for_launchctl
