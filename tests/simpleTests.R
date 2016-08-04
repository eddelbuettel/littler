library(littler)
stopifnot(identical(littler:::test(), "4"))   # default test is cat(2+2)
stopifnot(as.numeric(littler:::test('cat(R.version$year)')) >= 2015)  
