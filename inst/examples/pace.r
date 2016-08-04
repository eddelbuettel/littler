#!/usr/bin/env r 
#
# a simple example to convert miles and times into a pace
# where the convention is that we write e.g. 37 min 15 secs
# as 37.15 -- so a call 'pace.r 4.5 37.15' yields a pace of
# 8.1667, ie 8 mins 16.67 secs per mile
#
# Copyright (C) 2006 - 2014  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (is.null(argv) | length(argv)!=2) {

  cat("Usage: pace.r miles time\n")
  q()

}

dig <- 5
  
rundist <- as.numeric(argv[1])
runtime <- as.numeric(argv[2])

cat("Miles   : ", format(rundist, digits=dig), "\n")
cat("Time    : ", format(runtime, digits=dig), "\n")

totalseconds <- floor(runtime)*60 + (runtime-floor(runtime))*100
totalsecondspermile <- totalseconds / rundist
minutespermile <- floor(totalsecondspermile/60)
secondspermile <- totalsecondspermile - minutespermile*60

pace <- minutespermile + secondspermile/100

cat("Pace    : ",
    format(minutespermile, digits=1), "min",
    format(secondspermile, digits=dig), "sec\n")

cat("Mph     : ",
	format( (rundist * 3600)/totalseconds, digits=dig),"\n")
