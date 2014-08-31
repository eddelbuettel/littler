#!/usr/bin/r -i

fsizes <- as.integer(readLines(file("stdin")))
print(summary(fsizes))
stem(fsizes)
