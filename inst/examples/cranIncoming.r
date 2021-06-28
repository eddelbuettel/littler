#!/usr/bin/env r
#
# A simple example to check the incoming queue at CRAN
#
# Copyright (C) 2020 - present  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
})

if (!requireNamespace("foghorn", quietly=TRUE))
    stop("The 'foghorn' is required. Please install it.", call.=FALSE)

## configuration for docopt
doc <- paste0("Usage: cranIncoming.r [-a] [-h] [-x] [ARGS...]
-a --all         show everything in incoming
-h --help        show this help text
-x --usage       show help and short example usage
")

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("

Basic usage:

  cranIncoming.r digest binb

cranIncoming.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (length(opt$ARGS) == 0) opt$ARGS <- if (opt$all) NULL else character()
print(data.frame(foghorn::cran_incoming(opt$ARGS)), row.names=FALSE)
