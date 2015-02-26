#!/usr/bin/env r
#
# An example to install packages at specific versions.
#
# Copyright (C) 2015    Aaron Browne, Carl Boettiger, and Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN
suppressMessages(library(devtools))

## configuration for docopt
doc <- "Usage: installVersion.r [-r REPO...] [-l LIBLOC] [-h] [-d DEPS] [--error] [PACKAGES[@VERSIONS] ...]

-r --repos REPO     repository to use, or NULL for file [default: getOption]
-l --libloc LIBLOC  location in which to install [default: /usr/local/lib/R/site-library]
-d --deps DEPS      install suggested dependencies as well [default: NA]
-e --error          throw error and halt instead of a warning [default: FALSE]
-h --help           show this help text"

## docopt parsing
opt <- docopt(doc)

if (opt$deps == "TRUE" || opt$deps == "FALSE") {
    opt$deps <- as.logical(opt$deps)
} else if (opt$deps == "NA") {
    opt$deps <- NA
}

## as littler can now read ~/.littler.r and/or /etc/littler.r we can preset elsewhere
if (opt$repos == "getOption") opt$repos = getOption("repos")

## doctopt results are characters, so if we meant NULL we have to set NULL
if (opt$repos == "NULL") opt$repos = NULL

## helper function to for existing files with matching extension
isMatchingFile <- function(f) file.exists(f) && grepl("(\\.tar\\.gz|\\.tgz|\\.zip)$", f)

## helper function which switches to local (ie NULL) repo if matching file is presented
installArg <- function(f, lib, rep, dep) {
    if (grepl("@",f)) {
        parts <- unlist(strsplit(f, "@"))
        devtools::install_version(parts[1],
                                  version=parts[2]
                                  lib=lib,
                                  repos=if (isMatchingFile(f)) NULL else rep,
                                  dependencies=dep)
    } else {
        install.packages(pkgs=f,
                         lib=lib,
                         repos=if (isMatchingFile(f)) NULL else rep,
                         dependencies=dep)
    }
}

## installation given selected options and arguments
if (opt$error) {
    withCallingHandlers(sapply(opt$PACKAGES, installArg, opt$libloc, opt$repos, opt$deps), warning = stop)
} else { 
    sapply(opt$PACKAGES, installArg, opt$libloc, opt$repos, opt$deps)
}

## clean up any temp file containing CRAN directory information
sapply(list.files(path=tempdir(), pattern="^(repos|libloc).*\\.rds$", full.names=TRUE), unlink)
