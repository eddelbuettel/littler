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
doc <- "Usage: tttf.r [-l LIB] [-s FILE] [-h] [-x] ARG

-l --library LIB    load named library, LIB can be comma-separated
-s --source FILE    source a named file
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

if (!is.null(opt$library)) {
    for (s in strsplit(opt$library, ",")[[1]]) {
        library(s, character.only=TRUE, verbose=TRUE)
    }
}

if (!file.exists(opt$ARG)) {
    stop("No such file.", call. = FALSE)
}

if (!is.null(opt$source) && file.exists(opt$source)) {
    source(opt$source)
}

testthat::test_file(path=opt$ARG)
