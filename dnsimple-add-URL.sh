#!/bin/bash
apikey=$(cat ~/.api/dnsimple.apikey)
domains=("xcv58.me" "xcv58.com")
if [[ $# > 1 ]]; then
    SUBDOMAIN=${1}
    URL=${2}
else
    read -p "Subdomain: " SUBDOMAIN
    read -p "URL: " URL
fi
if [[ $# == 3 && $(($3 - 1)) < ${#domains[@]} ]]; then
    DOMAIN=${domains[$(($3 - 1))]}
else
    for (( i = 0 ; i < ${#domains[@]} ; i++ )) do
        echo $((i+1))": ${domains[$i]}"
    done
    while true; do
        read -p "" num
        if [[ ${num} > 0 && $(($num - 1)) < ${#domains[@]} ]]; then
            DOMAIN=${domains[$((num - 1))]}; break;
        else
            echo "Please input number in the range 1..${#domains[@]}"
        fi
    done
fi
json='{"record": {"name": "SUBDOMAIN", "record_type": "URL", "content": "DESTINATION", "ttl": 3600, "prio": 10}}'
json=${json/SUBDOMAIN/${SUBDOMAIN}}
json=${json/DESTINATION/${URL}}
echo "${SUBDOMAIN}.${DOMAIN} -> ${URL}"
curl  -H "X-DNSimple-Token: ${apikey}" \
      -H 'Accept: application/json' \
      -H 'Content-Type: application/json' \
      -X POST \
      -d "${json}" \
      https://api.dnsimple.com/v1/domains/${DOMAIN}/records
