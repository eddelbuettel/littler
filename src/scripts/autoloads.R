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

dp <- getOption("defaultPackages")
#dp <- dp[dp != 'datasets'] ## Rscript loads it too
#dp <- dp[dp != 'methods']  ## Rscript (in R 2.6.1) doesn't load methods either

# Count of default packages
cat("int packc = ",length(dp),";\n",sep='')

# List of packages
cat("const char *pack[] = {\n",paste('"',dp,'"',sep='',collapse=",\n"),"\n};\n")

packobjc <- array(0,dim=length(dp))
packobj <- NULL
for (i in 1:length(dp)){
    obj = ls(paste("package:",dp[i],sep=''))
    packobjc[i] = length(obj)
    packobj = c(packobj,obj)
}

# List of counts of objects per package
cat("int packobjc[] = {\n",paste(packobjc,sep='',collapse=",\n"),"\n};\n")

# List of object names
cat("const char *packobj[] = {\n",paste('"',packobj,'"',sep='',collapse=",\n"),"\n};\n")
