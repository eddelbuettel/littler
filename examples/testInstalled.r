#!/usr/bin/env r
#
# a simple example to test one or more installed packages

## load docopt package from CRAN, or stop if not available
suppressMessages(library(docopt))       # we need the docopt package 0.3 or later
suppressMessages(library(tools))      

## configuration for docopt
doc <- "Usage: test.r [-l LIBLOC] [-o OUTDIR] [-t TYPES] [-s SRCDIR] [-h] [PACKAGES ...]

-l --libloc LIBLOC  location where package(s) are installed [default: NULL]
-o --outdir OUTDIR  the directory into which to write output files, should exist. [default: .]
-t --types TYPES    type(s) of tests to be done. [default: c('examples', 'tests', 'vignettes')]
-s --srcdir SRCDIR  Optional directory to look for .save files [default: NULL]
-h --help           show this help text"


## docopt parsing
opt <- docopt(doc)

## installation given selected options and arguments
testInstalledPackage(pkg = opt$PACKAGES,
                     lib = opt$libloc,
                  outDir = opt$outdir,
                   types = opt$types,
                  srcdir = opt$srcdir)

