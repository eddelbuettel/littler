#!/usr/bin/env r

library(docopt)

## configuration for docopt
doc <- "Usage: kitten.r [-p] [-h] [-x] PACKAGE

-p --puppy	      invoke tinytest::puppy to set up testing
-h --help             show this help text
-x --usage            show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  kitten.r

kitten.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

## maybe support path, author, maintainer, email, license, ...
pkgKitten::kitten(opt$PACKAGE)
if (opt$puppy) {
    stopifnot(requireNamespace("tinytest", quietly=TRUE))
    tinytest::puppy(opt$PACKAGE)
}
