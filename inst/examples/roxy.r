#!/usr/bin/env r
#
# Simple helper script for roxygen2::roxygenize()
#
# Dirk Eddelbuettel, August 2013
#
# GPL-2 or later

## Works around the marvel that is version 6.1.0
if (dir.exists("~/.R/cache/roxygen2")) {
    cat("** Using cached version 6.0.1 of roxygen2.\n")
    .libPaths("~/.R/cache")
}

## load roxygen
library(roxygen2)

## check all command-line arguments (if any are given) for directory status
argv <- Filter(function(x) file.info(x)$is.dir, argv)

## loop over all argument, with fallback of the current directory, and
## call roxygenize() on the given directory with roclets="rd" set
sapply(ifelse(length(argv) > 0, argv, "."), FUN=roxygenize, roclets="rd")
