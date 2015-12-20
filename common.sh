#!/bin/bash

# 用来获取公共的参数

# 参数1 用来确定需要设置的所有 wifi_iface 索引号的集合
# 单个 wifi_iface：
#	只需要指定单个索引号即可，比如 0 或 1 或 7
# 多个 wifi_iface：
#	如果是不连续的，则需要用半角逗号分开，如： 0,3,5
#	如果是连续的，可用 n-N 的形式书写，如： 3-7
#	当然，可以不连续的和连续的可以写在一起，如： 0,2-5,7
#
# -- 其实，直接用 bash 的“花括号扩展”功能直接写也可以： {0,{2..5},7}
#
#

# 解析参数1：索引集合
wifi_iface_indexes_params=${1//,/ }
array_wifi_iface_indexes_params=( $wifi_iface_indexes_params )
#echo "$wifi_iface_indexes_params"
i=0
for param in $wifi_iface_indexes_params
do
	if [[ "$param" =~ ^[0-9]+$ ]]
	then
		#echo "$param: 单个 wifi_iface 索引"
		array_wifi_iface_indexes[$i]=$param
		((i++))
	elif [[ "$param" =~ ^[0-9]+-[0-9]+$ ]]
	then
		array_temp=( $(eval echo "{${param/-/..}}" ) )
		array_wifi_iface_indexes=( "${array_wifi_iface_indexes[@]}" "${array_temp[@]}" )
		#echo "$param: wifi_iface 索引区间: ${array_temp[@]}"
		#echo "${array_wifi_iface_indexes[@]}"
		((i+=${#array_temp[@]}))
	#else
	#	#echo "$param 非法"
	#	echo
	fi
done
#echo "${array_wifi_iface_indexes[@]}"

if [[ $i -eq 0 ]]
then
	echo "第一个参数需要指定要设置的 wifi_iface 索引号集合。"
	echo "索引号集合可以按照以下几种方式书写："
	echo "	单个索引号。                如： 0 "
	echo "	多个不连续索引号。          如： 1,3,5"
	echo "	索引号区间（连续索引号）。  如： 3-8"
	echo "	或上述集中情况的集合。      如： 2,5-8,9,10"
	exit 1
fi
