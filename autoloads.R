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
