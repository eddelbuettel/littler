#!/usr/bin/env r
#
# Simple r2u helper frontend
#
# Copyright (C) 2022         Dirk Eddelbuettel
#
# Released under GPL (>= 2)

library(docopt)

doc <- "Usage: r2u.r [--release DIST] [--debug] [--verbose] [--force] [--uncache] [--help] CMD [...]

Options:
-r --release DIST   release distribution to use, one of 'focal' or 'jammy' [default: jammy]
-d --debug          boolean flag for extra debugging
-v --verbose        boolean flag for verbose operation
-f --force          boolean flag to force build
-x --xvfb           boolean flag to build under 'xvfb' (x11 virtual framebuffer)
-u --uncache        remove the cached meta data archives of available packages
-h --help           show this help text

Cmd:
build        updates packages
lastsync     reports most recent binary package sync

Simple wrapper to 'r2u::buildUpdatedPackages(distro)'. The 'CMD' has to (for now)
be 'build (for buildUpdatedPackages)'.
"

opt <- docopt(doc)

if (!is.finite(match(opt$release, c("focal", "jammy"))))
    stop("Unknown distro '", opt$release, "'.", call. = FALSE)

if (!is.finite(match(opt$CMD, c("build", "last"))))
    stop("Unknown command '", opt$CMD, "'.", call. = FALSE)

if (is.finite(match(opt$CMD, "build"))) {
    library(r2u)
    if (opt$uncache) {
        for (db in c(r2u:::.defaultCRANDBFile(), r2u:::.defaultAPFile()))
            if (file.exists(db)) unlink(db)
        r2u:::.loadDB()
        r2u:::.loadAP()
    }
    buildUpdatedPackages(opt$release,
                         opt$debug,
                         opt$verbose,
                         opt$force,
                         opt$xvfb)
} else if (is.finite(match(opt$CMD, "last"))) {
    D <- RcppSimdJson::fload("https://packagemanager.rstudio.com/__api__/sources/1/transactions")
    ts <- anytime::utctime(D[1,"completed"])
    dh <- as.numeric(difftime(Sys.time(), ts, units="hours"))
    un <- "days"
    if (dh <= 3) un <- "mins" else if (dh < 25) un <- "hours"
    cat("RSPM last updated", format(round(difftime(Sys.time(), ts, units=un),1)), "ago\n")
}
