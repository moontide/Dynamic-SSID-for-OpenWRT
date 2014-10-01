#!/bin/sh

latest_releases=$(wget -O - http://distrowatch.com/news/dwd.xml | grep title | tail -n +3 | awk -F= '{tmp=substr($0, 8); i=index(tmp, "<")-1; print substr(tmp, 1, i);}')
i=0
IFS=$'\n'
for r in $latest_releases
do
	i=$(expr $i + 1)

	# 去掉 <title> 和 </title>
	#r=${r/\<title\>/}
	##r=${r/\<\/title\>/}	# not working in BusyBox

	uci set wireless.@wifi-iface[$i].ssid="$r"

	if [[ $i -ge 7 ]]
	then
		break;
	fi
done
uci commit && wifi
