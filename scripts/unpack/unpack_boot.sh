#/bin/bash

clear

source scripts/dumpvars.sh

echo "boot.img解包"

read -p "请将需要解包的boot.img放入工具根目录，并按下回车" var

rm -rf $LOCALDIR/boot

mkdir $LOCALDIR/boot

if [ -e $LOCALDIR/boot.img ]; then
	cp -frp $LOCALDIR/boot.img $bin/AIK/
 	cd $bin/AIK
 	./unpackimg.sh ./boot.img
 	mv ./ramdisk $LOCALDIR/boot/
 	mv ./split_img $LOCALDIR/boot/
 	cd $LOCALDIR
else
 	read -p "没有检测到需要解包的boot.img文件" var
fi

bash main.sh