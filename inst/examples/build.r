#!/usr/bin/env r
#
# A simple example to builds a source tar.gz file
#
# Copyright (C) 2017         Dirk Eddelbuettel
#
# Released under GPL (>= 2)

suppressMessages({
    library(docopt)       # we need the docopt package
})

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

tools:::.build_packages(argv, no.q=interactive())
