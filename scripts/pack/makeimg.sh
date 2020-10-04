#!/bin/bash

source ../dumpvars.sh

LOCALDIR=`cd "$( dirname $0 )" && pwd`
cd $LOCALDIR

echo ""
read -p "请输入要打包的分区(别带.img): " species

echo "
开始打包

当前img大小为: 

_________________

`du -sh ./out/$species | awk '{print $1}'`

`du -sm ./out/$species | awk '{print $1}' | sed 's/$/&M/'`

`du -sb ./out/$species | awk '{print $1}' | sed 's/$/&B/'`
_________________

使用G为单位打包时必须带单位且为整数
使用B为单位打包时无需带单位且在自动识别的大小添加一定大小
推荐用M为单位大小进行打包需带单位且在自动识别的大小添加至少130M大小
"

read -p "请输入要打包的数值: " size

M="$(echo "$size" | sed 's/M//g')"
G="$(echo "$size" | sed 's/G//g')"

if [ $(echo "$size" | grep 'M') ];then
 ssize=$(($M*1024*1024))
elif [ $(echo "$size" | grep 'G') ];then
 ssize=$(($G*1024*1024*1024))
else
 ssize=$size
fi

if [ $species = "system" ];then
 $bin/mkuserimg_mke2fs.sh ./out/$species/$species ./out/$species'.img' ext4 /$species $ssize -j '0' -T '1230768000' -C ./out/config/$species'_fs_config' -L $species ./out/config/$species'_file_contexts' 2> ./out/error.log
else
 $bin/mkuserimg_mke2fs.sh ./out/$species/ ./out/$species'.img' ext4 /$species $ssize -j '0' -T '1230768000' -C ./out/config/$species'_fs_config' -L $species ./out/config/$species'_file_contexts' 2> ./out/error.log 
fi
sed -i '1d' ./out/error.log

if [ -s ./out/error.log ];then
 echo "打包失败，请去out目录检查错误日志"
else
 echo "打包完成"
 rm -rf ./out/error.log
 echo "输出至SGSI文件夹"
fi

if [ -e ./SGSI ];then
 rm -rf ./SGSI
 mkdir ./SGSI
else
 mkdir ./SGSI
fi

if [ -e ./SGSI ];then
 mv ./out/$species'.img' ./SGSI
 cp -r ./刷机教程.txt ./SGSI
 #检测精简app的zip
 if [ -e ./out/delete.zip ];then
   mv ./out/delete.zip ./SGSI
 fi
fi
