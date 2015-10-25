#!/bin/bash

N=10
function loopBC {
    echo 
    echo -n " --- GNU bc doing the addition $N times"
    i=0
    while [ $i -lt $N ]
    do
	echo "1+2" | bc -l > /dev/null
	i=$((i + 1))
    done
}

function loopLittleR {
    echo
    echo -n " --- our r doing the addition $N times"
    i=0
    while [ $i -lt $N ]
    do
	echo "cat(1+2,'\n')" | ../r --vanilla > /dev/null
	i=$((i + 1))
    done
}

function loopRscript {
    echo
    echo -n " --- GNU R's Rscript doing the addition $N times"
    i=0
    while [ $i -lt $N ]
    do
	echo "cat(1+2,'\n')" | Rscript - > /dev/null
	i=$((i + 1))
    done
}

function loopR {
    echo
    echo -n " --- GNU R doing the addition $N times"
    i=0
    while [ $i -lt $N ]
    do
	echo "cat(1+2,'\n')" | R --slave --vanilla > /dev/null
	i=$((i + 1))
    done
}

time loopBC
time loopLittleR
time loopRscript
time loopR
