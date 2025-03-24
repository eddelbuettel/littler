#!/usr/bin/env r
#
# Simple r2u helper frontend
#
# Copyright (C) 2022 - 2024  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

library(docopt)

doc <- "Usage: r2u.r [--release DIST] [--debug] [--verbose] [--force] [--xvfb] [--bioc] [--suffix SUF] [--debver DBV] [--plusdfsg] [--uncache] [--dryrun] [--compile] [--help] CMD ...

Options:
-r --release DIST   release distribution to use, one of 'focal', 'jammy', 'noble' [default: jammy]
-d --debug          boolean flag for extra debugging
-v --verbose        boolean flag for verbose operation
-f --force          boolean flag to force a build
-x --xvfb           boolean flag to build under 'xvfb' (x11 virtual framebuffer)
-b --bioc           boolean flag to update BioConductor (subset) not CRAN
-s --suffix SUF     build version suffix appended [default: .1]
-t --debver DBV     debian version leading digit [default: 1.]
-p --plusdfsg       boolean flag if upstream version gets '+dfsg'
-u --uncache        remove the cached meta data archives of available packages (when using 'build' or 'package' commands)
-n --dryrun         boolean flag for dry-run of skip build  (when using 'build' or 'package' commands)
-c --compile        boolean flag for ensuring a compilation from source
-h --help           show this help text

Commands:
build        updates all packages
last         reports most recent binary package sync
count        counts packages downloaded (locally) today
table        tabulates packages downloaded today
package      updates the package(s) named in ... and builds
"

opt <- docopt(doc)
if (!is.finite(match(opt$release, c("focal", "jammy", "noble"))))
    stop("Unknown distro '", opt$release, "'.", call. = FALSE)

if (length(opt$CMD) > 1) {
    opt$args <- opt$CMD[-1]
    opt$CMD <- opt$CMD[1]
}

if (!is.finite(match(opt$CMD, c("build", "last", "count", "table", "package"))))
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
                         opt$xvfb,
                         opt$bioc,
                         opt$dryrun)

} else if (is.finite(match(opt$CMD, "last"))) {
    D <- RcppSimdJson::fload("https://p3m.dev/__api__/sources/1/transactions")
    #ts <- anytime::utctime(D[1,"completed"])
    #dh <- as.numeric(difftime(Sys.time(), ts, units="hours"))
    #un <- "days"
    #if (dh <= 3) un <- "mins" else if (dh < 25) un <- "hours"
    #cat("P3M/PPM/RSPM last updated", format(round(difftime(Sys.time(), ts, units=un),1)), "ago\n")
    ## no longer includes hours :-/
    ld <- anytime::utcdate(D[1,"completed"])
    cat("P3M/PPM/RSPM last updated", as.integer(Sys.Date()) - as.integer(ld), "days ago on", format(ld), "\n")

} else if (is.finite(match(opt$CMD, "count"))) {
    ll <- readLines(pipe("bash -c ~/bin/web_who_what | grep '.*cranapt\\/pool\\/dists\\/.*\\/r-.*\\.deb$'"))
    cat(length(ll), ".deb files downloaded\n")

} else if (is.finite(match(opt$CMD, "table"))) {
    con <- pipe("bash -c ~/bin/web_who_what | grep '.*cranapt\\/pool\\/dists\\/.*\\/r-.*\\.deb$'")
    ll <- readLines(con)
    close(con)
    tt <- table(gsub(".*r-(cran|bioc)-(.*)_\\d+.*", "\\2", ll, perl=TRUE))
    print(head(tt[order(-tt)], 10))

} else if (is.finite(match(opt$CMD, "package"))) {
    library(r2u)
    if (opt$uncache) {
        for (db in c(r2u:::.defaultCRANDBFile(), r2u:::.defaultAPFile()))
            if (file.exists(db)) unlink(db)
        r2u:::.loadDB()
        r2u:::.loadAP()
    }
    for (p in opt$args) {
        buildPackage(pkg     = p,
                     tgt     = opt$release,
                     debug   = opt$debug,
                     verbose = opt$verbose,
                     force   = opt$force,
                     xvfb    = opt$xvfb,
                     suffix  = opt$suffix,
                     debver  = opt$debver,
                     plusdfsg= opt$plusdfsg,
                     dryrun  = opt$dryrun,
                     compile = opt$compile)
    }
}
