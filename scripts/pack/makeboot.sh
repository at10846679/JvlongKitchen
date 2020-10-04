#!/bin/bash

source ../dumpvars.sh

echo "正在生成new-boot.img....."
mv ./boot/* $bin/AIK/
cd $bin/AIK
./repackimg.sh --forceelf
mv ./image-new.img ./boot-new.img
mv ./boot-new.img ../../boot/
rm -rf ./split_img
rm -rf ./ramdisk
rm -rf ./boot.img
if [ -e $(pwd)/ramdisk-new.cpio.gz ]; then
 rm -rf $(pwd)/ramdisk-new.cpio.gz
fi
echo "生成完毕，输出至boot目录"
