#!/bin/bash
set -e
[ -d /Volumes ] && mountpath="/Volumes/NICENANO" || mountpath="/media/$USER/NICENANO"
cd ~/opt/zmk/app
../venv/bin/west build -p -d build/left -b nice_nano_v2 -- -DZMK_CONFIG=../../zmk-chocofi/config -DSHIELD=corne_left
cp build/left/zephyr/zmk.uf2 build/zmk_left.uf2
echo "copy to left board? y/n/q"
read response
case "$response" in
    y)
        [[ -d $mountpath ]] || { echo "$mountpath does not exist"; exit 1; }
        cp build/left/zephyr/zmk.uf2 "$mountpath"
        ;;
    q)
        exit
        ;;
esac
../venv/bin/west build -p -d build/right -b nice_nano_v2 -- -DZMK_CONFIG=../../zmk-chocofi/config -DSHIELD=corne_right
cp build/right/zephyr/zmk.uf2 build/zmk_right.uf2
echo "copy to right board? y/n/q"
read response
case "$response" in
    y)
        [[ -d $mountpath ]] || { echo "$mountpath does not exist"; exit 1; }
        cp build/right/zephyr/zmk.uf2 "$mountpath"
        ;;
    q)
        exit
        ;;
esac
