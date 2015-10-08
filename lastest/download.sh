#!/bin/bash

cat 38.txt | while read seg
do
	flv=$(curl -s -I ${seg} | grep 'Location' | awk '{print $2}' | awk -F'.flv' '{print $1".flv"}')
	name=$(echo ${flv} | awk -F/ '{print $NF}')
	wget --progress=bar \
		--header "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11) AppleWebKit/601.1.56 (KHTML, like Gecko) Version/9.0 Safari/601.1.56" \
		${flv} -O ${name}
done
