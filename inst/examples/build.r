#!/usr/bin/env r
#
# A simple example to builds a source tar.gz file
#
# Copyright (C) 2017         Dirk Eddelbuettel
#
# Released under GPL (>= 2)

if (is.null(argv) | length(argv) < 1) {
    cat("Usage: build.r [arg1 [args2 [...]]] pkg1 [pkg2 pkg3 ...]\n\n")
    cat("Simple wrapper to 'R CMD build ...'\n")
    cat("Calls 'tools:::.build_packages()' just like the 'R CMD build invocation.\n")
    cat("Use 'build.r -h' to see the available options for 'R CMD build'.\n")
    q()
}

tools:::.build_packages(argv, no.q=interactive())
