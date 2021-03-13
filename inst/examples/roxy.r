#!/usr/bin/env r
#
# Simple helper script for roxygen2::roxygenize()
#
# Dirk Eddelbuettel, 2013 - 2020
#
# GPL-2 or later

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: roxy.r [-n] [-f] [-h] [-x] [-r ROCLETS] [PACKAGES ...]

-n --nocache          run the current version not the cached version
-r --roclets ROCLETS  use roclets arguments for roxygenize [default: rd]
-f --full             implies both '-n' and '-r NULL'
-h --help             show this help text
-x --usage            show help and short example usage"
opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where PACKAGES... can be one or more packages.

Examples:
  roxy.r                     # update help pages for package, use cached version
  roxy.r -n                  # use non-cached version
  roxy.r -r NULL             # use full roclets i.e. collate,namespace,rd
  roxy.r -r 'namespace,rd'   # use full roclets i.e. namespace,rd
  roxy.r -f                  # use non-cached version and 'NULL' roclets

roxy.r is part of littler which brings 'r' to the command-line. See the help for
roxygenize for the different 'roclets' arguments; default value 'rd' means to only
update Rd files.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (opt$full) {
    opt$nocache <- TRUE
    opt$roclets <- "NULL"
}

## Works around the marvel that is version 6.1.0 or later
if (!opt$nocache && dir.exists("~/.R/cache/roxygen2")) {
    cat("** Using cached version 6.0.1 of roxygen2.\n")
    .libPaths("~/.R/cache")
}

## load roxygen
library(roxygen2)

## check all command-line arguments (if any are given) for directory status
argv <- Filter(function(x) file.info(x)$is.dir, argv)

## loop over all argument, with fallback of the current directory, and
## call roxygenize() on the given directory with roclets="rd" set
sapply(ifelse(length(argv) > 0, argv, "."),
       FUN = roxygenize,
       roclets = if (tolower(opt$roclets) == "null") NULL else strsplit(opt$roclets,",")[[1]])
