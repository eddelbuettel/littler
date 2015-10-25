ExcludeVars <- c("R_SESSION_TMPDIR","R_HISTFILE","R_LIBS_USER")
IncludeVars <- Sys.getenv()
IncludeVars <- IncludeVars[grep("^R_",names(IncludeVars),perl=TRUE)]
cat("const char *R_VARS[] = {\n")
for (i in 1:length(IncludeVars)){
	if (names(IncludeVars)[i] %in% ExcludeVars)
		next
	cat('"',names(IncludeVars)[i],'","',IncludeVars[i],'",\n',sep='')
}
cat("NULL };\n")
