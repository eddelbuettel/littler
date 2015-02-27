#!/usr/bin/env r
#
# Another example to install one or more (source) packages into a drat
#
# Copyright (C) 2015  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN
suppressMessages(library(drat))     

## configuration for docopt
doc <- "Usage: drat.r [-h] [--repo REPO] [--commit] TARGZ...

-r --repo REPO      repository path to use [default: ~/git/drat]
-c --commit         in github use, also commit [default: FALSE]
-h --help           show this help text"

## docopt parsing
opt <- docopt(doc)

## helper function 
installArg <- function(p, repo, commit) {
    if (!file.exists(p)) stop("No file '", p, "' found. Aborting.", .Call=FALSE)
    insertPackage(p, repo, commit)
}

## insert packages using helper function 
sapply(opt$TARGZ, installArg, opt$repo, opt$commit)
