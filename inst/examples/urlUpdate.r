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
    stop("The 'urlchecker' package is required. Please install it.", call.=FALSE)

doc <- "Usage: urlUpdate.r [-h] [PACKAGES ...]

-f --fast      skip building vignettes and manual
-h --help      show this help text

Simple wrapper to 'urlchecker::update_url(...)'.
"

opt <- docopt(doc)

if (length(opt$PACKAGES) == 0) opt$PACKAGES <- "." 	# default argument current directory

for (p in opt$PACKAGES) urlchecker::url_update(p)
