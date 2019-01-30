#!/usr/bin/env r
#
# A simple example to install one or more packages from GitHub
#
# Copyright (C) 2014 - 2017  Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt and remotes (or devtools) from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
    library(remotes)              # or can use devtools as a fallback
})

## configuration for docopt
doc <- "Usage: installGithub.r [-h] [-x] [-d DEPS] [-u UPDATE] [-r REPOS...] [GHREPOS...]

-d --deps DEPS       install suggested dependencies as well? [default: NA]
-u --update UPDATE   update dependencies? [default: TRUE]
-r --repos REPOS     repository/repositories to use to install required dependencies [default: getOption]
-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where GHREPOS... is one or more GitHub repositories.

Examples:
  installGithub.r RcppCore/RcppEigen

installGithub.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (opt$deps == "TRUE" || opt$deps == "FALSE") {
    opt$deps <- as.logical(opt$deps)
} else if (opt$deps == "NA") {
    opt$deps <- NA
}

if (opt$repos == "getOption") {
    ## as littler can now read ~/.littler.r and/or /etc/littler.r we can preset elsewhere
    opt$repos <- getOption("repos")
}

opt$update <- as.logical(opt$update)

invisible(sapply(opt$GHREPOS, function(r) install_github(r, dependencies = opt$deps, upgrade = opt$update, repos = opt$repos)))
