#!/usr/bin/env r

fsizes <- as.integer(readLines())
print(summary(fsizes))
stem(fsizes)
