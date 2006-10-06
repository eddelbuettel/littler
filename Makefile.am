# Installed program name
bin_PROGRAMS=r

# List of files to include in distribution (e.g. make dist)
r_SOURCES=littler.c r.1 autoloads.R ldflags.R littler.R ANNOUNCEMENT tests/* examples/* svnversion.h

# These two together will tell make to create autoloads.h before
# any target.
nodist_r_SOURCES=autoloads.h ldflags.txt littler.h
BUILT_SOURCES=autoloads.h ldflags.txt littler.h

littler.h:
	R_HOME= ${RPROG} --silent --vanilla --slave < littler.R > littler.h

autoloads.h:
	R_HOME= ${RPROG} --silent --vanilla --slave < autoloads.R > autoloads.h

ldflags.txt:
	R_HOME= ${RPROG} --silent --vanilla --slave < ldflags.R > ldflags.txt

r$(EXEEXT): $(r_OBJECTS) $(r_DEPENDENCIES)
	@rm -f r$(EXEEXT)
	$(CCLD) $(AM_CFLAGS) $(CFLAGS) $(AM_LDFLAGS) `cat ldflags.txt` $(LDFLAGS) -o $@ $(r_LDFLAGS) $(r_OBJECTS) $(r_LDADD) $(LIBS)
	$(RUN_NAMETOOL)

#  Clean target to delete stuff make generates
MOSTLYCLEANFILES=autoloads.h ldflags.txt littler.o littler.h

#EXTRA_DIST=littler.texinfo

#  if you write a self-test script named `chk', uncomment the
#  following and add `chk' to the EXTRA_DIST list
#TESTS=chk

#  build and install the .info pages
#info_TEXINFOS = littler.texinfo
#r_TEXINFOS = gpl.texinfo

#  install the man page
man_MANS=r.1
