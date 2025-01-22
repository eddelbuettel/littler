#!/usr/bin/env -S r -t
#
# testthat::test_local wrapper
#
# Copyright (C) 2019 - 2024  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (!requireNamespace("testthat", quietly=TRUE))
    stop("Please install 'testthat' from CRAN.", call. = FALSE)

## load docopt from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
})

## configuration for docopt
doc <- "Usage: tttl.r [-h] [-x] [-c] [-s] [ARG]

-c --ci             set environment variable CI to TRUE [default: FALSE]
-s --source         set load package to 'source' not 'installed' [default: FALSE]
-h --help           show this help text
-x --usage          show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where ARG can be a package directory.

Examples:
  tttl.r                              # run test_local() if DESCRIPTION && tests/testthat/
  tttl.r                              # run test_local() if in tests/testthat directory

tttl.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (!is.null(opt$ARG) && dir.exists(opt$arg)) {
    setwd(opt$ARG)
}

if (opt$ci) {
    Sys.setenv(CI="TRUE")
}

if (file.exists(file.path(getwd(), "..", "..", "DESCRIPTION"))) {
    setwd(file.path(getwd(), "..", ".."))
}

if (file.exists(file.path(getwd(), "..", "DESCRIPTION"))) {
    setwd("..")
}

if (file.exists("DESCRIPTION") && dir.exists("tests/testthat")) {
    testthat::test_local("tests/testthat",
                         load_package = if (opt$source) "source" else "installed")
}
