#!/usr/bin/r
#
# A simple example to install RStudio Desktop
#
# Copyright (C) 2014 - 2017  Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)
#
# based on earlier https://raw.githubusercontent.com/rocker-org/rstudio-daily/master/latest.R
#
# todo: cmdline options for different download options

suppressMessages(library(rvest))

setwd("/tmp")                           # go to /tmp

url <- "https://dailies.rstudio.com/rstudioserver/oss/ubuntu/amd64/"
pg <- read_html(url)
tb <- html_table(html_nodes(pg, "table"))[[1]]
file <- tb[1,1]
s3url <- "https://s3.amazonaws.com/rstudio-ide-build/server/precise/amd64/"
fileurl <- paste0(s3url, file)
download.file(fileurl, file, method="wget")
