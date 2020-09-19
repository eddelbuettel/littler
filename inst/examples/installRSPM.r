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

code <- "<unknown>"
if (Sys.which("lsb_release") != "") {
    code <- system("lsb_release -c | awk '{print $2}'", intern=TRUE)
}

## configuration for docopt
doc <- paste0("Usage: installRSPM.r [-h] [-x] ARGS...

-c --code ARG   set code name for distribution [default: ", code, "]
-h --help       show this help text
-x --usage      show help and short example usage
")

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("

Basic usage:

  installRSPM.r digest

installRSPM.r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

r <- getOption("repos")
r["CRAN"] <- paste0("https://packagemanager.rstudio.com/all/__linux__/", code, "/latest")
options(repos = r)
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(),
                                paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))

invisible(sapply(opt$ARGS, function(r) install.packages(r)))
