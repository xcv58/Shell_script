#!/bin/bash
usename=xcv58
targets=( $(curl -s https://github.com/${usename}?tab=repositories | awk '/<h3 class="repo-list-name">/,/<\/h3>/' | grep "<a.*" | grep -o "/[^\"]*") )
prefix=https://raw.githubusercontent.com
suffix=/gh-pages/CNAME
for repo in "${targets[@]}"
do
    response=$(curl -s ${prefix}${repo}${suffix})
    if [ "${response}" != "Not Found" ];
    then
        echo ${repo}
        echo ${response}
        echo
    fi
done
