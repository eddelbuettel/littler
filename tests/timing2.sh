#!/bin/bash

N=20

function loopLittleR {
  echo
  echo -n " --- our r calling summary() $N times"
  i=0
  while [ $i -lt $N ]
  do
    ./summary2.R >/dev/null
    i=$((i + 1))
  done
}

function loopR {
  echo
  echo -n " --- the real GNU R calling summary() $N times"
  i=0
  while [ $i -lt $N ]
  do
	R --silent --vanilla < ./summary2.R >/dev/null
    i=$((i + 1))
  done
}

time loopLittleR
time loopR
