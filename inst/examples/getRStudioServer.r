#!/usr/bin/env r
#
# A simple example to install RStudio Desktop
#
# Copyright (C) 2014 - 2020  Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)
#
# based on earlier https://raw.githubusercontent.com/rocker-org/rstudio-daily/master/latest.R
#
# todo: cmdline options for different download options

suppressMessages(library(rvest))

setwd("/tmp")                           # go to /tmp

#url <- "https://dailies.rstudio.com/rstudioserver/oss/ubuntu/amd64/"
#url <- "https://dailies.rstudio.com/rstudioserver/oss/ubuntu/x86_64/"
url <- "https://dailies.rstudio.com/rstudioserver/oss/bionic/x86_64/"
pg <- read_html(url(url))
tb <- html_table(html_nodes(pg, "table"))[[1]]
file <- tb[[1,1]]
s3url <- "https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/"
fileurl <- paste0(s3url, file)
download.file(fileurl, file, method="wget")

## possibly simpler
## cf https://support.rstudio.com/hc/en-us/articles/203842428-Getting-the-newest-RStudio-builds
## fileurl <- "https://www.rstudio.org/download/latest/stable/server/ubuntu64/rstudio-server-latest-amd64.deb"
#download.file(fileurl, "rstudio-server-latest-amd64.deb", method="wget")
