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

ExcludeVars <- c("R_SESSION_TMPDIR","R_HISTFILE","R_LIBS_USER","R_LIBRARY_DIR","R_LIBS","R_PACKAGE_DIR")
IncludeVars <- Sys.getenv()
IncludeVars <- IncludeVars[grep("^R_",names(IncludeVars),perl=TRUE)]
cat("const char *R_VARS[] = {\n")
for (i in 1:length(IncludeVars)){
    if (names(IncludeVars)[i] %in% ExcludeVars)
        next
    cat('"',names(IncludeVars)[i],'","',IncludeVars[i],'",\n',sep='')
}
cat("NULL };\n")
