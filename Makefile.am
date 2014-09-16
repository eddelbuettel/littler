# Makefile.am for littler
#
# Copyright (C) 2006 - 2014  Jeffrey Horner and Dirk Eddelbuettel, GNU GPL'ed

# Installed program name
bin_PROGRAMS = r$(EXEEXT)

all-am: r$(EXEEXT) littler.h autoloads.h ldflags.txt

# List of files to include in distribution (e.g. make dist)
r_SOURCES = littler.c r.1 autoloads.R ldflags.R littler.R ANNOUNCEMENT \
			configure configure.ac tests/* examples/* gitversion.h bootstrap 


# These two together will tell make to create autoloads.h before any target.
nodist_r_SOURCES = autoloads.h ldflags.txt littler.h gitversion.h
BUILT_SOURCES = autoloads.h ldflags.txt littler.h gitversion.h

ROPTIONS = --silent --vanilla --slave

CFLAGS = -O3 -pipe 

# The next three rules could be written more compactly as '... < $< > $@'
# using the GNU make 'extention variables' $< and $@, but as this may get
# executed under a non-GNU make on *BSD, we expand explicitly.
littler.h: littler.R
	R_HOME= ${RPROG} ${ROPTIONS} < littler.R > littler.h

# NOT .PHONY: autoloads.h 
autoloads.h: autoloads.R
	R_HOME= ${RPROG} ${ROPTIONS} < autoloads.R > autoloads.h

# NOT .PHONY: ldflags.txt
ldflags.txt: ldflags.R
	R_HOME= ${RPROG} ${ROPTIONS} < ldflags.R > ldflags.txt

# Always create a fresh gitversion -- but .PHONY used here creates a loop                                           |  
# NOT .PHONY: gitversion.h                                                       
gitversion.h: 
	./bootstrap --gitversion

# Use rldflags.txt created by ldflags.R above 
# using $(shell ...) may make it dependent on GNU make, so use 'gmake' if need be
rldflags = $(shell cat ldflags.txt)

# Main r build rule, with suitable extension where needed (as eg on OS X)
r$(EXEEXT): $(r_OBJECTS) $(r_DEPENDENCIES) gitversion.h
	@rm -f r$(EXEEXT)
	$(CCLD) $(AM_CFLAGS) $(CFLAGS) $(r_OBJECTS) $(AM_LDFLAGS) \
		$(rldflags) $(LDFLAGS) \
		-o $@ $(r_LDFLAGS) $(r_LDADD) $(LIBS)
	$(RUN_NAMETOOL)

#  Clean target to delete stuff make generates
MOSTLYCLEANFILES = autoloads.h ldflags.txt littler.o littler.h 

# Ensure that gitversion.h is regenerated on 'make dist'
EXTRA_DIST = gitversion.h

#  install the man page
man_MANS = r.1

