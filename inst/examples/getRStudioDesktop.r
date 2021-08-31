#!/usr/bin/env r
#
# A simple example to install RStudio Desktop
#
# Copyright (C) 2014 - 2021  Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)
#
# based on earlier https://raw.githubusercontent.com/rocker-org/rstudio-daily/master/latest.R
#
# todo: cmdline options for different download options

suppressMessages(library(rvest))

setwd("/tmp")                           # go to /tmp

#url <- "https://dailies.rstudio.com/rstudio/oss/xenial/amd64/"
#url <- "https://dailies.rstudio.com/rstudio/oss/ubuntu/amd64/"
#url <- "https://dailies.rstudio.com/rstudio/oss/xenial/x86_64"
url <- "https://dailies.rstudio.com/rstudio/oss/bionic/x86_64"
pg <- read_html(url(url))
tb <- html_table(html_nodes(pg, "table"))[[1]]
file <- tb[[1,1]]
#s3url <- "https://s3.amazonaws.com/rstudio-ide-build/desktop/xenial/amd64/"
#s3url <- "https://s3.amazonaws.com/rstudio-ide-build/desktop/trusty/amd64/"
#s3url <- "https://s3.amazonaws.com/rstudio-ide-build/desktop/bionic/amd64/"
s3url <- "https://s3.amazonaws.com/rstudio-ide-build/desktop%2Fbionic%2Famd64%2F"
fileurl <- paste0(s3url, gsub("\\+","%2B", file))
cat("'", fileurl, "' -> '", file, "'\n", sep="")
download.file(fileurl, file)

## ## probably simpler
## ## cf https://support.rstudio.com/hc/en-us/articles/203842428-Getting-the-newest-RStudio-builds
## fileurl <- "http://www.rstudio.org/download/latest/daily/desktop/ubuntu64/rstudio-latest-amd64.deb"
## download.file(fileurl, "rstudio-latest-amd64.deb", method="wget")
