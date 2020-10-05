#!/bin/bash

clear

echo "Jvlong's Kitchen 20201005"
echo "请将要解包的system/vendor/boot/update.zip等文件放置于本工具根目录"
echo ""
echo "一.解包"
echo "1.自动解包（将卡刷包重命名为update.zip放置到此工具根目录，会自动解包出boot/system/vendor）"
echo "2.解包system（包括img/dat/dat.br）"
echo "3.解包vendor（包括img/dat/dat.br）"
echo "4.解包boot.img"
echo "5.解包super.img动态分区镜像"
echo ""
echo "二.打包"
echo "6.自动打包（system/vendor/boot自动打包为卡刷包）"
echo "7.打包system（支持img/dat/dat.br）"
echo "8.打包vendor（支持img/dat/dat.br）"
echo "9.打包boot.img"
echo "10.打包super.img动态分区镜像"
echo ""
echo "三.其它"
echo "11.将system/vendor.img嵌入super.img"
echo "12.生成卡刷包updaterscript"
echo "13.估计system/vendor大小"
echo "14.OPPO OZIP解密"
echo ""
echo "0.退出程序"

read -p "请输入您的选择：" c

if [ "$c" == "0" ]; then 
    exit
elif [ "$c" == "1" ]; then 
	bash ./scripts/unpack/autounpack.sh	     
elif [ "$c" == "2" ]; then 
	bash ./scripts/unpack/unpack_system.sh
elif [ "$c" == "3" ]; then 
	bash ./scripts/unpack/unpack_vendor.sh
elif [ "$c" == "4" ]; then 
	bash ./scripts/unpack/unpack_boot.sh
elif [ "$c" == "5" ]; then 
	bash ./scripts/unpack/unpack_super.sh	
# elif [ "$c" == "6" ]; then 

# elif [ "$c" == "7" ]; then 

# elif [ "$c" == "8" ]; then 


# elif [ "$c" == "9" ]; then 

 
# elif [ "$c" == "10" ]; then 


# elif [ "$c" == "11" ]; then 

 
# elif [ "$c" == "12" ]; then 

 
# elif [ "$c" == "13" ]; then 


# elif [ "$c" == "14" ]; then 

else
	echo "指令不存在"
fi 
