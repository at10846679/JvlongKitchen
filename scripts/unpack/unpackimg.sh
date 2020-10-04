#!/bin/bash

source scripts/dumpvars.sh

cd $LOCALDIR

species="$1"
mkdir ./"$species"

echo "正在解包$species.img......."
sudo python3 $bin/imgextractor/imgextractor.py ./$species'.img' ./$species
rm -rf /"$species"
