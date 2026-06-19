#!/bin/bash

bar() {
local percent=$(echo "$1" | tr -d "%")
percent=${percent%.*}

local fill=$((percent/10))
local empty=$((10 - fill))


local bar_fill=$(printf '█%.0s' $(seq 1 $fill))
local bar_empty=$(printf '░%.0s' $(seq 1 $empty))

echo "[$bar_fill$bar_empty]"
}

while true; do
clear

s=$(df -h /data | awk 'NR==2 {print$5}')

ru=$(free -m | awk 'NR==2 {print$3}')
ra=$(free -m | awk 'NR==2 {print$2}')
ap=$(top -n 1 -b | awk 'NR>=6 && NR<=8 {printf " App Name : %-15s | Cpu : %s%%\n", $12, $9}')

ram=$(($ru * 100 / $ra ))


sb=$(bar "$s" )
rb=$(bar "$ram" )

echo "=============================================="
echo "             RESOURCES             "
echo "=============================================="

echo " STORAGE : $s " " $sb "
echo " RAM     : $ru MB / $ra MB " " $rb "
echo "        TOP 3 APPS USING CPU         "

echo "$ap"



echo "============================================="

sleep 2
done
