#!/usr/bin/env r
#
# Simple helper script for simplermarkdown, reusing the older one for knitr
#
# Dirk Eddelbuettel, May 2013, Dec 2021
#
# GPL-2 or later

if (is.null(argv)) {
    cat("Need an argument FILE.md\n")
    q(status=-1)
}


file <- argv[1]
if (!file.exists(file)) {
    cat("File not found: ", file, "\n")
    q(status=-1)
}

simplermarkdown::mdweave_to_html(file)
