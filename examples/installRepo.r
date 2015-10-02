#!/usr/bin/env r
#
# A simple example to install one or more packages from GitHub
#
# Copyright (C) 2014 - 2015  Carl Boettiger, Dirk Eddelbuettel and Alexios Galanos
#
# Released under GPL (>= 2)

## load docopt and devtools from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN
suppressMessages(library(devtools)) 

## configuration for docopt
doc <- "Usage: installRepo.r [-l LIBLOC] [-h] [-d DEPS] [-r REPOS] [-s subdir] SRC

-l --libloc LIBLOC  location in which to install [default: /usr/local/lib/R/site-library]
-d --deps DEPS      Install suggested dependencies as well? [default: NA]
-r --repos REPOS    The repository, eg github, bitbucket, svn, or url [default: github]
-s --subdir SUBDIR  For svn or url, an optional sub-directory within the repo
-h --help           show this help text

where SRC is either a git-style repo (author/repo) or a URL for svn.

Examples:
  installRepo.r RcppCore/RcppEigen                       # standard GitHub
  installRepo..r -r bitbucket alexiosg/rugarch           # using  BitBucket instead
  installRepo.r -r svn https://github.com/hadley/stringr # from Subversion or a URL
  installRepo.r -r url https://cran.rstudio.com/src/contrib/Archive/digest/digest_0.5.0.tar.gz

installRepo.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.
"

## docopt parsing
opt <- docopt(doc)
if (opt$deps == "TRUE" || opt$deps == "FALSE") {
    opt$deps <- as.logical(opt$deps)
} else if (opt$deps == "NA") {
    opt$deps <- NA
}

## installation given selected options and arguments
switch(tolower(opt$repos),
       github = install_github(opt$SRC, lib=opt$libloc, dependencies=opt$deps),
       bitbucket = install_bitbucket(opt$SRC, lib=opt$libloc, dependencies=opt$deps),
       svn = install_svn(opt$SRC, subdir=opt$subdir, lib=opt$libloc, dependencies=opt$deps),
       url = install_url(opt$SRC, subdir=opt$subdir, lib=opt$libloc, dependencies=opt$deps))
