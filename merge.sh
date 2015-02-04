#!/bin/bash

dir='何以笙箫默 03'
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
echo ${dir}

cd "${dir}"
find . -depth 1 -iname '*.flv' | grep '_[0-9A-F]\{2\}\.flv$' | xargs -I{} echo "file '{}'" > list.txt
ffmpeg -f concat -i **list.txt** -c copy -y result.flv

# ffmpeg -i merge.flv -f mp4 result.mp4
# rm -f merge.flv list.txt

if [ -f result.flv ]
then
	mv -f result.flv "${dir}.flv"
	ffmpeg -i "${dir}.flv" 2>&1 | tail -n 4 | head -n 3
fi