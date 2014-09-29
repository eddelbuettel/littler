#!/usr/bin/env r
#
# a simple example to install one or more packages

## load docopt package from CRAN, or stop if not available
suppressMessages(library(docopt))       # we need the docopt package 0.3 or later
suppressMessages(library(devtools)) 

## configuration for docopt
doc <- "Usage: installGithub.r [-r REPO] [-l LIBLOC] [-h] [-d DEPS] [PACKAGES ...]

-r --repos REPO     repository to install from [default: http://cran.rstudio.com]
-l --libloc LIBLOC  location in which to install [default: /usr/local/lib/R/site-library]
-h --help                   show this help text
-d --deps DEPS      Install suggested dependencies as well? [default: FALSE]"

## docopt parsing
opt <- docopt(doc)

## installation given selected options and arguments
options(repos = opt$repos)
install_github(repo  = opt$PACKAGES,
               paste("-l =", opt$libloc),
               dependencies = opt$deps)

# Let errors be errors
# q(status=0)
