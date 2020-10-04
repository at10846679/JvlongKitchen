#!/bin/bash

LOCALDIRR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
LOCALDIR="$LOCALDIRR/.."
HOST="$(uname)"
tmpdir="$LOCALDIRR/../tmp"
bin="$LOCALDIRR/../tools"
script="$LOCALDIRR"
unpack="$script/unpack"
pack="$script/pack"
day=$(date "+%Y%m%d")