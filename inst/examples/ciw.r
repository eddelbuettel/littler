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
    library(ciw) 		        # at GitHub under eddelbuettel for now
    library(docopt)             # we need docopt (>= 0.3) as on CRAN
})

## configuration for docopt
doc <- "Usage: ciw.r [-h] [-x] [-a] [-m] [-i] [-t] [-p] [-w] [-r] [-s] [-n] [-u] [-l rows] [-z] [ARG...]

-m --mega           use 'mega' mode of all folders (see --usage)
-i --inspect        visit 'inspect' folder
-t --pretest        visit 'pretest' folder
-p --pending        visit 'pending' folder
-w --waiting        visit 'waiting' folder
-r --recheck        visit 'recheck' folder
-a --archive        visit 'archive' folder
-n --newbies        visit 'newbies' folder
-u --publish        visit 'publish' folder
-s --skipsort       skip sorting of aggregate results by age
-l --lines rows     print top 'rows' of the result object [default: 50]
-z --ping           run the connectivity check first
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

When no argument is given, 'auto' is selected which corresponds to 'inspect', 'waiting',
'pending', 'pretest', and 'recheck'. Selecting '-m' or '--mega' are select as default.

Folder selecting arguments are cumulative; but 'mega' is a single selections of all folders
(i.e. 'inspect', 'waiting', 'pending', 'pretest', 'recheck', 'archive', 'newbies', 'publish').

ciw.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

args <- character() 			# start with no arguments

folders <-  c("inspect", "waiting", "pending", "pretest", "recheck", "archive", "newbies", "publish")

for (dir in folders) 			# grow folder set as a select
    if (opt[[dir]])
        args <- c(args, dir)

if (opt$mega) args <- folders	# or respect the nuclear option
if (length(args) == 0)
    args <- "auto"

chk <- length(args) <= 1   		# ask for argument check only on short argument vectoe

res <- incoming(args, chk, isFALSE(opt$skipsort), isTRUE(opt$ping))

nr <- as.integer(opt$lines)
print(head(res, nr), nrows=nr)
