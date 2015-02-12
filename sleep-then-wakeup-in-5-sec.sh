#!/bin/bash
temp=$(date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s")
((temp+=6))
temp=$(date -j -f "%s" "${temp}" "+%m/%d/%y %H:%M:%S")
pmset displaysleepnow
sudo pmset schedule wake "${temp}"
