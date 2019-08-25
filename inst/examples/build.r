#!/usr/bin/env r
##
##  A simple example to builds a source tar.gz file
##
##  Copyright (C) 2017 - 2019  Dirk Eddelbuettel
##
##  Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

doc <- "Usage: build.r [-f] [-h] [PACKAGES ...]

-f --fast      skip building vignettes and manual
-h --help      show this help text

Simple wrapper to 'R CMD build ...' which
calls 'tools:::.build_packages()' just like
the 'R CMD build' invocation.
"

opt <- docopt(doc)

if (length(opt$PACKAGES) == 0) opt$PACKAGES <- "." 	# default argument current directory

argv <- if (opt$fast) c("--no-build-vignettes", "--no-manual", opt$PACKAGES) else opt$PACKAGES

extraargs <- c("--compact-vignettes", "--resave-data", argv)

tools:::.build_packages(extraargs, no.q=interactive())
