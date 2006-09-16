#!/bin/bash


echo "Shebang 1"
./r tests/shebang foo
echo "Shebang 2"
./r tests/shebang foo bar
echo "Shebang 2, verbose"
./r  --verbose tests/shebang foo bar

echo "Piping a file to r"
cat tests/test1.R | ./r
echo "Piping a file to r -"
cat tests/test1.R | ./r -


echo ""
echo "Eval expr: cat('Hello, world\n')"
./r -e "cat('Hello, world\n')"
echo "Eval expr: a=2;print(\"a^2\")"
./r --verbose -e 'a<-2; cat(a^2,"\n")'

echo ""
echo "Jeffrey's Grand Test of Tukey summary() of /bin/ls output"
ls -l | awk '!/^total/ {print $5}' | ./r -e 'print(summary(as.integer(readLines())))'
