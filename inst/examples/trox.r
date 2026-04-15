#!/usr/bin/env r
#
# Simple helper script for tinyrox::document()
#
# Dirk Eddelbuettel, 2026 - current
#
# GPL-2 or later

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: trox.r [-h] [-x] [PACKAGES ...]

-h --help             show this help text
-x --usage            show help and short example usage"
opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where PACKAGES... can be one or more packages.

Examples:
  trox.r                   # update help pages for package

trox.r is part of littler which brings 'r' to the command-line. See the help for
tinyrox for detials. See https://dirk.eddelbuettel.com/code/littler.html for more
information.\n")
    q("no")
}

## load tinyrox
library(tinyrox)

## check all command-line arguments (if any are given) for directory status
argv <- Filter(function(x) file.info(x)$is.dir, argv)

## loop over all argument, with fallback of the current directory, and
## call document() on the given directory
sapply(ifelse(length(argv) > 0, argv, "."), FUN = document)
