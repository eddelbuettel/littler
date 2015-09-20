#!/usr/bin/env r
#
# Another example to check one or more packages, with option parsing
#
# Copyright (C) 2015  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN

## configuration for docopt
doc <- "Usage: check.r [-h] [--as-cran] [--repo REPO] [--install-deps] [--deb-pkgs PKGS...] [--use-sudo] [--library LIB] [--setwd DIR] [TARGZ ...]

-a --as-cran        customization similar to CRAN's incoming [default: FALSE]
-r --repo REPO      repository to use, or NULL for file [default: http://cran.rstudio.com]
-i --install-deps   also install packages along with their dependencies [default: FALSE]
-l --library LIB    when installing use this library [default: /usr/local/lib/R/site-library]
-s --setwd DIR      change to this directoru before undertaking the test [default: ]
-d --deb-pkgs PKGS  also install binary .deb packages with their dependencies [default: FALSE]
-u --use-sudo       use sudo when installing .deb packages [default: TRUE]
-h --help           show this help text"

## docopt parsing
opt <- docopt(doc)

args <- character()
if (opt$`as-cran`) args <- c(args, "--as-cran")

## doctopt results are characters, so if we meant NULL we have to set NULL
if (opt$repo == "NULL") opt$repo = NULL

r <- getOption("repos")
r["CRAN"] <- opt$repo
options(repos = r)

## helper functions
checkArg <- function(p, args) {
    tools:::.check_packages(c(p, args))
}

## helper function which switches to local (ie NULL) repo if matching file is presented
installArg <- function(p, lib, rep) {
    p <- gsub("_.*tar\\.gz$", "", p)
    install.packages(pkgs=p,
                     lib=lib,
                     repos=rep,
                     dependencies=c("Depends", "Imports", "LinkingTo", "Suggests"))
}

## if binary .deb files are to be installed first:
if (length(opt$`deb-pkgs`) > 1 || opt$`deb-pkgs` != FALSE) {
    cmd <- paste0(if (opt$`use-sudo`) "sudo " else "",
                 "apt-get install -y ", paste(opt$`deb-pkgs`, collapse=" "))
    system(cmd)
}

## if dependencies are to be installed first:
if (opt$`install-deps`) sapply(opt$TARGZ, installArg, opt$lib, opt$repo)

## change directory if a target directory was given
if (opt$setwd != "") setwd(opt$setwd)

## installation given selected options and arguments
sapply(opt$TARGZ, checkArg, args)
