#!/usr/bin/env r
longline <- function(len){
	n <- floor(len/10)
	m = len %% 10
	if (m>0){
		x <- paste(rep(seq(0,9),n),collapse='')
		y <- paste(seq(0,m-1),collapse='')
		z <- paste(x,y,sep='')
	} else {
		z <- paste(rep(seq(0,9),n),collapse='')
	}
	z
}
cat("x<-\"", longline(1020), "\";",sep="");
cat("cat(x,\"\\n\"",")\n",sep="");
cat("cat(nchar(x),\"\\n\"",")\n",sep="");
