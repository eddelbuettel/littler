#!/usr/bin/env r
#
# A simple wrapper for tools::compactPDF
#
# Copyright (C) 2019  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: compactpdf.r [-h] [-x] [PATH...]

-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  compactpdf.r                        # compact in current directory

compactpdf.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (length(opt$PATH) == 0) {
    opt$PATH <- list.files(".", pattern=".pdf$")
}

compactFunction <- function(f) {
    tools::compactPDF(f, gs_quality="ebook")
}

sapply(opt$PATH, compactFunction)
