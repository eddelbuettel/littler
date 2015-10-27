library(littler)
stopifnot(identical("42", littler:::test("cat(40 + 2)")))
