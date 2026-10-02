#!/usr/bin/env -S r -t
##
##  Call 'checktor' on a package
##
##  Copyright (C) 2026  Dirk Eddelbuettel
##
##  Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: checktor.r [-h] [-x] [-i] [-p] [-s] [-u] [PATH...]

-i --issues			  show issue of results
-p --prescribe		  show prescribe of results
-s --summary		  show summary of results
-u --url              run 'url_liveness' check
-h --help             show this help text
-x --usage            show help and short example usage"

opt <- docopt(doc)          # docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  checktor.r                    # check in current (working) director
  checktor.r foo_1.2-3.tar.gz   # check package

checktor.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (length(opt$PATH) == 0) opt$PATH <- "."      # default argument current directory

if (requireNamespace("checktor", quietly=TRUE) == FALSE)
    stop("This command requires the 'checktor' package.", call. = FALSE)

suppressMessages(library(checktor))

if (opt$url) options(checktor.url_check = TRUE)

res <- checktor(opt$PATH, FALSE, FALSE)
print(res)
if (opt$issues) print(issues(res))
if (opt$summary) print(summary(res))
if (opt$prescribe) print(prescribe(res))
