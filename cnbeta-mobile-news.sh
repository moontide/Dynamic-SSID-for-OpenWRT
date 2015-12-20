#!/bin/bash

script_dir=$(dirname "$0")
source "$script_dir/common.sh"

# BusyBox 里的 awk 貌似已经是以字节为单位的了 (也许跟 LANG 环境变量为空有关？)，
# 如果是 gawk 的话，可能需要指定 -b / --characters-as-bytes 参数

cnbeta=$(wget -O - http://m.cnbeta.com/wap | grep 'a href="/wap/view/' | awk -F= "$(cat $script_dir/functions.awk)"'
BEGIN { init_char_int_index(); }

{
	debug=1
# 删除前面的 div 元素 <div class="list">
tmp=substr($0,19);

# 继续删除前面的 a 元素 <a href="/wap/view/333623.htm">
left=index(tmp,">");
tmp=substr(tmp, left+1);

# 删除后面的 a 元素闭合
right=index(tmp,"<")-1;
tmp=substr(tmp,1,right);

# 删除 [， ] 替换为空格
gsub("\\[","",tmp);
gsub("\\]"," ",tmp);

# 保证长度不超过 32 字节
if (length(tmp) > 32)
	tmp=substr(tmp, 1, 32);

if (debug) print "[" tmp "]" > "/dev/stderr";

tmp=fix_utf8_truncation(tmp);

print tmp;
}');

#echo ------------------------
#echo "$cnbeta"
#echo ------------------------

i=0
IFS=$'\n'
for n in $cnbeta
do
	iface_index=${array_wifi_iface_indexes[$i]}

	#echo "[$n]"
	uci set wireless.@wifi-iface[$iface_index].ssid="$n"

	((i++))
	if [[ $i -ge ${#array_wifi_iface_indexes[@]} ]]
	then
		break;
	fi
done
uci commit && wifi
