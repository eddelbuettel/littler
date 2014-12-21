#!/usr/bin/env r
#
# A simple example to install one or more packages
#
# Note that a more featureful version exists in install2.r
# with an added dependency on the 'docopt' argument parser
#
# Copyright (C) 2006 - 2014  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (is.null(argv) | length(argv) < 1) {
    cat("Usage: installr.r pkg1 [pkg2 pkg3 ...]\n")
    cat("Set environment variables REPOS and LIBLOC to overrride defaults.\n")
    cat("Use install2.r for a version which supports command-line parsing.\n")
    q()
}

## adjust as necessary, see help('download.packages')
repos <- Sys.getenv("REPOS", unset="http://cran.rstudio.com")
if (repos == "NULL") repos = NULL

## this makes sense on Debian where no packages touch /usr/local
lib.loc <- Sys.getenv("LIBLOC", unset="/usr/local/lib/R/site-library")

## use argv, lib.loc and repos to install the packages
install.packages(argv, lib.loc, repos)

## clean up any temp file containing CRAN directory information
sapply(list.files(path=tempdir(), pattern="^(repos|libloc).*\\.rds$", full.names=TRUE), unlink)
