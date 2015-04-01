#!/bin/zsh
SCRIPT_FILE=$0
SCRIPT_PATH=$(dirname $SCRIPT_FILE)
cd ${SCRIPT_PATH}
python AppleScript/link-AppleScript.py
