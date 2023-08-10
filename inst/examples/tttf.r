#!/usr/bin/env r
#
# testthat::test_file wrapper
#
# Copyright (C) 2019 - 2023  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (!requireNamespace("testthat", quietly=TRUE))
    stop("Please install 'testthat' from CRAN.", call. = FALSE)

## load docopt and tinytest from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
})

## configuration for docopt
doc <- "Usage: tttf.r [-l LIB] [-h] [-x] ARG

-l --library LIIB   load named library
-h --help           show this help text
-x --usage          show help and short example usage"
opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where ARG can be a package directory.

Examples:
  tttf.r test-testfile.r              # run test_file() on the given file

tttf.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (!file.exists(opt$ARG)) {
    stop("No such file.", call. = FALSE)
}

if (!is.null(opt$LIB)) {
    library(opt$LIB)
}

testthat::test_file(path=opt$ARG)
