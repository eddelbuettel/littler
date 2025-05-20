#!/usr/bin/env r
#
# Minimal 'Deadline' field printer from CRAN db
#
# Copyright (C) 2024 - 2025  Dirk Eddelbuettel
#
# Released under GPL (>= 2)
#
# Uses argv[1], if present, to provide column width else use heuristic

## borrowed with love from tinytest and marginally extended
.color_str <- function(x, color) {
    cmap <- c(cyan=36, red=31, green=32, blue=34, purple=35)
    sprintf("\033[0;%dm%s\033[0m", cmap[color], x)
}
.blue <- function(txt) .color_str(txt, "blue")
.purple <- function(txt) .color_str(txt, "purple")

db <- as.data.frame(tools::CRAN_package_db())
dd <- with(db, db[!is.na(Deadline), c("Package", "Version", "Deadline")])
dd <- with(dd, dd[order(Deadline, Package), ])

cols <- if (length(argv) >= 1) as.integer(argv[1]) else 1.45*getOption("width")
dts <- unique(dd[, "Deadline"])
for (d in seq_along(dts)) {
    cat(.blue(dts[d]), ": ", sep="")
    ind <- with(dd, Deadline == dts[d])
    blk <- dd[ind, ]
    pv <- paste0(.purple(blk[,1]), " (", blk[,2], ")")
    cat(paste(strwrap(paste(pv, collapse=", "), cols), "\n"))
}
