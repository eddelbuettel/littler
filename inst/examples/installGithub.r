#!/usr/bin/env r
#
# A simple example to install one or more packages from GitHub
#
# Copyright (C) 2014 - 2016  Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt and devtools from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN
suppressMessages(library(devtools)) 

## configuration for docopt
doc <- "Usage: installGithub.r [-h] [-x] [-d DEPS] [REPOS...]

-d --deps DEPS      Install suggested dependencies as well? [default: NA]
-h --help           show this help text
-x --usage          show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where REPOS... is one or more GitHub repositories.

Examples:
  installGithub.r RcppCore/RcppEigen                     

installGithub.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

## docopt parsing
opt <- docopt(doc)
if (opt$deps == "TRUE" || opt$deps == "FALSE") {
    opt$deps <- as.logical(opt$deps)
} else if (opt$deps == "NA") {
    opt$deps <- NA
}

invisible(sapply(opt$REPOS, function(r) install_github(r, dependencies = opt$deps)))
