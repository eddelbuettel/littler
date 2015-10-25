#!/usr/bin/env r 
#
# Convert miles-per-hour, time-distance measure settable
# on treadmiles, to different race times.
#
# Copyright (C) 2006 - 2014  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (is.null(argv) | length(argv)<1) {

  cat("Usage: mph.r mph\n")
  q()

}
dig <- 5
mph <- as.numeric(argv[1])

cat("Mph     : ",format(mph,digits=dig),"\n");

hourminsec <- function(totalsecs){
	ret <- list(hour=0,min=0,sec=0)

	ret$hour <- floor(totalsecs / 3600)

	totalsecs <- totalsecs - (ret$hour * 3600)

	ret$min <- floor(totalsecs / 60)

	ret$sec <- totalsecs - (ret$min * 60)

	ret
}

minutes <- floor(60/mph)
pminute <- 60/mph - minutes
secs <- floor(60 * (pminute))
secspermile <-  60*minutes + secs

outrace <- function(title,miles){
	race <- hourminsec(miles*secspermile)
	cat(sprintf("%-8s: %2.f hours %2.f min %2.f sec\n",title, race$hour,race$min, race$sec))
}

kilodiv <- 1.609344 # kilometer divisor
outrace('1 mile',1)
outrace('3 miles',3)
outrace('5k',5/kilodiv)
outrace('10k',10/kilodiv)
outrace('Marathon',42.195/kilodiv)
outrace('Ultra',100)

