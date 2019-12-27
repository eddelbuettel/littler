#!/usr/bin/env r
#
# A simple example to update packages in /usr/local/lib/R/site-library
# Parameters are easily adjustable
#
# Copyright (C) 2006 - 2019  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: update.r [-r REPO...] [-l LIBLOC] [-n NCPUS] [-h] [-x]

-r --repos REPO     repository to use, or NULL for file [default: getOption]
-l --libloc LIBLOC  path to examine for packages to update [default: NULL]
-n --ncpus NCPUS    number of processes to use for parallel install [default: getOption]
-h --help           show this help text
-x --usage          show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("updates packages, optionally from a given repository, fo a library location.

Examples:
  update.r                                     # update installed packages
  update.r -l /srv/R-lib                       # update for this location

update,r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

## docopt results are characters, so if we meant NULL we have to set NULL
if (opt$repos == "NULL")  {
    opt$repos <- NULL
} else if (opt$repos == "getOption") {
    ## adjust as necessary, see help('download.packages')
    opt$repos <- getOption("repos")
}

if (opt$ncpus == "getOption") {
    opt$ncpus <- getOption("Ncpus", 1L)
} else if (opt$ncpus == "-1") {
    ## parallel comes with R 2.14+
    opt$ncpus <- max(1L, parallel::detectCores())
}

if (opt$libloc == "NULL") {
    ## NULL corresponds to .libPaths() but some directories may be non-writeable
    ## so we filter out the ones where we can write and use only those
    canWrite <- function(d) file.access(d, mode=2) == 0
    opt$libloc <- Filter(canWrite, .libPaths())
}

## ensure installation is stripped
Sys.setenv("_R_SHLIB_STRIP_"="true")

## simply unrolling of all unlink over all files 'repos*' in $TMP
clearCache <- function() {
    sapply(list.files(path=tempdir(), pattern="*rds$", full.names=TRUE), unlink)
}

## Always clear caches of remote and local packages
clearCache()

update.packages(lib.loc=opt$libloc, repos=opt$repos, Ncpus=opt$ncpus, ask=FALSE)

## Always clear caches of remote and local packages
clearCache()
