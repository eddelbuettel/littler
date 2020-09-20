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
if (file.exists("/etc/os-release")) {   # next block borrowed from my chshli package on GitHub
    osrel <- read.table("/etc/os-release", sep="=", row.names=1, col.names=c("key","value"))
    if ("REDHAT_SUPPORT_PRODUCT" %in% rownames(osrel)) {
        # 'centos7' for CentOS/RHEL 7, 'centos8' for CentOS/RHEL 8 and Fedora
        ver <- osrel["REDHAT_SUPPORT_PRODUCT_VERSION", "value"]
        code <- paste0("centos", min(as.numeric(ver), 8))
    } else if ("VERSION_CODENAME" %in% rownames(osrel)) {
        code <- osrel["VERSION_CODENAME", "value"]
    }
}
if ((code == "<unknown>") && (Sys.which("lsb_release") != "")) {
    code <- system("lsb_release -c | awk '{print $2}'", intern=TRUE)
}

## configuration for docopt
doc <- paste0("Usage: installRSPM.r [-h] [-x] ARGS...

-c --code ARG    set code name for distribution [default: ", code, "]
-l --libloc ARG  location in which to install [default: ", .libPaths()[1], "]
-h --help        show this help text
-x --usage       show help and short example usage

Note that RSPM support is still somewhat experimental. There may not be binaries
for every possibly OS and distibution. Please file issue tickets at the Github
repo for littler if you can contribute additional checks and values.
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

if (!is.null(opt$libloc)) .libPaths(opt$libloc)

r <- getOption("repos")
r["CRAN"] <- paste0("https://packagemanager.rstudio.com/all/__linux__/", code, "/latest")
options(repos = r)
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(),
                                paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))

invisible(sapply(opt$ARGS, function(r) install.packages(r)))
