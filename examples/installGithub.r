#!/usr/bin/env r
#
# A simple example to install one or more packages from GitHub
#
# Copyright (C) 2014         Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt and devtools from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN
suppressMessages(library(devtools)) 

## configuration for docopt
doc <- "Usage: installGithub.r [-r REPO] [-l LIBLOC] [-h] [-d DEPS] [PACKAGES ...]

-r --repos REPO     repository to install from [default: http://cran.rstudio.com]
-l --libloc LIBLOC  location in which to install [default: /usr/local/lib/R/site-library]
-d --deps DEPS      Install suggested dependencies as well? [default: NA]
-h --help           show this help text"

## docopt parsing
opt <- docopt(doc)
if (opt$deps == "TRUE" || opt$deps == "FALSE") {
    opt$deps <- as.logical(opt$deps)
} else if (opt$deps == "NA") {
    opt$deps <- NA
}

## installation given selected options and arguments
options(repos = opt$repos)
install_github(repo  = opt$PACKAGES,
               paste("-l =", opt$libloc),
               dependencies = opt$deps)
