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
doc <- "Usage: drat.r [-h] [--repo REPO] [--commit MSG] TARGZ...

-r --repo REPO      repository path to use [default: ~/git/drat]
-c --commit MSG     in github use, commit with MSG (default: no commit)
-h --help           show this help text

Examples:
  dratInsert.r myPkg_1.2-3.tar.gz              # installs into default (git) repo
  dratInsert.r -r /srv/R/  myPkg_1.2-3.tar.gz  # installs into local directory repo

dratInstert.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.
"

## docopt parsing
opt <- docopt(doc)

if (is.null(opt$commit)) opt$commit <- FALSE

## helper function 
installArg <- function(p, repo, commit) {
    if (!file.exists(p)) stop("No file '", p, "' found. Aborting.", .Call=FALSE)
    insertPackage(p, repo, commit)
}

## insert packages using helper function 
sapply(opt$TARGZ, installArg, opt$repo, opt$commit)
