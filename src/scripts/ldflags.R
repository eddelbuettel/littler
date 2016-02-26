##
##  littler - Provides hash-bang (#!) capability for R (www.r-project.org)
##
##  Copyright (C) 2006 - 2016  Jeffrey Horner and Dirk Eddelbuettel
##
##  littler is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 2 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program; if not, write to the Free Software
##  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
##

s <- Sys.info()
if (is.null(s)) q()
if (s[1] != "Linux") q()
ldp <- strsplit(Sys.getenv('LD_LIBRARY_PATH'),':')[[1]]
ldp <- ldp[which(ldp != "")]
cat(paste(paste0('-Wl,-rpath,', ldp), collapse=" "), "\n")
