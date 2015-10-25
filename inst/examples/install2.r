#!/usr/bin/env r
#
# A second example to install one or more packages, now with option parsing
#
# Copyright (C) 2011 - 2014  Dirk Eddelbuettel
# Copyright (C) 2014         Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN

## configuration for docopt
doc <- "Usage: install2.r [-r REPO...] [-l LIBLOC] [-h] [-d DEPS] [--error] [PACKAGES ...]

-r --repos REPO     repository to use, or NULL for file [default: getOption]
-l --libloc LIBLOC  location in which to install [default: /usr/local/lib/R/site-library]
-d --deps DEPS      install suggested dependencies as well [default: NA]
-e --error          throw error and halt instead of a warning [default: FALSE]
-h --help           show this help text

where PACKAGES... can be one or more CRAN package names, or local (binary or source)
package files (where extensions .tar.gz, .tgz and .zip are recognised).

Examples:
  install2.r -l /tmp/lib Rcpp BH                         # installs into given library

install2.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.
"

## docopt parsing
opt <- docopt(doc)

if (opt$deps == "TRUE" || opt$deps == "FALSE") {
    opt$deps <- as.logical(opt$deps)
} else if (opt$deps == "NA") {
    opt$deps <- NA
}

## doctopt results are characters, so if we meant NULL we have to set NULL
if (opt$repos == "NULL")  {
   opt$repos = NULL
} else if (opt$repos == "getOption") {
   ## as littler can now read ~/.littler.r and/or /etc/littler.r we can preset elsewhere
   opt$repos = getOption("repos")
}

## helper function to for existing files with matching extension
isMatchingFile <- function(f) file.exists(f) && grepl("(\\.tar\\.gz|\\.tgz|\\.zip)$", f)

## helper function which switches to local (ie NULL) repo if matching file is presented
installArg <- function(f, lib, rep, dep) {
    install.packages(pkgs=f,
                     lib=lib,
                     repos=if (isMatchingFile(f)) NULL else rep,
                     dependencies=dep)
}

## installation given selected options and arguments
if (opt$error) {
    withCallingHandlers(sapply(opt$PACKAGES, installArg, opt$libloc, opt$repos, opt$deps), warning = stop)
} else { 
    sapply(opt$PACKAGES, installArg, opt$libloc, opt$repos, opt$deps)
}

## clean up any temp file containing CRAN directory information
sapply(list.files(path=tempdir(), pattern="^(repos|libloc).*\\.rds$", full.names=TRUE), unlink)
