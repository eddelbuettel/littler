#!/usr/bin/env r
#
# Another example to check one or more packages, with option parsing
#
# Copyright (C) 2015 - 2020  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: check.r [-h] [-x] [--as-cran] [--repo REPO] [--install-deps] [--install-kitchen] [--deb-pkgs PKGS...] [--use-sudo] [--library LIB] [--setwd DIR] [TARGZ ...]

-a --as-cran          customization similar to CRAN's incoming [default: FALSE]
-r --repo REPO        repository to use, or NULL for file [default: https://cran.rstudio.com]
-i --install-deps     also install packages along with their dependencies [default: FALSE]
-k --install-kitchen  even install packages 'kitchen sink'-style up to suggests [default: FALSE]
-l --library LIB      when installing use this library [default: /usr/local/lib/R/site-library]
-s --setwd DIR        change to this directory before undertaking the test [default: ]
-d --deb-pkgs PKGS    also install binary .deb packages with their dependencies [default: FALSE]
-u --use-sudo         use sudo when installing .deb packages [default: TRUE]
-h --help             show this help text
-x --usage            show help and short example usage"

## docopt parsing
opt <- docopt(doc)

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  check.r -a -i -s /tmp myPkg_1.2-3.tar.gz    # run a check --as-cran with depends in /tmp
                                              # for package myPkg_1.2-3.tar.gz

check.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

args <- character()
if (opt$as_cran) args <- c(args, "--as-cran")

if (!is.null(opt$libdir)) .libPaths(opt$libdir)

r <- getOption("repos")
r["CRAN"] <- opt$repo
options(repos = r)

hasRcmdcheck <- requireNamespace("rcmdcheck", quietly=TRUE)
if (hasRcmdcheck) suppressMessages(library("rcmdcheck"))

## helper functions
checkArg <- function(p, args) {
    if (hasRcmdcheck) {
        #if (length(args) == 0) args <- ""
        res <- rcmdcheck(p, args=args)
    } else {
        tools:::.check_packages(c(p, args))
        res <- NULL
    }
    res
}

## helper function which switches to local (ie NULL) repo if matching file is presented
installArg <- function(p, lib, rep) {
    p <- gsub("_.*tar\\.gz$", "", p)
    install.packages(pkgs=p,
                     lib=lib,
                     repos=rep,
                     dependencies=if(opt$install_kitchen)
                                      c("Depends", "Imports", "LinkingTo", "Suggests")
                                  else
                                      TRUE
                     )
}

## if binary .deb files are to be installed first:
if (length(opt$deb_pkgs) > 1 || opt$deb_pkgs != FALSE) {
    cmd <- paste0(if (opt$use_sudo) "sudo " else "",
                 "apt-get install -y ", paste(opt$deb_pkgs, collapse=" "))
    system(cmd)
}

## if dependencies (or even suggests) are to be installed first:
if (opt$install_deps || opt$install_kitchen) sapply(opt$TARGZ, installArg, opt$lib, opt$repo)

## change directory if a target directory was given
if (!is.null(opt$setwd)) setwd(opt$setwd)

## installation given selected options and arguments
sapply(opt$TARGZ, checkArg, args)
