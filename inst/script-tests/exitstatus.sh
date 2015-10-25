#!/bin/bash

echo "Testing value of 'q(status=...)' exits for r:"
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


echo "Testing value of 'q(status=...)' exits for Rscript:"
echo "q(status=123)" | Rscript -
echo "  Got: $? via stdin"

Rscript -e "q(status=124)" 
echo "  Got: $? from 'r -e'"

tempfile=`tempfile`
echo "q(status=125)" > $tempfile
Rscript $tempfile
echo -n "  Got: $? from temp. file and "
rm -v $tempfile
