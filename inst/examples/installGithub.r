#!/usr/bin/env r
#
# A simple example to install one or more packages from GitHub
#
# Copyright (C) 2014 - 2023  Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt and remotes (or devtools) from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
    library(remotes)              # or can use devtools as a fallback
})

## configuration for docopt
doc <- "Usage: installGithub.r [-h] [-x] [-d DEPS] [-u UPDATE] [-r REPOS...] [-t TYPE] [GHREPOS...]

-d --deps DEPS       install suggested dependencies as well? [default: NA]
-u --update UPDATE   update dependencies? [default: TRUE]
-r --repos REPOS     repositor(y|ies) to use if deps required [default: getOption]
-t --type TYPE       installation type as used by `install.packages` [default: source]
-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where GHREPOS... is one or more GitHub repositories.

Basic usage:

  installGithub.r RcppCore/RcppEigen

Install multiple R packages from GitHub:

  installGithub.r RcppCore/Rcpp RcppCore/RcppEigen

Install multiple R packages from GitHub listing the packages on separate lines with some comments:

  installGithub.r \\
    RcppCore/Rcpp \\
    RcppCore/RcppEigen

Installing a specific branch, tag or commit:

  installGithub.r RcppCore/Rcpp@1.0.0

Setting multiple R package repositories to install dependencies of the R package:

  installGithub.r -r https://cloud.r-project.org -r https://eddelbuettel.github.io/drat RcppCore/RcppEigen

installGithub.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

## ensure installation is stripped
Sys.setenv("_R_SHLIB_STRIP_"="true")

if (opt$deps == "TRUE" || opt$deps == "FALSE") {
    opt$deps <- as.logical(opt$deps)
} else if (opt$deps == "NA") {
    opt$deps <- NA
}

if (length(opt$repos) == 1 && opt$repos == "getOption") {
    ## as littler can now read ~/.littler.r and/or /etc/littler.r we can preset elsewhere
    opt$repos <- getOption("repos")
}

opt$update <- as.logical(opt$update)

invisible(sapply(opt$GHREPOS, function(r) install_github(r, dependencies = opt$deps, upgrade = opt$update, repos = opt$repos, type = opt$type)))
