#!/usr/bin/env r
#
# A simple example to invoke unit tests
#
# Copyright (C) 2014 - 2017  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

suppressMessages({
    library(docopt)       # we need the docopt package
    library(RUnit)        # we need the RUnit package
})

doc <- "Usage: runit.r [-p PACKAGES] [--help] [FILES ...]

-p --packages PACKAGES      comma-separated list of packages to install [default: ]
-h --help                   show this help text"

opt <- docopt(doc)

for (p in strsplit(opt$packages, ",")[[1]])
    suppressMessages(require(p, character.only=TRUE))

for (f in opt$FILES)
    runTestFile(f)

q(status=0)
