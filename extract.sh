#!/bin/bash

dir='两性奥秘'
while getopts :d:h OPTION
do
	case ${OPTION} in
		d) dir=${OPTARG};;
		h) echo "Usage: $(basename $0) -d [FLV_DIR] -h [HELP]"
		   exit;;
		:) echo "ERR: -${OPTARG} 缺少参数, 详情参考: $(basename $0) -h" 1>&2
		   exit 1;;
		?) echo "ERR: 输入参数-${OPTARG}不支持, 详情参考: $(basename $0) -h" 1>&2
		   exit 1;;
	esac
done

cd "${dir}"
find . -depth 1 -type d | grep '^\.\/[^\.]' | while read line
do
	epi=$(echo ${line} | awk -F/ '{print $2}')
	if [ -f "${epi}/${epi}.flv" ]
	then
		mv -fv "${epi}/${epi}.flv" "${epi}.flv"
	fi
done