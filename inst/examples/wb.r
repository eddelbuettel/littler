#!/usr/bin/env -S r -t
#
# upload to winbuilder
#
#
# Copyright (C) 2025  Dirk Eddelbuettel

if (!requireNamespace("curl", quietly=TRUE))
    stop("Please install 'curl' from CRAN.", call. = FALSE)

## load docopt from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
})

## configuration for docopt
doc <- "Usage: wb.r [-h] [-x] [-d] [-v] [ARG]

-v --verbose        use the 'verbose' flag in curl upload [default: FALSE]
-d --devel          upload to 'devel' instead of 'release' [default: FALSE]
-h --help           show this help text
-x --usage          show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where ARG is a (source) package.

Examples:
  wb.r abc_1.2-3.tar.gz               # upload package to win-builder for (default) release build
  wb.r -d abc_1.2-3.tar.gz            # upload package to win-builder for devel build

wb.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (is.null(opt$ARG)) {
    q("no")
}

if (!file.exists(opt$ARG)) {
    stop("No file '", opt$ARG, "' found. Existing.", call. = FALSE)
}

url <- file.path("ftp://win-builder.r-project.org", if (opt$devel) "R-devel/" else "R-release/")

curl::curl_upload(opt$ARG, url, verbose = opt$verbose)
