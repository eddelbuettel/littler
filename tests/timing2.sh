#!/bin/bash

N=100

function loopLittleR {
  echo
  echo -n " --- our r calling summary() $N times"
  i=0
  while [ $i -lt $N ]
  do
    ./tests/summary2.R >/dev/null
    i=$((i + 1))
  done
}

function loopR {
  echo
  echo -n " --- the real GNU R calling summary() $N times"
  i=0
  while [ $i -lt $N ]
  do
	R --silent --vanilla < ./tests/summary2.R >/dev/null
    i=$((i + 1))
  done
}

time loopLittleR
time loopR
