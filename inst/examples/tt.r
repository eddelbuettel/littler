#!/usr/bin/env r
#
# tinytest wrapper
#
# Copyright (C) 2019         Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (!requireNamespace("tinytest", quietly=TRUE))
    stop("Please install 'inytest' from CRAN.", call. = FALSE)

## load docopt and tinytest from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
    library(tinytest)             # or can use devtools as a fallback
})

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: tt.r [-h] [-x] [-a] [-b] [-f] [-d] [-p] [ARG...]

-a --all            use test_all mode [default: FALSE]
-b --build          use build-install-test mode [default: FALSE]
-f --file           use file mode [default: FALSE]
-d --directory      use directory mode [default: FALSE]
-p --package        use package mode [default: FALSE]
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

tt.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (opt$all) {
    test_all(if (length(opt$ARG) == 0) "." else opt$ARG)
} else if (opt$build) {
    build_install_test(if (length(opt$ARG) == 0) "." else opt$ARG)
} else if (opt$file) {
    run_test_file(opt$ARG)
} else if (opt$directory) {
    run_test_dir(opt$ARG)
} else if (opt$package) {
    test_package(opt$ARG)
}
