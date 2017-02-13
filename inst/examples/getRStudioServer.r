#!/usr/bin/r
#
# A simple example to install RStudio Desktop
#
# Copyright (C) 2014 - 2016  Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)
#
# based on earlier https://raw.githubusercontent.com/rocker-org/rstudio-daily/master/latest.R
#
# todo: cmdline options for different download options                                       #

## go to /tmp
setwd("/tmp")

## within _server_ one of _redhat32_, _redhat64_, _ubuntu32_, _ubuntu64_
url <- "http://www.rstudio.org/download/daily/server/ubuntu64/"

## get page and parse
pg <- httr::content(httr::GET(url), as = "text")
doc <- xml2::read_xml(pg)
deb <- xml2::xml_attr(xml2::xml_find_all(doc, "//tr[@id='row0']/td/a[@href]"), "href")

## download and save under given filename
download.file(deb, basename(deb), method="wget")
