#!/bin/bash

ERROR_CD=1		# 文件夹无法进入

ENTER_LABEL="选择文件/进入文件夹"
DONE_LABEL="选择当前文件夹"
TITLE="浏览"
TIP="当前路径: "

tmpfile=$(mktemp)

function show()
{
	local init_dir=$(realpath "$1")
	if ! cd "$init_dir"; then
		return $ERROR_CD
	fi
	local list=$(ls -aQ)	# -a 显示隐藏文件, -Q 每个文件左右两边添加双引号并转义特殊字符
	local old_IFS=$IFS
	IFS=$'\n'
	listarr=($list)	# 按换行符分割
	IFS=$old_IFS
	list=''
	for i in ${!listarr[*]}; do
		# 每一个文件, 添加修改日期和文件类型信息到右边
		list="$list ${listarr[$i]} \"$(eval "date -d @\$(stat ${listarr[$i]} -c %Y) '+%Y-%m-%d %T'")    $(eval "stat ${listarr[$i]} -c %F")\""
	done
	eval "dialog --ok-label '$ENTER_LABEL' --cancel-label '$DONE_LABEL' --title '$TITLE' --menu '${TIP}${init_dir}' 0 0 0 $list 2>'$tmpfile'"
	return 0
}

function next_action()
{
	local item=$1
	if [ "$item" == "" ]; then
		# 选择了当前文件夹, 直接输出当前路径到缓存文件
		echo "$(pwd)" >"$tmpfile"
		return 0
	fi
	local typ=$(ls -ld "$item" | cut -c 1)
	if [ "$typ" == "d" ]; then
		# 是目录, 进入
		browse_dir "$item"
	elif [ "$typ" == "l" ]; then
		# 是符号链接, 判断链接到的文件是目录还是其他
		local lnk=$(readlink "$item")
		if ! cd "$(dirname "$lnk")"; then
			return $ERROR_CD
		fi
		next_action "$(basename "$lnk")"
	else
		# 其他当普通文件处理, 文件名输出到缓存文件
		echo "$(realpath "$item")" >"$tmpfile"
	fi
}

function browse_dir()
{
	local status
	local init_dir=$1
	show "$init_dir"
	status=$?
	if [ $status -ne 0 ]; then
		return $status
	fi
	local item=$(cat "$tmpfile")
	next_action "$item"
}

INIT_DIR=${1:-./}

browse_dir "$INIT_DIR"
status=$?
if [ $status -ne 0 ]; then
	exit $status
fi
result=$(cat "$tmpfile")
rm -f "$tmpfile"
echo "$result" >&2
exit 0