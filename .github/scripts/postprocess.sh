#!/bin/sh

test -d docs || exit 0

sed -i -e's/Changes in littler version/Version/g' docs/NEWS/index.html

## Turns
##   txt <- r"{<a href="https://github.com/eddelbuettel/littler/pull/55">[#55](https://github.com/eddelbuettel/littler/issues/55)</a>).}"
## into
##     "<a href=\"https://github.com/eddelbuettel/littler/pull/55\">#55</a>)."
#Rscript -e 'writeLines(sub("\\[\\#(\\d+)\\]\\(https://github.com/eddelbuettel/littler/(issues|pull)/\\d+\\)", "#\\1", readLines("docs/NEWS/index.html")), "docs/NEWS/index.html")'

sed -i -e's/\[\(\#[0-9]\+\)\](https:\/\/github\.com\/eddelbuettel\/littler\/[a-z]\+\/[0-9]\+)/\1/g' docs/NEWS/index.html

## the two vignettes have a yaml header delineated by the standard '---'
## which becomes '<hr />' in the html -- so now we print first everything up
## to the first occurence, and then everything including the second occurence
## to the end, and then filter out that one occurrence
for src in littler-examples littler-faq; do
    file=$(mktemp)
    awk 'BEGIN{flag=0} /<hr \/>/{flag++}; flag<1' docs/vignettes/${src}/index.html > ${file}
    awk 'BEGIN{flag=0} /<hr \/>/{flag++}; flag>1' docs/vignettes/${src}/index.html >> ${file}
    awk '!/<hr \/>/' ${file} > docs/vignettes/${src}/index.html
done
