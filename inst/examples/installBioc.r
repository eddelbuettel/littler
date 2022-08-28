#!/usr/bin/env r
#
# Install a package from BioConductor
#
# Copyright (C) 2020 - 2022  Dirk Eddelbuettel
# Copyright (C) 2022 - 2022  Dirk Eddelbuettel and Pieter Moris
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## default to first library location in .libPaths()
libloc <- .libPaths()[1]

## configuration for docopt
doc <- paste0("Usage: installBioc.r [-l LIBLOC] [-d DEPS] [-n NCPUS] [-r REPO ...] [--error] [--skipinstalled] [-m METHOD] [--force] [--update] [-h] [-x] [PACKAGES ...]
-l --libloc LIBLOC  location in which to install [default: ", libloc, "]
-d --deps DEPS      install suggested dependencies as well [default: NA]
-n --ncpus NCPUS    number of processes to use for parallel install [default: getOption]
-r --repo REPO      additional repository to use [default: getOption]
-e --error          throw error and halt instead of a warning [default: FALSE]
-s --skipinstalled  skip installing already installed packages (takes priority over --force) [default: FALSE]
-m --method METHOD  method to be used for downloading files [default: auto]
-f --force          force re-download of packages that are currently up-to-date [default: FALSE]
-u --update         update old already installed packages [default: FALSE]
-h --help           show this help text
-x --usage          show help and short example usage")
opt <- docopt(doc)  # docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where PACKAGES... can be one or more BioConductor names. Functionality depends on
package 'BiocManger' which has be installed.

Examples:
  installBioc.r -l /tmp/lib S4Vectors               # install into given library
  installBioc.r --update Biobase                    # install package and update older packages
  installBioc.r --deps NA --error --skipinstalled   # install package without suggested dependencies,
                                                    # throw an error on installation failure and skip
                                                    # packages that are already present

installBioC.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

if (!requireNamespace("BiocManager", quietly=TRUE)) {
    stop("Please install 'BiocManager' first, for example via 'install.r BiocManager'.", call.=FALSE)
}

## set repository to empty character vector if not supplied, since
## this is the input expected by BiocManager::install(site_repository=)
## (does not accept NA)
## the custom repository must be a sub-repository of a main BioC_mirror
## e.g. software: https://bioconductor.statistik.tu-dortmund.de/packages/3.15/bioc/
## annotation: https://ftp.gwdg.de/pub/misc/bioconductor/packages/3.14/data/annotation
if (opt$repo == "getOption") {
    opt$repo = character()
}

## check if dependencies need to be installed, see
## https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages
## the default, NA, means c("Depends", "Imports", "LinkingTo"), but not "Suggests"
if (opt$deps == "TRUE" || opt$deps == "FALSE") {
    opt$deps <- as.logical(opt$deps)
} else if (opt$deps == "NA") {
    opt$deps <- NA
}

## set the number of parallel processes to use for a parallel install of
## more than one source package, see
## https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages
if (opt$ncpus == "getOption") {
    opt$ncpus <- getOption("Ncpus", 1L)
} else if (opt$ncpus == "-1") {
    ## parallel comes with R 2.14+
    opt$ncpus <- max(1L, parallel::detectCores())
}

## helper function to catch errors that could arise when package installation has failed
## and to skip installation of packages that are already present (for BiocManager::install()
## these would otherwise result in additional warnings)
install_bioc <- function(pkgs, ..., error = FALSE, skipinstalled = FALSE) {
    e <- NULL
    capture <- function(e) {
        if (error) {
            catch <-
                grepl("installation of one or more packages failed", e$message) ||
                grepl("is not available", e$message) ||
                grepl("had non-zero exit status", e$message) ||
                grepl("compilation failed for package.*", e$message) ||
                grepl("fatal error", e$message) ||
                grepl("No such file or directory", e$message)
            if (catch) {
                e <<- e
            }
        }
    }
    if (skipinstalled) {
        pkgs <- setdiff(pkgs, installed.packages()[,1])
    }
    if (length(pkgs) > 0) {
        withCallingHandlers(BiocManager::install(pkgs, ...), warning = capture)
        if (!is.null(e)) {
            stop(e$message, call. = FALSE)
        }
    }
}

## ensure installation is stripped
Sys.setenv("_R_SHLIB_STRIP_"="true")

## install requested packages using helper function
## ask must be set to FALSE because user prompts do not appear when calling
## R from the CLI, e.g.
## `R -e 'BiocManager::install("Biobase", ask=TRUE, update=TRUE)'`
## might warn that MASS is out of date, but would not show a user prompt
install_bioc(pkgs = opt$PACKAGES,
        lib = opt$libloc,
        site_repository = opt$repo,
        update = opt$update,
        ask = FALSE,
        force = opt$force,
        dependencies = opt$deps,
        Ncpus = opt$ncpus,
        method = opt$method,
        error = opt$error,
        skipinstalled = opt$skipinstalled)
