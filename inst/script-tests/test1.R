#!/usr/bin/env r
cat("hello world!\n"); 
for (i in 1:10){
	cat("i is",i,"\n");
}

foo <- function(x=1){
	if (x == 1){
		cat("x is 1\n");
	} else {
		cat("x is",x,":NOT 1\n");
	}
}
foo(2)
foo()

