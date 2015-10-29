#!/usr/bin/env r

# This should dynamically load stats
cat("Is stats loaded?\n");

cat("search: ",search(),"\n");
if(!("package:stats" %in% search())){
	cat("Nope!\n");
}

cat("Calling ts(1:10)\n");

cat(ts(1:10),"\n");

cat("Now stats is loaded!\n");
cat("search: ",search(),"\n");


if(!("package:utils" %in% search())){
	cat("No utils!\n");
	cat("Calling timestamp()\n");
	cat(timestamp(),"\n");
	cat("search: ",search(),"\n");
}
