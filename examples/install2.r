#!/usr/bin/env r
#
# a simple example to install one or more packages

## load docopt package from CRAN, or stop if not available
suppressMessages(library(docopt))       # we need the docopt package 0.3 or later

## configuration for docopt
doc <- "Usage: install.r [-r REPO] [-l LIBLOC] [-h] [PACKAGES ...]

-r --repos REPO     repository to install from [default: http://cran.rstudio.com]
-l --libloc LIBLOC  location in which to install [default: /usr/local/lib/R/site-library]
-h --help                   show this help text"

## docopt parsing
opt <- docopt(doc)

## installation given selected options and arguments
install.packages(pkgs  = opt$PACKAGES,
                 lib   = opt$libloc,
                 repos = opt$repos,
                 dependencies=TRUE)

# Let errors be errors
# q(status=0)
