#!/bin/bash


echo "Shebang 1"
./r -n tests/shebang foo
echo "Shebang 2"
./r -n tests/shebang foo bar
echo "Shebang 2, verbose"
./r -n --verbose tests/shebang foo bar
#echo "Shebang 2, verbose, with debug output"
#./r --verbose tests/shebang foo bar


echo ""
echo "Eval expr: cat('Hello, world\n')"
## this currently needs a file to not wait for stdin
./r -n -e "cat('Hello, world\n')" /dev/null 
echo "Eval expr: a=2, and pipe print(\"a^2\") into r"
## this currently needs a file to not wait for stdin
echo 'print(a^2)' |  ./r --verbose -n -e "a<-2" 


echo ""
echo "Jeffrey's Grand Test of Tukey summary() of /bin/ls output"
ls -l | awk '!/^total/ {print $5}' | ./r -e 'print(summary(as.integer(readLines())))' -

echo "That worked, but why do we get the awk output even if --slave is set?"
echo "It works silently if we set --vanilla too"
ls -l | awk '!/^total/ {print $5}' | ./r -v -e 'print(summary(as.integer(readLines())))' -
