#!/usr/bin/env r
#
# ciw wrapper
#
# Copyright (C) 2024  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (!requireNamespace("ciw", quietly=TRUE))
    stop("Please install 'eddelbuettel/ciw' from GitHub.", call. = FALSE)

## load docopt and cranincoming
suppressMessages({
    library(docopt)             # we need docopt (>= 0.3) as on CRAN
    library(ciw) 		        # at GitHub under eddelbuettel for now
})

## configuration for docopt
doc <- "Usage: ciw.r [-h] [-x] [-a] [-i] [-t] [-p] [-w] [-r] [-s] [ARG...]

-a --auto           use 'auto' mode (see --usage)
-i --inspect        visit 'inspect' folder
-t --pretest        visit 'pretest' folder
-p --pending        visit 'pending' folder
-w --waiting        visit 'waiting' folder
-r --recheck        visit 'waiting' folder
-s --skipsort       skip sorting of aggregate results by age
-h --help           show this help text
-x --usage          show help and short example usage"
opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where ARG... can be one or more file name, or directories or package names.

Examples:
  ciw.r -ip                            # run in 'inspect' and 'pending' mode
  ciw.r -a                             # run with mode 'auto' resolved in incoming()
  ciw.r                                # run with defaults, same as '-itpwr'

Currently, 'inspect', 'waiting', 'pending', 'pretest', 'recheck' are select as default.

Folder selecting arguments are cumulative.

ciw.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

args <- character()
chk <- TRUE
#print(opt)

if (opt$auto) args <- "auto"
if (opt$inspect) args <- c(args, "inspect")
if (opt$pretest) args <- c(args, "pretest")
if (opt$pending) args <- c(args, "pending")
if (opt$waiting) args <- c(args, "waiting")
if (opt$recheck) args <- c(args, "recheck")

if (length(args) == 0) {
    args <- c("inspect", "waiting", "pending", "pretest", "recheck")
}

res <- incoming(args, length(args) <= 1)

if (opt$skipsort) print(res[]) else print(res[order(Age)])
