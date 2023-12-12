#!/usr/bin/env r
#
# A simple example to install from RSPM/PPM/P3M
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
doc <- paste0("Usage: install(RSPM|PPM|P3M).r [-c code] [-l libloc] [-h] [-x] ARGS...

-c --code ARG    set code name for distribution [default: ", code, "]
-l --libloc ARG  location in which to install [default: ", .libPaths()[1], "]
-h --help        show this help text
-x --usage       show help and short example usage

Note that RSPM/PPM/P3M support may be somewhat experimental. There may not be binaries
for every possibly OS, distibution, and R version. Please file issue tickets at the
Github repo for littler if you can contribute additional checks and values.

As RSPM has been renamed to PPM and then P3M, we now install the script thrice via hardlinks.
")

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n")
    cat("Basic usage:

  installRSPM.r digest	            # install digest for default release '", code, "'
  installPPM.r -c jammy digest      # install digest for Ubuntu 'jammy'
  installP3M.r -c bookworn digest   # install digest for Debian 'bookworm'

install(RSPM|PPM|P3M).r is part of littler which brings 'r' to the command-line.
See https://dirk.eddelbuettel.com/code/littler.html for more information.\n", sep="")
    q("no")
}

if (!is.null(opt$libloc)) .libPaths(opt$libloc)

r <- getOption("repos")
r["CRAN"] <- paste0("https://p3m.dev/all/__linux__/", opt$code, "/latest")
options(repos = r)
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(),
                                paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))

invisible(sapply(opt$ARGS, function(r) install.packages(r)))
