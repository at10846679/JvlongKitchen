#!/bin/bash

clear

source scripts/dumpvars.sh

echo "super.img 动态分区镜像解包"

read -p "请将需要解包的super.img放入工具根目录，并按下回车" var

rm -rf $LOCALDIR/super
mkdir $LOCALDIR/super

file $(find -type f -name 'super.img') > $LOCALDIR/file.txt

echo "识别到$(find ./ -type f -name 'super.img')"

if [ $(grep -o 'sparse' ./file.txt) ]; then
	echo "当前super.img转换为rimg中......"
	$bin/bin/simg2img $(find ./ -type f -name 'super.img') $LOCALDIR/superr.img
	echo "转换完成"
	echo "解包super.img中....."
	$bin/bin/lpunpack $LOCALDIR/superr.img $LOCALDIR/super
 	rm -rf $LOCALDIR/superr.img
 	read -p "解包完成" var
elif [ $(grep -o 'data' $LOCALDIR/file.txt) ]; then
 	echo "解包super.img中....."
 	$bin/bin/lpunpack $(find ./ -type f -name 'super.img') ./super
 	rm -rf $LOCALDIR/super.img
 	read -p "解包完成" var
else
	read -p "没有检测到需要解包的super.img文件" var
fi

rm -rf $LOCALDIR/file.txt

bash main.sh
