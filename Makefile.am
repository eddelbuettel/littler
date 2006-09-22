# Installed program name
bin_PROGRAMS=r

# List of files to include in distribution (e.g. make dist)
r_SOURCES=littler.c r.1 autoloads.R ANNOUNCEMENT tests/* examples/* 

# These two together will tell make to create autoloads.h before
# any target.
nodist_r_SOURCES=autoloads.h
BUILT_SOURCES=autoloads.h

autoloads.h:
	R_HOME= ${RPROG} --silent --vanilla --slave < autoloads.R > autoloads.h

r$(EXEEXT): $(r_OBJECTS) $(r_DEPENDENCIES)
	@rm -f r$(EXEEXT)
	$(LINK) $(r_LDFLAGS) $(r_OBJECTS) $(r_LDADD) $(LIBS)
	$(RUN_NAMETOOL)

#  Clean target to delete stuff make generates
MOSTLYCLEANFILES=autoloads.h littler.o

#EXTRA_DIST=littler.texinfo

#  if you write a self-test script named `chk', uncomment the
#  following and add `chk' to the EXTRA_DIST list
#TESTS=chk

#  build and install the .info pages
#info_TEXINFOS = littler.texinfo
#r_TEXINFOS = gpl.texinfo

#  install the man page
man_MANS=r.1
