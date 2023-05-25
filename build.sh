#!/bin/bash
set -e
[ -d /Volumes ] && mountpath="/Volumes/NICENANO" || mountpath="/media/$USER/NICENANO"
cd ~/opt/zmk/app

../venv/bin/west build -p -d build/left -b nice_nano_v2 -- -DZMK_CONFIG="$(realpath ../../zmk-chocofi/config)" -DSHIELD="corne_left nice_view_adapter nice_view"
cp build/left/zephyr/zmk.uf2 build/zmk_left.uf2
echo "waiting for left board to mount... press enter to skip"
until [[ -d $mountpath ]]; do read -t 1 && break; done
[[ -d $mountpath ]] &&
    echo "copying to $mountpath" &&
    cp build/left/zephyr/zmk.uf2 "$mountpath" &&
    echo "copied to $mountpath" &&
    echo "waiting for $mountpath to unmount" &&
    until [[ ! -d $mountpath ]]; do sleep 1; done ||
    echo "left board not mounted"

../venv/bin/west build -p -d build/right -b nice_nano_v2 -- -DZMK_CONFIG="$(realpath ../../zmk-chocofi/config)" -DSHIELD="corne_right nice_view_adapter nice_view"
cp build/right/zephyr/zmk.uf2 build/zmk_right.uf2
echo "waiting for right board to mount... press enter to skip"
until [[ -d $mountpath ]]; do read -t 1 && break; done
[[ -d $mountpath ]] &&
    echo "copying to $mountpath" &&
    cp build/right/zephyr/zmk.uf2 "$mountpath" &&
    echo "copied to $mountpath" &&
    echo "waiting for $mountpath to unmount" &&
    until [[ ! -d $mountpath ]]; do sleep 1; done ||
    echo "right board not mounted"
