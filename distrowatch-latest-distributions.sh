#!/bin/bash

script_dir=$(dirname "$0")
source "$script_dir/common.sh"

latest_releases=$(wget -O - http://distrowatch.com/news/dwd.xml | grep title | tail -n +3 | awk -F= '{tmp=substr($0, 8); i=index(tmp, "<")-1; print substr(tmp, 1, i);}')
i=0
IFS=$'\n'
for r in $latest_releases
do
	iface_index=${array_wifi_iface_indexes[$i]}

	# 去掉 <title> 和 </title>
	#r=${r/\<title\>/}
	##r=${r/\<\/title\>/}	# not working in BusyBox

	uci set wireless.@wifi-iface[$iface_index].ssid="$r"

	((i++))
	if [[ $i -ge ${#array_wifi_iface_indexes[@]} ]]
	then
		break;
	fi
done
uci commit && wifi
