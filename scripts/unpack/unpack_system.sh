#!/bin/bash

clear

source scripts/dumpvars.sh

echo "system.dat.br/dat/img解包"

read -p "请将需要解包的system.dat.br/dat/img放入工具根目录，并按下回车" var

if [ -e "$LOCALDIR/system.new.dat.br" ]; then
	echo "检测到system.new.dat.br"
	"$bin/bin/brotli" -d "$LOCALDIR/system.new.dat.br"
	python "$bin/sdat2img.py" system.transfer.list system.new.dat system.img
	bash $unpack/unpackimg.sh system
	read -p "解包完成" var
elif [ -e "$LOCALDIR/system.new.dat" ]; then
	echo "检测到system.new.dat"
    python "$bin/sdat2img.py" system.transfer.list system.new.dat system.img
    bash $unpack/unpackimg.sh system
  	read -p "解包完成" var
elif [ -e "$LOCALDIR/system.img" ]; then
	echo "检测到system.img"
    bash $unpack/unpackimg.sh system
 	read -p "解包完成" var
else
	read -p "没有检测到任何需要解包的文件" var
fi

bash main.sh