# Installed program name
bin_PROGRAMS=r

# List of files to include in distribution (e.g. make dist)
r_SOURCES=littler.c r.1 autoloads.R tests/*

# These two together will tell make to create autoloads.h before
# any target.
nodist_r_SOURCES=autoloads.h
BUILT_SOURCES=autoloads.h

autoloads.h:
	R_HOME= ${RPROG} --silent --vanilla --slave < autoloads.R > autoloads.h

#  Clean target to delete stuff make generates
MOSTLYCLEANFILES=autoloads.h

#  uncomment the following if littler requires the math library
#littler_LDADD=-lm

#EXTRA_DIST=littler.texinfo

#  if you write a self-test script named `chk', uncomment the
#  following and add `chk' to the EXTRA_DIST list
#TESTS=chk

#  build and install the .info pages
#info_TEXINFOS = littler.texinfo
#r_TEXINFOS = gpl.texinfo

#  install the man page
man_MANS=r.1
