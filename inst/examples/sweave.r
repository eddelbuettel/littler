#!/usr/bin/env r
#
# Another example to convert from Rnw and also compact
#
# Copyright (C) 2019  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: sweave.r [-c] [-h] [-x] [FILES...]

-c --compact         compact pdf file [default: FALSE]
-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  sweave.r foo.Rnw bar.Rnw        # convert two given files

sweave.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

## helper function
sweaveFunction <- function(p) {
    if (!file.exists(p)) stop("No file '", p, "' found. Aborting.", call.=FALSE)
    utils::Sweave(p)
    s <- gsub(".Rnw$", ".tex", p)
    tools::texi2pdf(s, texi2dvi="pdflatex")
    tools::texi2pdf(s, texi2dvi="pdflatex")
    if (opt$compact) {
        r <- gsub(".Rnw$", ".pdf", p)
        if (file.exists(r)) tools::compactPDF(r, gs_quality="ebook")
    }
}

## render files using helper function
sapply(opt$FILES, sweaveFunction)
