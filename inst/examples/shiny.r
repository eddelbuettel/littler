#!/usr/bin/env r
#
# Another example to run a shiny app
#
# Copyright (C) 2015  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## same as runApp()
host <- getOption("shiny.host", "127.0.0.1")

## configuration for docopt
doc <- paste0("Usage: shiny.r [-h] [--port PORT] [--host HOST] [--dir DIR]

-p --port PORT      port to use [default: NULL]
-o --host HOST      host string to use [default: ", host, "]
-d --dir DIR        directoru run application from [default: .]
-h --help           show this help text")

## docopt parsing
opt <- docopt(doc)

suppressMessages(library(shiny))
runApp(opt$dir, port=as.integer(opt$port), host=opt$host)
