# Makefile.am for littler

# Installed program name
bin_PROGRAMS=r

# List of files to include in distribution (e.g. make dist)
r_SOURCES=littler.c r.1 autoloads.R ldflags.R littler.R ANNOUNCEMENT \
			tests/* examples/* svnversion.h

# These two together will tell make to create autoloads.h before any target.
nodist_r_SOURCES=autoloads.h ldflags.txt littler.h
BUILT_SOURCES=autoloads.h ldflags.txt littler.h

ROPTIONS=--silent --vanilla --slave

littler.h: littler.R
	R_HOME= ${RPROG} ${ROPTIONS} < $< > $@

autoloads.h: autoloads.R
	R_HOME= ${RPROG} ${ROPTIONS} < $< > $@

ldflags.txt: ldflags.R
	R_HOME= ${RPROG} ${ROPTIONS} < $< > $@

svnversion.h: bootstrap
	./bootstrap --svnversion

r$(EXEEXT): $(r_OBJECTS) $(r_DEPENDENCIES)
	@rm -f r$(EXEEXT)
	$(CCLD) $(AM_CFLAGS) $(CFLAGS) $(AM_LDFLAGS) \
		`cat ldflags.txt` $(LDFLAGS) \
		-o $@ $(r_LDFLAGS) $(r_OBJECTS) $(r_LDADD) $(LIBS)
	$(RUN_NAMETOOL)

#  Clean target to delete stuff make generates
MOSTLYCLEANFILES=autoloads.h ldflags.txt littler.o littler.h

# Ensure that svnversion.h is regenerated on 'make dist'
EXTRA_DIST=svnversion.h

#  install the man page
man_MANS=r.1

.PHONY: littler.h autoloads.h ldflags.txt 
