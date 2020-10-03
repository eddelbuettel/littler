#!/usr/bin/env r
##
##  A simple tool to update URLs using R's checker
##
##  Copyright (C) 2020 - present  Dirk Eddelbuettel
##
##  Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

if (!requireNamespace("urlchecker", quietly=TRUE))
    stop("The 'urlchecker' package is required. Please install it from GitHub.", call.=FALSE)

doc <- "Usage: urlUpdate.r [-c] [-h] [PACKAGES ...]

-c --check-only   check-only, i.e. do not auto-update URLs
-h --help         show this help text

Simple wrapper to 'urlchecker::update_url(...)'.
"

opt <- docopt(doc)

if (length(opt$PACKAGES) == 0) opt$PACKAGES <- "." 	# default argument current directory

for (p in opt$PACKAGES)
    if (opt$check_only) print(urlchecker::url_check(p)) else urlchecker::url_update(p)
