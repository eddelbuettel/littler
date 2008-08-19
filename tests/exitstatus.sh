#!/bin/bash

echo "Testing value of 'q(status=...)' exits:"
echo "q(status=123)" | ../r  
echo "  Got: $? via stdin"

echo "q(status=124)" | ../r -
echo "  Got: $? via file '-'"

../r -e "q(status=125)" 
echo "  Got: $? from 'r -e'"

tempfile=`tempfile`
echo "q(status=126)" > $tempfile
../r $tempfile
echo -n "  Got: $? from temp. file and "
rm -v $tempfile


echo "Testing value of final expression (i.e. '123') exits:"
echo "123" | ../r  
echo "  Got: $? via stdin"

echo "124" | ../r -
echo "  Got: $? via file '-'"

../r -e "125" 
echo "  Got: $? from 'r -e'"

tempfile=`tempfile`
echo "126" > $tempfile
../r $tempfile
echo -n "  Got: $? from temp. file and "
rm -v $tempfile
