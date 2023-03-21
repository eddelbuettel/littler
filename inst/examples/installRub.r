#!/usr/bin/env r
#
# A installer for r-universe binaries (on Ubuntu 'jammy' only)
#
# Copyright (C) 2023         Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)
library(utils) 		# for osVersion

rver <- gsub("^([\\d].[\\d]).*$", "\\1", as.character(getRversion()), perl=TRUE)
uburel <- "jammy"
## configuration for docopt
doc <- paste0("Usage: installRub.r [-h] [-x] [-k] [-r REL] [-v VER] [-u UNIV] PACKAGES

-u --universe UNIV  *required* argument specifying universe [default: ]
-v --version VER    R 'major.minor' version release pair to install for [default: ", rver, "]
-r --release REL    Ubuntu LTS release to install to install for [default: ", uburel, "]
-k --keepoption     so not set option 'bspm.version.check' to 'TRUE' as is default
-h --help           show this help text
-x --usage          show help and short example usage")
opt <- docopt(doc)			# docopt parsing
if (opt$usage || is.null(opt$universe)) {
    cat(doc, "\n\n")
    cat("where PACKAGES... can be one or more R package names available in then selected
r-universe repository; its CRAN (as well as some core BioConductor) dependencies will be
provided automatically by r2u.

Note that while CRAN works extremely hard to always provide an installable set of working
packages, r-universe works under a different model and its packages cannot offer any such
guarantees. Also note that while we use 'r2u' for the CRAN (and, to some extend, BioConductor)
parts full-filling *all* dependencies completely, the binaries from r-universe do not carry
any (system-)dependency info so you may end up with missing libries you may need to add. Where
an r-universe package exists on CRAN you can cover your ground by first installing the CRAN
version and the r-universe version.

Examples:
  installRub.r -u rcppcore Rcpp                   # installs (never than CRAN / r2u) Rcpp
  installRub.r -u eddelbuettel RcppKalman         # installs non-CRAN package RcppKalman

installRub.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (getRversion() < "4.2.0") stop("R version 4.2.0 or later is required.", call. = FALSE)
if (!exists("osVersion")) stop("Cannot find 'osVersion'. Weird.", call. = FALSE)
if (!startsWith(utils::osVersion, "Ubuntu")) stop("Ubuntu is required as host system.", call. = FALSE)
if (!requireNamespace("bspm", quietly=TRUE)) stop("The 'bspm' package is required.", call. = FALSE)

univ <- paste0("https://", opt$universe, ".r-universe.dev/bin/linux/", opt$release, "/", opt$version)
if (!opt$keepoption) options(bspm.version.check=TRUE)
install.packages(pkgs = opt$PACKAGES, repos = c(univ, "https://cloud.r-project.org"))
