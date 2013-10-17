
s <- Sys.info()
if (is.null(s))
    q()

if (s[1] == "Linux") {
    ldp <- strsplit(Sys.getenv('LD_LIBRARY_PATH'),':')[[1]]
    ldp <- ldp[which(ldp != "")]
    cat(paste('-Wl,-rpath,',ldp,sep=''),"\n",sep=' ')
}
