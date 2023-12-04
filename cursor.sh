#!/bin/bash

clear;
x=1;
y=1;
xd=1;
yd=1;
while true;
do 
    if [[ $x == $LINES || $x == 0 ]]; then 
        xd=$(( $xd *-1 )) ; 
    fi ; 
    if [[ $y == $COLUMNS || $y == 0 ]]; then 
        yd=$(( $yd * -1 )) ; 
    fi ; 
    x=$(( $x + $xd )); 
    y=$(( $y + $yd )); 
    printf "\33[%s;%sH" $x $y; 
    sleep 0.02 ;
done