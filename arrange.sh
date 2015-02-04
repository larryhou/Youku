#!/bin/bash
find . -depth 2 -iname '*.flv' | grep ' [0-9]\{1,\}\.flv$' | while read line
do
	epi=$(echo ${line} | awk -F/ '{print $2}')
	
	dir=$(echo ${epi} | sed 's/ [0-9]\{2,\}$//')
	echo ${dir}
	
	if [ ! -d "${dir}" ]
	then
		mkdir "${dir}"
	fi
	
	if [ ! -f "${dir}/${epi}" ]
	then
		mv -fv "${epi}" "${dir}/"
		mv -fv "${dir}/${epi}/${epi}.flv" "${dir}/${epi}.flv"
	fi
done