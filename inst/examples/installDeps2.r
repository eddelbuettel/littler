#!/usr/bin/env r
#
# An even simpler example to install dependencies
#
# Copyright (C) 2024 - present  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt and remotes (or devtools) from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
})

## configuration for docopt
doc <- "Usage: installDeps2.r [-h] [-x] [-s] [DESC]

-s --suggests     Add 'Suggests' to dependencies
-h --help         show this help text
-x --usage        show help and short example usage
"

opt <- docopt(doc)          # docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("

  installDeps2.r

The script expects a DESCRIPTION file in the local directory (or given as the
argument) which it then parses.

The basic mechanics of doing this dependency-free came from a Dockerfile at the
`data.table` repository, and are a appreciated. An alternative version, relying
on the `remotes` package, has been available for several years with littler as
`installDeps.r`.

installDeps2.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (length(opt$DESC)==0 && file.exists("DESCRIPTION") && file.exists("NAMESPACE")) {
    #message("* installing deps for found in current working directory ...")
    descfile <- "DESCRIPTION"
} else {
    descfile <- opt$DESC
}

flds <- c("Imports", "Depends", "LinkingTo")
if (opt$suggests) flds <- c(flds, "Suggests")

res <- read.dcf(descfile)[1,]               # we read only one file so first row only
res <- res[intersect(names(res), flds)]     # intersect available and desired fields
pkgs <- tools:::.split_dependencies(res)    # parse and split, then diff off base packages
instpkgs <- setdiff(names(pkgs), tools:::.get_standard_package_names()$base)
install.packages(instpkgs)                  # and install remainder
