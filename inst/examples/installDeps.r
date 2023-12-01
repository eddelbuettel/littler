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
doc <- "Usage: installDeps.r [-h] [-x] [-s] [-d DEPS] [ARGS]

-d --deps DEPS    Logical or char, see '?install.packages', use 'TRUE' for all, [default: NA]
-s --suggests     Add 'Suggests' to dependencies, shortcut for '--deps TRUE'
-h --help         show this help text
-x --usage        show help and short example usage
"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("

Basic usage:

  installDeps.r .
  installDeps.r somePackage_1.2.3.tar.gz

The argument to '--deps' can be a combinations of 'Depends', 'Imports', 'LinkingTo',
'Suggests', and 'Enhances'. Default of 'NA' means first three, 'TRUE' means the first
four.

installDeps.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (length(opt$ARGS)==0 && file.exists("DESCRIPTION") && file.exists("NAMESPACE")) {
    ## we are in a source directory, so build it
    message("* installing deps for *source* package found in current working directory ...")
    opt$ARGS <- "."
}

if (opt$deps == "TRUE") opt$deps <- TRUE
if (opt$deps == "NA") opt$deps <- NA
if (opt$suggests) opt$deps <- TRUE

## ensure installation is stripped
Sys.setenv("_R_SHLIB_STRIP_"="true")

invisible(sapply(opt$ARGS, function(r) install_deps(r, dependencies=opt$deps)))
