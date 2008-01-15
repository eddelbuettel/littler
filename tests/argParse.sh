#!/bin/bash

## run this test from the build directory, ie above tests/
littler=./r

echo "Shebang 1"
$littler tests/shebang foo
echo "Shebang 2"
$littler tests/shebang foo bar
echo "Shebang 2, verbose"
$littler  --verbose tests/shebang foo bar

echo "Piping a file to r"
cat tests/test1.R | $littler
echo "Piping a file to r -"
cat tests/test1.R | $littler -

echo "Looking at what argv contains"
$littler -e 'print(argv)' -- -a -b
echo "Looking at what argv contains, piped"
echo 'print(argv)' | $littler - -- -a -b

echo ""
echo "Eval expr: cat('Hello, world\n')"
$littler -e "cat('Hello, world\n')"
echo "Eval expr: a=2;print(\"a^2\")"
$littler --verbose -e 'a<-2; cat(a^2,"\n")'

echo ""
echo "Jeffrey's Grand Test of Tukey summary() of /bin/ls output"
ls -l | awk '!/^total/ {print $5}' | $littler -e 'print(summary(as.integer(readLines())))'
