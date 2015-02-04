#!/bin/bash

find . -depth 1 -type d | while read dir
do
	num=$(find "${dir}" -type f | wc -l | awk '{print $1}')
	if [ ${num} -eq 0 ]
	then
		rm -frv "${dir}"
	fi
done