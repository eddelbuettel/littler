# Littler FAQ

Dirk Eddelbuettel
Originally written 2019-03-23, updated 2020-06-16

### Well, why?

Glad you asked. When the initial work started, `Rscript` did not exist so
there was no scripting tool. We take a small amount of pride into beating
`Rscript` narrowly to a first release.  Of course, by now, `Rscript` is more
widely used as it ships with every R installation but we still have some
aspects we like about `r`: it is simpler and shorter, deals (in our biased)
view more sanely with command-line arguments via the `argv` vector, always
loaded package `methods` (which `Rscript` finally came around to a good
decade later) and [still starts
faster](http://dirk.eddelbuettel.com/blog/2014/09/02/#littler-faster-at-doing-nothing).
And `r` is just to cool a command (in relation to the trusted `R`) so someone
had to!

### No Printing

In the very beginning of `littler`, we made an executive decision to _not_
echo each command output when we evaluate commands in the read-evaluate-print
loop.  So `2+2` will be evaluated silently: four will be computed, but not shown.

That made sense for scripts we wanted to be silent. The idea is that user
will add a `print()` or `cat()` as needed.  If you desire each step to
printed, add a `-p` or `--verbose` argument.


### No `.Renviron`

Another early decision was to make `r` start _faster_ than the alternatives.
Our `r` is "just" a small little binary.  Whereas `R` and `Rscript` are
front-end shell scripts sourcing a number of things and setting them
dynamically, we determine values _at compilation time_ and freeze them into
the binary.  That may seem _risqué_ but worked out just fine.  However, while
we later added the ability to source `Rprofile` files (which contain R code
we can evaluate) there is no way for us to source the `Renviron` files _and
to modify the already running process_.  So if you want to source `Renviron`
you could add an explicit `readEnviron()` to `~/.littler.r` or
`/etc/littler/r`.

### Lower-case / upper-case

This is mostly an issue on macOS where the brain surgeons behind the OS
decided that `r` is the same as `R`. What can we say?  On that OS you may
need to rename the build to `lr` instead.  Please send your complaints to
Cupertino, California.

### Adding the binary to your path

When the package is installed from source, it displays

```
*
* new binary $(TGT) installed in bin/ subdirectory"
* consider adding a symbolic link from, e.g., /usr/local/bin"
* on OS X, you may have to name this 'lr' instead"
* see the littler-faq vignette for more details"
*
```

where the variable `$(TGT)` normally expands to `r`. As the text suggests you may
want to create a [symbolic link](https://en.wikipedia.org/wiki/Symbolic_link) from a
directory in the to make the newly built binary available to users.  On Linux you
may do

```
cd /usr/local/bin
sudo ln -s /usr/local/lib/R/site-library/littler/bin/r .
```

to create a link for `r` in `/usr/local/bin`.  On macOS, as suggested, you may want

```
cd /usr/local/bin
sudo ln -s /usr/local/lib/R/site-library/littler/bin/r lr
```

to create a command `lr` instead; see the previous question as to why.  In either case
adjust the source part of the `ln` command to where your binary is -- which R can tell
you via `system.file("bin", "r", package="littler")`.

Also note that _e.g._ the [zsh](https://zsh.sourceforge.io/) has a builtin
command `r` which may conflict, so using the explicit path of, say,
`/usr/bin/r` or `/usr/local/bin/r` or ... may provide an alternative.
