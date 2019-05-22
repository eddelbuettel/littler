#!/usr/bin/env r
#
# A simple example to install one or more packages
#
# Note that a more featureful version exists in install2.r
# with an added dependency on the 'docopt' argument parser
#
# Copyright (C) 2006 - 2019  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (is.null(argv) | length(argv) < 1) {
    if (file.exists("DESCRIPTION") && file.exists("NAMESPACE")) {
        ## we are in a source directory, so build it
        message("* installing *source* package found in current working directory ...")
        argv <- "."
    } else {
        cat("Usage: installr.r pkg1 [pkg2 pkg3 ...]\n\n")
        cat("Installs pkg1, ... from existing files with matching extension.\n")
        cat("Use \".\" to install the package in current working directory.\n\n")
        cat("Use (remote) packages pkgname1 pkgname2 pkgname3 ... for parallel\n")
        cat("installation if 'Ncpus' option is set (or multiple cores present).\n\n")
        cat("Set environment variables REPOS and LIBLOC to overrride defaults.\n\n")
        q()
    }
}

## adjust as necessary, see help('download.packages')
## littler can now read ~/.littler.r and /etc/littler,r to set this
repos <- getOption("repos")
## NULL means install file, and we supported env var previously
if (Sys.getenv("REPOS") == "NULL") repos = NULL

## this makes sense on Debian where no packages touch /usr/local
lib.loc <- Sys.getenv("LIBLOC", unset="/usr/local/lib/R/site-library")

## helper function to for existing files with matching extension
isMatchingFile <-
    function(f) (file.exists(f) &&
                 grepl("(\\.tar\\.gz|\\.tgz|\\.zip)$", f)) || (f == ".")

## helper function which switches to local (ie NULL) repo if matching file is presented
installArg <-
    function(f, lib, rep) install.packages(pkgs=f,
                                           lib=lib,
                                           repos=if (isMatchingFile(f)) NULL else repos)


## check arguments for local files -- if none, then we can pass vector on
isLocal <- sapply(argv, isMatchingFile)

if (any(isLocal)) {
    ## use argv [filtered by installArg()], lib.loc and repos to install the packages
    sapply(argv, installArg, lib.loc, repos)
} else {
    ## all remote, so pass argv so Ncpus can enter
    install.packages(pkgs=argv,
                     lib=lib.loc,
                     repos=repos,
                     Ncpus=getOption("Ncpus", max(1L, parallel::detectCores())))
}

## clean up any temp file containing CRAN directory information
sapply(list.files(path=tempdir(), pattern="^(repos|libloc).*\\.rds$", full.names=TRUE), unlink)
