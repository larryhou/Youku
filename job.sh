#!/bin/bash

reload=0
web='http://v.youku.com/v_show/id_XODY4NjkyOTQ4.html'
while getopts :u:hr OPTION
do
	case ${OPTION} in
		u) web=${OPTARG};;
		r) reload=1;;
		h) echo "Usage: $(basename $0) -u [TV_YOUKU_URL] -h [HELP]"
		   exit;;
		:) echo "ERR: -${OPTARG} 缺少参数, 详情参考: $(basename $0) -h" 1>&2
		   exit 1;;
		?) echo "ERR: 输入参数-${OPTARG}不支持, 详情参考: $(basename $0) -h" 1>&2
		   exit 1;;
	esac
done
echo ${web}

#-x 'http://web-proxy.oa.com:8080'
epi=$(curl -s ${web} | grep '<title>[^>]\{1,\}' | awk -F\> '{print $2}' | awk -F\— '{print $1}')
if [ "${epi}" = "" ]
then
	bash $0 -u ${web}
	exit
fi

echo "${epi}"
if [ ${reload} -eq 1 ]
then
	rm -fr "${epi}"
fi

if [ -d "${epi}" ]
then
	if [ -f "${epi}/README.txt" ]
	then
		exit
	else
		rm -fr "${epi}"
	fi
fi

mkdir "${epi}"

api="http://www.flvcd.com/parse.php?kw=$(php -r "echo urlencode('${web}');")&flag=one&format=super"
curl -s ${api} | iconv -f gbk -t utf-8 | sed 's;</[^>]\{1,\}>;\
;g'| grep '<a' | grep 'k.youku.com' | grep -i 'flv' | awk -F\" '{print $2}' | while read link
do
	name=$(echo ${link} | awk -F/ '{print $7}')
	url=$(curl -s -I ${link} | grep Location | awk '{print $2}' | sed 's/[[:space:]]//g')
	echo ${url} >> "${epi}/list.txt"
	echo ${url}
	
	axel -n 6 -o "${epi}/${name}.flv" ${url}
	
	if [ ! -f "${epi}/${name}.flv" ]
	then
		let num=num+1
		echo ${num} > "${epi}/num.txt"
	fi
done

if [ ! -f "${epi}/num.txt" ]
then
	mv -f "${epi}/list.txt" "${epi}/README.txt" 2>/dev/null
fi