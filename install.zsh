#!/bin/zsh
function link_file() {
    [[ $# != 2 ]] && { echo "You should use:\nlink_file <source> <target>"; return; }
    [[ ! -f ${1} ]] && { echo "${1} isn't a valid file."; return; }
    [[ -f ${2} ]] && { echo "${2} is already there"; return; }
    ln -s ${1} ${2}
}

SCRIPT_FILE=$0
SCRIPT_PATH=$(dirname $SCRIPT_FILE)
cd ${SCRIPT_PATH}
python AppleScript/link-AppleScript.py

link_file ${PWD}/build-Emacs.sh /usr/local/bin/buildEmacs
link_file ${PWD}/build-MacVim.sh /usr/local/bin/buildMacVim
