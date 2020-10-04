#!/bin/bash

clear

source scripts/dumpvars.sh

echo "vendor.dat.br/dat/img解包"

read -p "请将需要解包的vendor.dat.br/dat/img放入工具根目录，并按下回车" var

if [ -e "$LOCALDIR/vendor.new.dat.br" ]; then
	echo "检测到vendor.new.dat.br"
	"$bin/bin/brotli" -d "$LOCALDIR/vendor.new.dat.br"
	python "$bin/sdat2img.py" vendor.transfer.list vendor.new.dat vendor.img
	bash $unpack/unpackimg.sh vendor
 	read -p "解包完成" var
elif [ -e "$LOCALDIR/vendor.new.dat" ]; then
	echo "检测到vendor.new.dat"
    python "$bin/sdat2img.py" vendor.transfer.list vendor.new.dat vendor.img
    bash $unpack/unpackimg.sh vendor
 	read -p "解包完成" var
elif [ -e "$LOCALDIR/vendor.img" ]; then
	echo "检测到vendor.img"
    bash $unpack/unpackimg.sh vendor
 	read -p "解包完成" var
else
	read -p "没有检测到任何需要解包的文件" var
fi

bash main.sh