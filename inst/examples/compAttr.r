#!/usr/bin/env r
#
# Simple helper script for compileAttributes()
#
# Dirk Eddelbuettel, July 2014
#
# GPL-2 or later

## load Rcpp
suppressMessages(library(Rcpp))

## check all command-line arguments (if any are given) for directory status
argv <- Filter(function(x) file.info(x)$is.dir, argv)

## loop over all argument, with fallback of the current directory, and
## call compileAttributes() on the given directory
sapply(ifelse(length(argv) > 0, argv, "."), compileAttributes)
