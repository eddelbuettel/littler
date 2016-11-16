#!/usr/bin/env r
#
# Another example to run a shiny app
#
# Copyright (C) 2016  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN

## configuration for docopt
doc <- "Usage: render.r [-h] [-x] [FILES...]

-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  render.r foo.Rmd bar.Rmd        # convert two given files

render.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

print(opt)

library(rmarkdown)

## helper function 
renderArg <- function(p) {
    if (!file.exists(p)) stop("No file '", p, "' found. Aborting.", .Call=FALSE)
    render(p)
}

## render files using helper function 
sapply(opt$FILES, renderArg)
