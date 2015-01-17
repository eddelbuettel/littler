#!/usr/bin/env r
#
# Another example to check one or more packages, with option parsing
#
# Copyright (C) 2015  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN

## configuration for docopt
doc <- "Usage: check.r [-h] [--as-cran] [--repo REPO] [--install-deps] [--library LIB] [TARGZ ...]

-a --as-cran        customization similar to CRAN's incoming [default: FALSE]
-r --repo REPO      repository to use, or NULL for file [default: http://cran.rstudio.com]
-i --install-deps   also install packages along with their dependencies [default: FALSE]
-l --library LIB    when installing use this library [default: /usr/local/lib/R/site-library]
-h --help           show this help text"

## docopt parsing
opt <- docopt(doc)

args <- character()
if (opt$`as-cran`) args <- c(args, "--as-cran")

## doctopt results are characters, so if we meant NULL we have to set NULL
if (opt$repo == "NULL") opt$repo = NULL

r <- getOption("repos")
r["CRAN"] <- opt$repo
options(repos = r)

## helper functions
checkArg <- function(p, args) {
    tools:::.check_packages(c(p, args))
}

## helper function which switches to local (ie NULL) repo if matching file is presented
installArg <- function(p, lib, rep) {
    p <- gsub("_.*tar\\.gz$", "", p)
    install.packages(pkgs=p,
                     lib=lib,
                     repos=rep,
                     dependencies=TRUE)
}

## if dependencies are to be installed first:
if (opt$`install-deps`) sapply(opt$TARGZ, installArg, opt$lib, opt$repo)

## installation given selected options and arguments
sapply(opt$TARGZ, checkArg, args)
