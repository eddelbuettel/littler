s <- Sys.info()

if (is.null(s)) q()

if (s[1] == "Linux")
	cat(paste('-Wl,-rpath,',strsplit(Sys.getenv('LD_LIBRARY_PATH'),':')$LD_LIBRARY_PATH,sep=''),"\n",sep=' ')
