#!/usr/bin/env r

fsizes <- as.integer(readLines())
print(summary(fsizes))
cat("Fivenum\n")
print(fivenum(fsizes))
