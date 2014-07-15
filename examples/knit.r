#!/usr/bin/r
#
# Simple helper script for knitr
#
# Dirk Eddelbuettel, May 2013
#
# GPL-2 or later

if (is.null(argv)) {
    cat("Need an argument FILE.Rnw\n")
    q(status=-1)
}


file <- argv[1]
if (!file.exists(file)) {
    cat("File not found: ", file, "\n")
    q(status=-1)
}

require(knitr)
knit2pdf(file)
