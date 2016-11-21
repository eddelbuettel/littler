#!/usr/bin/env r
#
# Convert NEWS.Rd to markdown
#
# Copyright (C) 2016         Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN
suppressMessages(library(tools))     

## configuration for docopt
doc <- "Usage: rd2md.r [-h] [-x] [--src REPODIR] [--out OUTDIR] [FILES...]

-s --src REPODIR      source root directory [default: ~/git]
-o --out OUTDIR       output directory [default: /tmp]
-h --help             show this help text
-x --usage            show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  rd2md.r foo                                  # implies conversion of ~/git/foo/inst/NEWS.Rd
  rd2md.r ~/git/foo/inst/NEWS.Rd               # converts given file to markdown

rd2md.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

## docopt parsing
opt <- docopt(doc)

## helper function 
convertArg <- function(p, src, out) {
    filename <- mdfile <- NULL
    if (file.exists(p)) {
        filename <- p
        mdfile <- paste0(filename, ".md")
    } else {
        filename <- file.path(src, p, "inst", "NEWS.Rd")
        if (!file.exists(filename)) {
            stop("No matching file found for", p, call.=FALSE)
        }
        mdfile <- file.path(out, paste0(p, ".news.md"))
    }
    htmlfile <- paste0(filename, ".html")
    Rd2HTML(filename, htmlfile)
    cmd <- paste("pandoc", htmlfile, "-o", mdfile)
    system(cmd)
    unlink(htmlfile)
    cat("Converted", filename, "into", mdfile, "\n")
}

## insert packages using helper function 
sapply(opt$FILES, convertArg, opt$src, opt$out)

