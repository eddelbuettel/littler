#!/usr/bin/env r
#
# Simple helper script for tinyrox::document()
#
# Dirk Eddelbuettel, 2026 - current
#
# GPL-2 or later

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: trox.r [-n none] [-c] [-v] [-h] [-x] [PACKAGES ...]

-n --namespace none	  namespace argument, one of 'overwrite', 'append', 'none' [default: none]
-c --crancheck        should the CRAN compliance check run [default: FALSE]
-v --verbose          should the operation be verbose rather than silent [default: FALSE]
-h --help             show this help text
-x --usage            show help and short example usage"
opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where PACKAGES... can be one or more packages.

Examples:
  trox.r                   # update help pages for package

trox.r is part of littler which brings 'r' to the command-line. See the help for
tinyrox for detials. See https://dirk.eddelbuettel.com/code/littler.html for more
information.\n")
    q("no")
}

if (!opt$namespace %in% c("overwrite", "append", "none"))
    stop(r"[The 'namespace' argument must be one of "overwrite", "append", "none".]", call. = FALSE)

## load tinyrox
library(tinyrox)

## check all command-line arguments (if any are given) for directory status
argv <- Filter(function(x) file.info(x)$is.dir, argv)

## loop over all argument, with fallback of the current directory, and
## call document() on the given directory
sapply(ifelse(length(argv) > 0, argv, "."),
       FUN = document,
       namespace = opt$namespace,
       cran_check = opt$crancheck,
       silent = !opt$verbose)
