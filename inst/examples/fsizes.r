#!/usr/bin/r -i
#
# A simple example to do statistics on files
#
# Copyright (C) 2006 - 2014  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

fsizes <- as.integer(readLines(file("stdin")))
print(summary(fsizes))
stem(fsizes)
