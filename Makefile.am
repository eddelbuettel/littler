bin_PROGRAMS=r
r_SOURCES=littler.c littler.1 autoloads.R system.h aclocal.m4
nodist_r_SOURCES=autoloads.h
BUILT_SOURCES=autoloads.h

autoloads.h:
	R_HOME= ${RPROG} --silent --vanilla --slave < autoloads.R > autoloads.h

#  Clean target to delete stuff make generates
MOSTLYCLEANFILES=autoloads.h

#  uncomment the following if littler requires the math library
#littler_LDADD=-lm

EXTRA_DIST=littler.texinfo

#  if you write a self-test script named `chk', uncomment the
#  following and add `chk' to the EXTRA_DIST list
#TESTS=chk

#  build and install the .info pages
info_TEXINFOS = littler.texinfo
r_TEXINFOS = gpl.texinfo

#  install the man pages
man_MANS=littler.1
