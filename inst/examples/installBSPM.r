#!/usr/bin/env r
#
# A simple example to install from RSPM
#
# Copyright (C) 2020 - present  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt from CRAN
suppressMessages({
    library(docopt)               # we need docopt (>= 0.3) as on CRAN
})

if (Sys.info()[["sysname"]] != "Linux")
    stop(paste("Currently only supported on Linux.",
               "Please get in touch if you want to / can help on macOS"), call.=FALSE)

if (!requireNamespace("bspm", quietly=TRUE))
    stop("The 'bspm' package is required. Please install it.", call.=FALSE)

## configuration for docopt
doc <- paste0("Usage: installBSPM.r [-h] [-x] ARGS...
-h --help        show this help text
-x --usage       show help and short example usage

Note that BSPM support is still somewhat experimental. It also requires support
(via the 'bspm' package) of the underlying system package manager, which is known to
work for apt/dpkg (Debian, Ubuntu, ...) and dnf/yum (Fedora/RH/CentOS). Please file
issue tickets at the Github repo for littler (or bspm) if you can help with additional
settings.

Note that to take fullest advantage of BSPM, you also need the system package manager to
know about the largest number of pre-compiled packages. For Ubuntu, this means the
exanded 'ppa:c2d4u.team/c2d4u4.0+' repo, and for Fedora the say 'iucar/cran' Copr archive.
This user-level script does not attempt to later your system-level repository information.
")

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("

Basic usage:

  installBSPM.r digest

installBSPM.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

library(bspm)
bspm::enable()
options(bspm.sudo=TRUE)

install.packages(opt$ARGS)
