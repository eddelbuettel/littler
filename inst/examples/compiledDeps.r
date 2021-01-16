#!/usr/bin/r
##
##  Show all dependencies of a package containing native ("compiled") code
##
##  Copyright (C) 2021 - present  Dirk Eddelbuettel
##
##  Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

if (!requireNamespace("data.table", quietly=TRUE))
    stop("The 'data.table' package is required. Please install it.", call.=FALSE)

doc <- "Usage: urlUpdate.r [-c] [-h] PACKAGE

-c --compact      compact, print only package vector
-h --help         show this help text

Simple wrapper around 'tools::CRAN_package_db()' and 'tools::package_depdencies()'.
"

opt <- docopt(doc)

suppressMessages(library(data.table))

pkg <- opt$PACKAGE
db <- setDT(tools::CRAN_package_db(), key="Package")
revs <- data.table(Package=tools::package_dependencies(pkg, recursive=TRUE, db=db)[[1]], key="Package")

res <- db[revs, .(Package,Version,Priority,NeedsCompilation)][
    is.na(Priority)==TRUE & is.na(Version)==FALSE & NeedsCompilation=="yes"][
   ,.(Package,Version)]

if (opt$compact) {
    cat(paste(res[[1]], collapse=" "), "\n")
} else {
    print(res)
}
