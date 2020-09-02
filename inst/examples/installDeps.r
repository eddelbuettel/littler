#!/usr/bin/env r
#
# A simple example to install dependencies
#
# Copyright (C) 2020 - present  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt and remotes (or devtools) from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
    library(remotes)              # or can use devtools as a fallback
})

## configuration for docopt
doc <- "Usage: installDeps.r [-h] [-x] [ARGS]

-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("

Basic usage:

  installDeps.r .
  installDeps.r somePackage_1.2.3.tar.gz

installDeps.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (length(opt$ARGS)==0 && file.exists("DESCRIPTION") && file.exists("NAMESPACE")) {
    ## we are in a source directory, so build it
    message("* installing deps for *source* package found in current working directory ...")
    opt$ARGS <- "."
}

## ensure installation is stripped
Sys.setenv("_R_SHLIB_STRIP_"="true")

invisible(sapply(opt$ARGS, function(r) install_deps(r)))
