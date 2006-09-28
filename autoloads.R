dp <- getOption("defaultPackages")
dp <- dp[dp != 'datasets']

# Count of default packages
cat("int packc = ",length(dp),";\n",sep='')

# List of packages
cat("char *pack[] = {\n",paste('"',dp,'"',sep='',collapse=",\n"),"\n};\n")

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
cat("char *packobj[] = {\n",paste('"',packobj,'"',sep='',collapse=",\n"),"\n};\n")

# ALSO: fix LD_LIBRARY_PATH as this will get everything in ${R_HOME}/etc/ldpaths

cat('char *R_LD_LIBRARY_PATH = "',Sys.getenv("LD_LIBRARY_PATH"),'";\n',sep='')
