#!/usr/bin/env r
##
##  A wrapper for tools::check_package_url (and check_package_dois)
##
##  Copyright (C) 2025 - present  Dirk Eddelbuettel
##
##  Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

doc <- "Usage: checkPackageUrls.r [-s] [-v] [-h] [DIRS ...]

-s --skip-dois    do not run 'check_package_dois()' as well [default: FALSE]
-v --verbose      run in verbose mode mode [default: FALSE]
-h --help         show this help text

Simple wrapper to 'tools::check_package_urls(...)'.
"

opt <- docopt(doc)

if (length(opt$DIRS) == 0) opt$DIRS <- "." 	# default argument current directory

for (d in opt$DIRS) {
    tools::check_package_urls(d, isTRUE(opt$verbose))
    if (isFALSE(opt$skip_dois)) tools::check_package_dois(d, isTRUE(opt$verbose))
}
