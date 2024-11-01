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
doc <- paste0("Usage: installRub.r [-h] [-x] [-k] [-m] [-d] [-r REL] [-v VER] [-u UNIV] PACKAGES

-u --universe UNIV  required argument specifying universe [default: ]
-v --version VER    R 'major.minor' version release pair to install for [default: ", rver, "]
-r --release REL    Ubuntu LTS release to install to install for [default: ", uburel, "]
-k --keepoption     so not set option 'bspm.version.check' to 'TRUE' as is default
-m --minimal        use a minimal repos vector i.e. do not add CRAN repo
-d --disable        disable 'bspm' if set which can help with packages also on CRAN
-h --help           show this help text
-x --usage          show help and short example usage.

PACKAGES can also be a shorthand 'package@universe'. See '-x | --usage' for more.")
opt <- docopt(doc)			# docopt parsing
if (opt$usage) {
    cat(doc, "\n\n")
    cat("In general, PACKAGES... can be one or more R package names available in then selected
r-universe repository; its CRAN (as well as some core BioConductor) dependencies will be
provided automatically by r2u. It can also be a shorthand 'package@universe'.

Note that while CRAN works extremely hard to always provide an installable set of working
packages, r-universe works under a different model and its packages cannot offer any such
guarantees. Also note that while we use 'r2u' for the CRAN (and, to some extend, BioConductor)
parts full-filling *all* dependencies completely, the binaries from r-universe do not carry
any (system-)dependency info so you may end up with missing libries you may need to add. Where
an r-universe package exists on CRAN you can cover your ground by first installing the CRAN
version and then the r-universe version.

Examples:
  installRub.r -u rcppcore Rcpp RcppArmadillo     # installs (never than CRAN / r2u) Rcpp(Armadillo)
  installRub.r -u eddelbuettel RcppKalman         # installs non-CRAN package RcppKalman
  installRub.r rcpp@rcppcore                      # alternate to install Rcpp from RcppCore universe
  installRub.r polars@rpolars                     # alternate to install polars from rpolars universe

installRub.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (getRversion() < "4.2.0") stop("R version 4.2.0 or later is required.", call. = FALSE)
if (!exists("osVersion")) stop("Cannot find 'osVersion'. Weird.", call. = FALSE)
if (!isTRUE(startsWith(utils::osVersion, "Ubuntu"))) stop("Ubuntu is required as host system.", call. = FALSE)
has_bspm <- requireNamespace("bspm", quietly=TRUE)
if (!opt$minimal && !has_bspm) stop("The 'bspm' package is required.", call. = FALSE)

if (is.null(opt$universe) && length(opt$PACKAGES) == 1) {
    tokens <- strsplit(opt$PACKAGES, "@")[[1]]
    opt$PACKAGES <- tokens[1]
    opt$universe <- tokens[2]
}

univ <- paste0("https://", opt$universe, ".r-universe.dev/bin/linux/", opt$release, "/", opt$version)

if (!opt$keepoption) options(bspm.version.check=TRUE)

rep <- c("unic"=univ)
if (!opt$minimal) rep <- c(rep, cran=getOption("repos"))

if (opt$disable && has_bspm) bspm::disable()

install.packages(pkgs = opt$PACKAGES, repos = rep)
