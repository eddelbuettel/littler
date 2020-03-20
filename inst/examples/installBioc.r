#!/usr/bin/env r
#
# Install a package from BioConductor
#
# Copyright (C) 2020 -       Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: installBioc.r [-l LIBLOC] [-h] [-x] [PACKAGES ...]

-l --libloc LIBLOC  location in which to install [default: /usr/local/lib/R/site-library]
-h --help           show this help text
-x --usage          show help and short example usage"
opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where PACKAGES... can be one or more BioConductor names. Functionality depends on
package 'BiocManger' which has be installed.

Examples:
  installBioc.r -l /tmp/lib S4Vectors               # install into given library

installBioC.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (!requireNamespace("BiocManager", quietly=TRUE)) {
    stop("Please install 'BiocManager' first, for example via 'install.r BiocManager'.", call.=FALSE)
}

## ensure installation is stripped
Sys.setenv("_R_SHLIB_STRIP_"="true")

## set .libPaths()
.libPaths(opt$lib)

BiocManager::install(opt$PACKAGES, update=FALSE, ask=FALSE)
