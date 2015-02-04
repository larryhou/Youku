#!/bin/bash

key='何以笙箫默 03'
while getopts :k:h OPTION
do
	case ${OPTION} in
		k) key=${OPTARG};;
		h) echo "Usage: $(basename $0) -d [FLV_DIR] -h [HELP]"
		   exit;;
		:) echo "ERR: -${OPTARG} 缺少参数, 详情参考: $(basename $0) -h" 1>&2
		   exit 1;;
		?) echo "ERR: 输入参数-${OPTARG}不支持, 详情参考: $(basename $0) -h" 1>&2
		   exit 1;;
	esac
done

find . -depth 1 -type d | grep "${key}" | while read dir
do
	num=$(find "${dir}" -depth 1 -iname '*.flv' | grep '_[0-9A-Z]\{2,\}\.flv$' | wc -l | awk '{print $1}')
	echo -e "${dir}\t ${num}"
done | sort -n -k 3 -k 2