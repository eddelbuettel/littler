#!/usr/bin/r
#
# A simple example to invoke Sweave
#
# Copyright (C) 2014  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## use given argument(s) as target files, or else default to .Rnw files in directory
files <- if (length(argv) == 0) dir(pattern="*.Rnw") else argv <- Filter(function(x) file.info(x)$is.dir, argv)


## convert all files from Rnw to pdf using the highlight driver
invisible(sapply(files, function(srcfile) {
    Sweave(srcfile, driver=highlight::HighlightWeaveLatex(boxes=TRUE))
    tools::texi2pdf(gsub(".Rnw", ".tex", srcfile))
    tools::texi2pdf(gsub(".Rnw", ".tex", srcfile), texi2dvi="pdflatex")
}))
