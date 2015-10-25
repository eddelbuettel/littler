#!/usr/bin/r
#
# Simple helper script for roxygen2::roxygenize() 
#
# Dirk Eddelbuettel, August 2013
#
# GPL-2 or later

## load roxygen
library(roxygen2)

## check all command-line arguments (if any are given) for directory status
argv <- Filter(function(x) file.info(x)$is.dir, argv)

## loop over all argument, with fallback of the current directory, and
## call compileAttributes() on the given directory
sapply(ifelse(length(argv) > 0, argv, "."), FUN=roxygenize, roclets="rd")
