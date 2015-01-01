#!/bin/bash
apikey=$(cat ~/.api/dnsimple.apikey)
domain="xcv58.me"
if [[ $# == 2 ]]; then
    SUBDOMAIN=${1}
    URL=${2}
else
    read -p "Subdomain: " SUBDOMAIN
    read -p "URL: " URL
fi
json='{"record": {"name": "SUBDOMAIN", "record_type": "URL", "content": "DESTINATION", "ttl": 3600, "prio": 10}}'
json=${json/SUBDOMAIN/${SUBDOMAIN}}
json=${json/DESTINATION/${URL}}
echo ${json}
curl  -H "X-DNSimple-Token: ${apikey}" \
      -H 'Accept: application/json' \
      -H 'Content-Type: application/json' \
      -X POST \
      -d "${json}" \
      https://api.dnsimple.com/v1/domains/${domain}/records
