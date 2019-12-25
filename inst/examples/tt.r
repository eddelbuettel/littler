#!/usr/bin/env r
#
# tinytest wrapper
#
# Copyright (C) 2019         Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (!requireNamespace("tinytest", quietly=TRUE))
    stop("Please install 'tinytest' from CRAN.", call. = FALSE)

## load docopt and tinytest from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
    library(tinytest)             # or can use devtools as a fallback
})

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: tt.r [-h] [-x] [-a] [-b] [-d] [-f] [-n NCPUS] [-p] [-s] [-z] [ARG...]

-a --all            use test_all mode [default: FALSE]
-b --build          use build-install-test mode [default: FALSE]
-d --directory      use directory mode [default: FALSE]
-f --file           use file mode [default: FALSE]
-n --ncpus NCPUS    use 'ncpus' in parallel [default: getOption]
-p --package        use package mode [default: FALSE]
-s --silent         use silent and do not print result [default: FALSE]
-z --effects        suppress side effects [default: FALSE]
-h --help           show this help text
-x --usage          show help and short example usage"
opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where ARG... can be one or more file name, or directories or package names.

Examples:
  tt.r -a                             # test 'all files' from current directory
  tt.r -f testfile.R                  # test the file 'testfile.R'
  tt.t -d testdir                     # test all files in the directory 'testdir'
  tt.r -p testpkg                     # test the (installed) package 'testpkg'
  tt.r                                # run test_all() iff DESCRIPTION && inst/tinytest/

tt.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

sideeffects <- if (opt$effects) FALSE else TRUE       # by default, use side effects
                                        #ncpu <- if (opt$ncpu) as.integer(opt$ncpu) else getOption("Ncpus", 1)

if (opt$ncpus == "getOption") {
    opt$ncpus <- getOption("Ncpus", 1L)
} else if (opt$ncpus == "-1") {
    ## parallel comes with R 2.14+
    opt$ncpus <- max(1L, parallel::detectCores())
} else {
    opt$ncpus <- as.integer(opt$ncpus)
}


res <- NULL
if (opt$all) {
    res <- test_all(if (length(opt$ARG) == 0) "." else opt$ARG, side_effects=sideeffects)
} else if (opt$build) {
    res <- build_install_test(if (length(opt$ARG) == 0) "." else opt$ARG, side_effects=sideeffects, ncpu=opt$ncpus)
} else if (opt$file) {
    res <- run_test_file(opt$ARG, side_effects=sideeffects)
} else if (opt$directory) {
    res <- run_test_dir(opt$ARG, side_effects=sideeffects)
} else if (opt$package) {
    res <- test_package(opt$ARG, side_effects=sideeffects, ncpu=opt$ncpus)
} else if (file.exists("DESCRIPTION") && dir.exists("inst/tinytest")) {
    res <- test_all(".", side_effects=sideeffects)
}

if (!opt$silent && !is.null(res)) print(res)
