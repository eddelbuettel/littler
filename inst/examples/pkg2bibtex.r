#!/usr/bin/env r
#
# A simple wrapper for toBibtex
#
# Copyright (C) 2019  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: pkg2bibtex.r [-h] [-x] [PKG...]

-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  pkg2bibtex.r anytime nanotime       # create two bibtex records

pkg2bibtex.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (length(opt$PATH) == 0) {
    opt$PATH <- "."
}

res <- sapply(opt$PKG, function(p) toBibtex(citation(p, auto=TRUE)), simplify=FALSE)
print(res)
