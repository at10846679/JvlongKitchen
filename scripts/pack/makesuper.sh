#!/bin/bash

source ../dumpvars.sh


echo "

开始打包

请确保要打包的所有img在工具根目录下且为rimg (必须遵守)

当前支持打包super.img的分区有 system vendor product odm

super分区大小为要打包的rimg的总大小+1G(至少要+1G否则可能会报错)

super最终实际可用大小等于要打包的rimg的总大小

打包数据用G为单位时候要为整数

如果打包数据不为整数时用M为单位

用B为单位打包时无需带单位
"

if [ -e ./system.img ];then
 mv ./system.img ./bin/build_super/
fi
 
if [ -e ./vendor.img ];then
 mv ./vendor.img ./bin/build_super/
fi

if [ -e ./product.img ];then
 mv ./product.img ./bin/build_super/
fi

if [ -e ./odm.img ];then
 mv ./odm.img ./bin/build_super/
fi

cd ./bin/build_super
cat ./misc_into.txt >>./build_super.txt

read -p "请输入你要打包的分区 (多个分区记得留空格): " partition
read -p "请输入super分区大小: " supersize

superM="$(echo "$supersize" | sed 's/M//g')"
superG="$(echo "$supersize" | sed 's/G//g')"

if [ $(echo "$supersize" | grep 'M') ];then
 superssize="$(($superM*1024*1024))"
elif [ $(echo "$supersize" | grep 'G') ];then
 superssize="$(($superG*1024*1024*1024))"
else
 superssize="$supersize"
fi

read -p "请输入super最终实际可用大小: " size

sizeM="$(echo "$size" | sed 's/M//g')"
sizeG="$(echo "$size" | sed 's/G//g')"

if [ $(echo "$size" | grep 'M') ];then
 ssize="$(($sizeM*1024*1024))"
elif [ $(echo "$size" | grep 'G') ];then
 ssize="$(($sizeG*1024*1024*1024))"
else
 ssize="$size"
fi

echo "dynamic_partition_list=$partition
super_main_partition_list=$partition
super_super_device_size=$superssize
super_main_group_size=$ssize
" >> ./build_super.txt
echo "super.img生成信息整合完毕,正在生成super.img....."
python3 ./build_super_image.py ./build_super.txt ./super.img
rm -rf ./build_super.txt
echo "super.img已生成，已输出至super目录"
cd ../../
rm -rf ./super
mkdir ./super
mv ./bin/build_super/*img ./
mv ./super.img ./super/
