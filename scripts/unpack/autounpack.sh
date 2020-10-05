#!/bin/bash

clear 

source scripts/dumpvars.sh

echo "ROM自动解包system/vendor/boot"

read -p "请将需要解包的ROM重命名为update.zip放入工具根目录，并按下回车" var

boot_extract{
	rm -rf $LOCALDIR/boot
	mkdir $LOCALDIR/boot
if [ -e $LOCALDIR/boot.img ]; then
	cp -frp $LOCALDIR/boot.img $bin/AIK/
 	cd $bin/AIK
 	./unpackimg.sh ./boot.img
 	mv ./ramdisk $LOCALDIR/boot/
 	mv ./split_img $LOCALDIR/boot/
 	cd $LOCALDIR
fi
}

system_extract{
	if [ -e "$LOCALDIR/system.new.dat.br" ]; then
	echo "检测到system.new.dat.br"
	"$bin/bin/brotli" -d "$LOCALDIR/system.new.dat.br"
	python "$bin/sdat2img.py" system.transfer.list system.new.dat system.img
	bash $unpack/unpackimg.sh system
elif [ -e "$LOCALDIR/system.new.dat" ]; then
	echo "检测到system.new.dat"
    python "$bin/sdat2img.py" system.transfer.list system.new.dat system.img
    bash $unpack/unpackimg.sh system
elif [ -e "$LOCALDIR/system.img" ]; then
	echo "检测到system.img"
    bash $unpack/unpackimg.sh system
fi
}

vendor_extract{
	if [ -e "$LOCALDIR/vendor.new.dat.br" ]; then
	echo "检测到vendor.new.dat.br"
	"$bin/bin/brotli" -d "$LOCALDIR/vendor.new.dat.br"
	python "$bin/sdat2img.py" vendor.transfer.list vendor.new.dat vendor.img
	bash $unpack/unpackimg.sh vendor
elif [ -e "$LOCALDIR/vendor.new.dat" ]; then
	echo "检测到vendor.new.dat"
    python "$bin/sdat2img.py" vendor.transfer.list vendor.new.dat vendor.img
    bash $unpack/unpackimg.sh vendor
elif [ -e "$LOCALDIR/vendor.img" ]; then
	echo "检测到vendor.img"
    bash $unpack/unpackimg.sh vendor
fi
}

if [ -e update.zip ]; then
	echo "检测到update.zip"
	unzip $LOCALDIR/update.zip system* vendor* boot*
	boot_extract
	system_extract
	vendor_extract
	echo "解包完成"
else
	read -p "没有检测到需要解包的update.zip" var
fi

bash main.sh