#!/usr/bin/env r
#
# Aggregation of 'deadline' packages by maintainer -- simplistic as it does
# not further normalize the 'Maintainer' field
#
# Copyright (C) 2025  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

db <- as.data.frame(tools::CRAN_package_db())
dd <- with(db, db[!is.na(Deadline), c("Package", "Deadline", "Maintainer")])
bb <- aggregate(Package ~ Maintainer, dd, NROW)
bb <- with(bb, bb[Package > 1,])
bb <- with(bb, bb[order(-Package),])
print(bb, row.names=FALSE)
