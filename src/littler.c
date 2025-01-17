/*
 *  littler - Provides hash-bang (#!) capability for R (www.r-project.org)
 *
 *  Copyright (C) 2006 - 2024  Jeffrey Horner and Dirk Eddelbuettel
 *
 *  littler is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

#include <getopt.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdint.h>

#include "config.h"
/*#include "config-const.h"*/
#include "gitversion.h"
#include "autoloads.h"
#include "littler.h"

#include <R.h>
#include <Rembedded.h>
#include <Rversion.h>
#include <Rdefines.h>
#define R_INTERFACE_PTRS
#include <Rinterface.h>
#include <R_ext/Parse.h>
#include <R_ext/RStartup.h>

int verbose = 0;                	/* should we be verbose? default no, use -p */

/* PACKAGE, VERSION, ... are being filled by autoconf and friends via config.h */
const char *programName = PACKAGE_NAME;
const char *binaryName = "r";

#ifndef HAVE_SETENV
int  setenv(char *name, char *value, int clobber){
    char   *cp;

    if (clobber == 0 && getenv(name) != 0)
        return (0);
    if ((cp = malloc(strlen(name) + strlen(value) + 2)) == 0)
        return (1);
    sprintf(cp, "%s=%s", name, value);
    return (putenv(cp));
}
#endif

int source(char *file){
    SEXP expr, s, f, p;
    int errorOccurred;

    /* Find source function */
    s = Rf_findFun(Rf_install("source"), R_GlobalEnv);
    PROTECT(s);

    /* Make file argument */
    PROTECT(f = NEW_CHARACTER(1));
    SET_STRING_ELT(f, 0, COPY_TO_USER_STRING(file));

    /* Make print.eval argument */
    PROTECT(p = NEW_LOGICAL(1));
    LOGICAL_DATA(p)[0] = (verbose)? TRUE : FALSE;

    /* expression source(f,print.eval=p) */
    PROTECT(expr = allocVector(LANGSXP,3));
    SETCAR(expr,s);
    SETCAR(CDR(expr),f);
    SETCAR(CDR(CDR(expr)), p);
    SET_TAG(CDR(CDR(expr)), Rf_install("print.eval"));

    errorOccurred=0;
    R_tryEval(expr,NULL,&errorOccurred);
    UNPROTECT(4);

    return errorOccurred;
}

/* Autoload default packages and names from autoloads.h
 *
 * This function behaves in almost every way like
 * R's autoload:
 * function (name, package, reset = FALSE, ...)
 * {
 *     if (!reset && exists(name, envir = .GlobalEnv, inherits = FALSE))
 *        stop("an object with that name already exists")
 *     m <- match.call()
 *     m[[1]] <- as.name("list")
 *     newcall <- eval(m, parent.frame())
 *     newcall <- as.call(c(as.name("autoloader"), newcall))
 *     newcall$reset <- NULL
 *     if (is.na(match(package, .Autoloaded)))
 *        assign(".Autoloaded", c(package, .Autoloaded), env = .AutoloadEnv)
 *     do.call("delayedAssign", list(name, newcall, .GlobalEnv,
 *                                                         .AutoloadEnv))
 *     invisible()
 * }
 *
 * What's missing is the updating of the string vector .Autoloaded with the list
 * of packages, which by my code analysis is useless and only for informational
 * purposes.
 *
 */
void autoloads(void){
    SEXP da, dacall, al, alcall, AutoloadEnv, name, package;
    int i,j, idx=0, errorOccurred, ptct;

    /* delayedAssign call*/
    PROTECT(da = Rf_findFun(Rf_install("delayedAssign"), R_GlobalEnv));
    PROTECT(AutoloadEnv = Rf_findVar(Rf_install(".AutoloadEnv"), R_GlobalEnv));
    if (AutoloadEnv == R_NilValue){
        fprintf(stderr,"%s: Cannot find .AutoloadEnv!\n", programName);
        exit(1);
    }
    PROTECT(dacall = allocVector(LANGSXP,5));
    SETCAR(dacall,da);
    /* SETCAR(CDR(dacall),name); */          /* arg1: assigned in loop */
    /* SETCAR(CDR(CDR(dacall)),alcall); */  /* arg2: assigned in loop */
    SETCAR(CDR(CDR(CDR(dacall))),R_GlobalEnv); /* arg3 */
    SETCAR(CDR(CDR(CDR(CDR(dacall)))),AutoloadEnv); /* arg3 */


    /* autoloader call */
    PROTECT(al = Rf_findFun(Rf_install("autoloader"), R_GlobalEnv));
    PROTECT(alcall = allocVector(LANGSXP,3));
    SET_TAG(alcall, R_NilValue); /* just like do_ascall() does */
    SETCAR(alcall,al);
    /* SETCAR(CDR(alcall),name); */          /* arg1: assigned in loop */
    /* SETCAR(CDR(CDR(alcall)),package); */  /* arg2: assigned in loop */

    ptct = 5;
    for(i = 0; i < packc; i++){
        idx += (i != 0)? packobjc[i-1] : 0;
        for (j = 0; j < packobjc[i]; j++){
            /*printf("autload(%s,%s)\n",packobj[idx+j],pack[i]);*/

            PROTECT(name = NEW_CHARACTER(1));
            PROTECT(package = NEW_CHARACTER(1));
            SET_STRING_ELT(name, 0, COPY_TO_USER_STRING(packobj[idx+j]));
            SET_STRING_ELT(package, 0, COPY_TO_USER_STRING(pack[i]));

            /* Set up autoloader call */
            PROTECT(alcall = allocVector(LANGSXP,3));
            SET_TAG(alcall, R_NilValue); /* just like do_ascall() does */
            SETCAR(alcall,al);
            SETCAR(CDR(alcall),name);
            SETCAR(CDR(CDR(alcall)),package);

            /* Setup delayedAssign call */
            SETCAR(CDR(dacall),name);
            SETCAR(CDR(CDR(dacall)),alcall);

            R_tryEval(dacall,R_GlobalEnv,&errorOccurred);
            if (errorOccurred){
                fprintf(stderr,"%s: Error calling delayedAssign!\n", programName);
                exit(1);
            }

            ptct += 3;
        }
    }
    UNPROTECT(ptct);
}

/* Line reading code */
typedef struct membuf_st {
    int size;
    int count;
    unsigned char *buf;
} *membuf_t;

membuf_t init_membuf(int sizebytes){
    membuf_t lb = malloc(sizebytes+sizeof(struct membuf_st));

    if (lb == NULL) {
        fprintf(stderr,"%s: init_membuf() failed! Exiting!!!\n\n", programName);
        exit(1);
        return NULL; /* unreached */
    }

    lb->size = sizebytes;
    lb->count = 0;
    lb->buf = (unsigned char *)lb+sizeof(struct membuf_st);

    return lb;
}

void destroy_membuf(membuf_t lb){
    free(lb);
}

/* Use power of 2 resizing */
membuf_t resize_membuf(membuf_t *plb){
    membuf_t lb = *plb;
    lb = *plb = realloc(lb,lb->size*2+sizeof(struct membuf_st));
    if (lb == NULL) {
        fprintf(stderr,"%s: init_membuf() failed! Exiting!!!\n\n", programName);
        exit(1);
        return NULL; /* unreached */
    }

    lb->size =  lb->size * 2;
    lb->buf = (unsigned char *)lb+sizeof(struct membuf_st);

    return lb;
}

membuf_t rewind_membuf(membuf_t *mb){
    (*mb)->count = 0;
    return *mb;
}

membuf_t add_to_membuf(membuf_t *pmb,char *buf){
    membuf_t mb = *pmb;
    int buflen = strlen(buf);

    while ((buflen + (mb->count)) >= mb->size){
        mb = *pmb = resize_membuf(pmb);
    }

    memcpy(mb->buf+mb->count,buf,buflen);
    mb->buf[mb->count+buflen] = '\0';
    mb->count += buflen;

    return mb;
}


/* returns 1 on reading another line or until EOF, 0 on EOF */
int readline_stdin(membuf_t *plb){
    membuf_t lb = *plb;
    unsigned int offset=0;
    char *str;

    do {
        lb->buf[lb->size-2] = '\0'; /* mark last char position */
        str = fgets((char*)lb->buf+offset,lb->size-offset,stdin);

        /* EOF or error */
        if (str == NULL){
            return (offset)? 1 : 0;
        }

        /* Did we read a whole line? */
        if (lb->buf[lb->size-2] != '\0' && lb->buf[lb->size-2] != '\n'){
            /* No. read again. */
            offset = lb->size-1;
            lb = *plb = resize_membuf(plb);
        } else {
            /* Yes. return */
            return 1;
        }
    } while(1);
}

int parse_eval(membuf_t *pmb, char *line, int lineno, int localverbose){
    membuf_t mb = *pmb;
    ParseStatus status;
    SEXP cmdSexp, cmdexpr, ans = R_NilValue;
    int i, errorOccurred;

    mb = *pmb = add_to_membuf(pmb,line);

    PROTECT(cmdSexp = allocVector(STRSXP, 1));
    SET_STRING_ELT(cmdSexp, 0, mkChar((char*)mb->buf));

    /* R_ParseVector gets a new argument in R 2.5.x */
    cmdexpr = PROTECT(R_ParseVector(cmdSexp, -1, &status, R_NilValue));

    switch (status){
    case PARSE_OK:
        /* Loop is needed here as EXPSEXP might be of length > 1 */
        for(i = 0; i < length(cmdexpr); i++){
            ans = R_tryEval(VECTOR_ELT(cmdexpr, i),NULL, &errorOccurred);
            if (errorOccurred) {
                UNPROTECT(2);
                return 1;
            }
            if (localverbose) {
                PrintValue(ans);
            }
        }
        mb = *pmb = rewind_membuf(pmb);
        break;
    case PARSE_INCOMPLETE:
        fprintf(stderr, "%s: Incomplete Line! Need more code! (%d)\n", programName, status);
        UNPROTECT(2);
        return 1;
        break;
    case PARSE_NULL:
        fprintf(stderr, "%s: ParseStatus is null (%d)\n", programName, status);
        UNPROTECT(2);
        return 1;
        break;
    case PARSE_ERROR:
        fprintf(stderr,"Parse Error line %d: \"%s\"\n", lineno, line);
        UNPROTECT(2);
        return 1;
        break;
    case PARSE_EOF:
        fprintf(stderr, "%s: EOF reached (%d)\n", programName, status);
        break;
    default:
        fprintf(stderr, "%s: ParseStatus is not documented %d\n", programName, status);
        UNPROTECT(2);
        return 1;
        break;
    }
    UNPROTECT(2);
    return 0;
}

extern char *R_TempDir;
int perSessionTempDir = FALSE;	/* by default, r differs from R and defaults to /tmp unless env.vars set, or flag chosen */

void littler_InitTempDir(void) {
    char *tmp;

    if (perSessionTempDir) return; 	/* use a per-session temporary directory by following R */

    tmp = getenv("TMPDIR");		/* set tmp to TMPDIR, or TMP, or TEMP, or "/tmp" */
    if (tmp == NULL) {
        tmp = getenv("TMP");
        if (tmp == NULL) {
            tmp = getenv("TEMP");
            if (tmp == NULL)
                tmp = "/tmp";
        }
    }

    R_TempDir=tmp;

    if (setenv("R_SESSION_TMPDIR",tmp,1) != 0){
        perror("Fatal Error: couldn't set/replace R_SESSION_TMPDIR!");
        exit(1);
    }
}

/* littler exit */
void littler_CleanUp(SA_TYPE saveact, int status, int runLast){
    R_dot_Last();
    R_RunExitFinalizers();
    if (perSessionTempDir) R_CleanTempDir();
    fpu_setup(FALSE);
    Rf_endEmbeddedR(0);
    exit(status);
}

void showHelpAndExit(void) {
    printf("\n"
           "Usage: %s [options] [-|file]"
           "\n\n"
           "Launch GNU R to execute the R commands supplied in the specified file, or\n"
           "from stdin if '-' is used. Suitable for so-called shebang '#!/'-line scripts.\n"
           "\n"
           "Options:\n"
           "  -h, --help           Give this help list\n"
           "      --usage          Give a short usage message\n"
           "  -V, --version        Show the version number\n"
           "  -v, --vanilla        Pass the '--vanilla' option to R\n"
           "  -t, --rtemp          Use per-session temporary directory as R does\n"
           "  -i, --interactive    Let interactive() return 'true' rather than 'false'\n"
           "  -q, --quick          Skip autoload / delayed assign of default libraries\n"
           "  -p, --verbose        Print the value of expressions to the console\n"
           "  -l, --packages list  Load the R packages from the comma-separated 'list'\n"
           "  -d, --datastdin      Prepend command to load 'X' as csv from stdin\n"
           "  -L, --libpath dir    Add directory to library path via '.libPaths(dir)'\n"
           "  -e, --eval expr      Let R evaluate 'expr'\n"
           "\n\n",
           binaryName);
    exit(-1);
}

void showVersionAndExit(void) {
    char txt[64];
    printf("%s ('%s') version %s\n", binaryName, programName, PACKAGE_VERSION);
#if defined(VERBOSE_BUILD)
    printf("\ngit revision %s as of %s\n", gitrevision, gitdate);
    printf("built at %s on %s\n", compiletime, compiledate);
#endif
    printf("\nusing GNU R ");
    snprintf(txt, 63, "%d", R_SVN_REVISION);
    if (strcmp(txt, "unknown")==0) {
        printf("Version %s.%s %s (%s-%s-%s)",
               R_MAJOR, R_MINOR, R_STATUS, R_YEAR, R_MONTH, R_DAY);
    } else {
        if (strlen(R_STATUS)==0) {
            printf("Version %s.%s (%s-%s-%s)",
                   R_MAJOR, R_MINOR, R_YEAR, R_MONTH, R_DAY);
        }
        else{
            printf("Version %s.%s %s (%s-%s-%s r%d)",
                   R_MAJOR, R_MINOR, R_STATUS, R_YEAR, R_MONTH, R_DAY,
                   R_SVN_REVISION);
        }
    }
    printf("\n\nCopyright (C) 2006 - 2021  Jeffrey Horner and Dirk Eddelbuettel\n"
           "\n"
           "%s is free software and comes with ABSOLUTELY NO WARRANTY.\n"
           "You are welcome to redistribute it under the terms of the\n"
           "GNU General Public License.  For more information about\n"
           "these matters, see http://www.gnu.org/copyleft/gpl.html.\n\n",
           binaryName);
    exit(0);
}

void showUsageAndExit(void) {
    printf("\n"
           "%s (aka '%s') can be used in four main modes.\n\n"
           "The first is via the so-called 'shebang' support it provides for GNU R.\n"
           "Suppose '%s' is installed in /usr/local/bin/%s. Then the first line of a\n"
           "script can be written as \"#!/usr/local/bin/%s\" and the rest of the file\n"
           "can contain standard R commands.  By setting executable permissions\n"
           "on the file, one can now create executable R scripts.\n\n"
           "The second is to supply a filename with commands that are to be\n"
           "evaluated.\n\n"
           "The third use is in standard compound command-line expressions common\n"
           "under Unix (so called 'command pipes') as '%s' can take arguments\n"
           "from stdin if the special filename '-' is used to select stdin.\n\n"
           "The fourth use is in on-the-fly evaluation of R expressions supplied\n"
           "via the -e or --eval options to provide a quick R expression tester\n"
           "and calculator.\n\n"
           "You can provide configuration via file ${R_HOME}/etc/Rprofile.site,\n"
           "~/.Rprofile, /etc/littler.r or ~/.littler.r all of which are sourced\n"
           "if present.\n\n"
           "More documentation is provided in the '%s' manual page and via the\n"
           "tests directory in the sources.\n\n"
           "A number of examples are also available at\n"
           "http://dirk.eddelbuettel.com/code/littler.examples.html.\n\n",
           binaryName, programName, binaryName, binaryName, binaryName,
           programName, binaryName);
    exit(0);
}

/* set seed for tempfile()
   updated to R 4.1.0 src/main/times.c and its helper function TimeToSeed() */
void init_rand(void) {
    unsigned int seed, pid = getpid();
#if defined(HAVE_CLOCK_GETTIME) && defined(CLOCK_REALTIME)
    {
        struct timespec tp;
        clock_gettime(CLOCK_REALTIME, &tp);
        seed = (unsigned int)(((uint_least64_t) tp.tv_nsec << 16) ^ tp.tv_sec);
    }
#elif defined(HAVE_GETTIMEOFDAY)
    {
        struct timeval tv;
        gettimeofday (&tv, NULL);
        seed = (unsigned int)(((uint_least64_t) tv.tv_usec << 16) ^ tv.tv_sec);
    }
#else
    /* C89, so must work */
    seed = (Int32) time(NULL);
#endif
    seed ^= (pid <<16);

    srand(seed);                /* also called by R in src/main/main.c */
}

int main(int argc, char **argv){

    /* R embedded arguments, and optional arguments to be picked via cmdline switches */
    char *R_argv[] = {(char*)programName, "--gui=none", "--no-restore", "--no-save", "--no-readline", "--silent", "", ""};
    char *R_argv_opt[] = {"--vanilla", "--slave"};
    int R_argc = (sizeof(R_argv) - sizeof(R_argv_opt) ) / sizeof(R_argv[0]);
    int i, nargv, c, optpos=0, vanilla=0, quick=0, interactive=0, datastdin=0;
    char *evalstr = NULL;
    char *libstr = NULL;
    char *libpathstr = NULL;
    SEXP s_argv;
    structRstart Rst;
    char *datastdincmd = "X <- read.csv(file(\"stdin\"), stringsAsFactors=FALSE);";

    static struct option optargs[] = {
        {"help",         no_argument,       NULL, 'h'},
        {"usage",        no_argument,       0,    0},
        {"version",      no_argument,       NULL, 'V'},
        {"vanilla",      no_argument,       NULL, 'v'},
        {"eval",         required_argument, NULL, 'e'},
        {"packages",     required_argument, NULL, 'l'},
        {"verbose",      no_argument,       NULL, 'p'},
        {"rtemp",        no_argument,       NULL, 't'},
        {"quick",        no_argument,       NULL, 'q'},
        {"interactive",  no_argument,       NULL, 'i'},
        {"datastdin",    no_argument,       NULL, 'd'},
        {"libpath",      required_argument, NULL, 'L'},
        {0, 0, 0, 0}
    };
    while ((c = getopt_long(argc, argv, "+hVve:npl:L:tqid", optargs, &optpos)) != -1) {
        switch (c) {
        case 0:				/* numeric 0 is code for a long option */
            /* printf ("Got option %s %d", optargs[optpos].name, optpos);*/
            switch (optpos) {		/* so switch on the position in the optargs struct */
					/* cases 0, 2, and 3 can't happen as they are covered by the '-h', */
					/* '-V', and '-v' equivalences */
            case 1:
                showUsageAndExit();
                break;				/* never reached */
            case 5:
                verbose = 1;
                break;
            default:
                printf("Uncovered option position '%d'. Try `%s --help' for help\n",
                       optpos, programName);
                exit(-1);
            }
            break;
        case 'h':			/* -h is the sole short option, cf getopt_long() call */
            showHelpAndExit();
            break;  			/* never reached */
        case 'e':
            evalstr = optarg;
            break;
        case 'l':
            libstr = optarg;
            break;
        case 'v':
            vanilla=1;
            break;
        case 'p':
            verbose=1;
            break;
        case 'V':
            showVersionAndExit();
            break;  			/* never reached */
        case 't':
            perSessionTempDir=TRUE;
            break;
        case 'q':
            quick=1;
            break;
        case 'i':
            interactive=1;
            break;
        case 'd':
            datastdin=1;
            break;
        case 'L':
            libpathstr = optarg;
            break;
        default:
            printf("Unknown option '%c'. Try `%s --help' for help\n",(char)c, programName);
            exit(-1);
        }
    }
    if (vanilla) {
        R_argv[R_argc++] = R_argv_opt[0];
    }
    if (!verbose) {
        R_argv[R_argc++] = R_argv_opt[1];
    }

#ifdef DEBUG
    printf("R_argc %d sizeof(R_argv) \n", R_argc, sizeof(R_argv));
    for (i=0; i<7; i++) {
        printf("R_argv[%d] = %s\n", i, R_argv[i]);
    }
    printf("optind %d, argc %d\n", optind, argc);
    for (i=0; i<argc; i++) {
        printf("argv[%d] = %s\n", i, argv[i]);
    }
#endif

    /* Now, argv[optind] could be a file we want to source -- if we're
     * in the 'shebang' case -- or it could be an expression from stdin.
     * So call stat(1) on it, and if its a file we will treat it as such.
     */
    struct stat sbuf;
    if (optind < argc && evalstr==NULL) {
        if ((strcmp(argv[optind],"-") != 0) && (stat(argv[optind],&sbuf) != 0)) {
            perror(argv[optind]);
            exit(1);
        }
    }

    /* Setenv R_* env vars: insert or replace into environment.  */
    for (i = 0; R_VARS[i] != NULL; i+= 2){
        if (setenv(R_VARS[i],R_VARS[i+1],1) != 0){
            perror("ERROR: couldn't set/replace an R environment variable");
            exit(1);
        }
    }

    /* We don't require() default packages upon startup; rather, we
     * set up delayedAssign's instead. see autoloads().
     */
    if (setenv("R_DEFAULT_PACKAGES","NULL",1) != 0) {
        perror("ERROR: couldn't set/replace R_DEFAULT_PACKAGES");
        exit(1);
    }

    R_SignalHandlers = 0;			/* Don't let R set up its own signal handlers */

#ifdef CSTACK_DEFNS
    R_CStackLimit = (uintptr_t)-1;		/* Don't do any stack checking, see R Exts, '8.1.5 Threading issues' */
#endif

    littler_InitTempDir();			/* Set up temporary directoy */

    Rf_initEmbeddedR(R_argc, R_argv);	/* Initialize the embedded R interpreter */

    R_ReplDLLinit(); 			/* this is to populate the repl console buffers */

    if (!interactive) {			/* new in littler 0.1.3 */
        R_DefParams(&Rst);
        Rst.R_Interactive = 0;	/* sets interactive() to eval to false */
        R_SetParams(&Rst);
    }

    ptr_R_CleanUp = littler_CleanUp; 	/* R Exts, '8.1.2 Setting R callbacks */

    if (quick != 1) {			/* Unless user chose not to load libraries */
        autoloads();			/* Force all default package to be dynamically required */
    }

    /* Place any argv arguments into argv vector in Global Environment */
    /* if we have an evalstr supplied from -e|--eval, correct for it */
    if ((argc - optind - (evalstr==NULL)) >= 1) {
        int offset = (evalstr==NULL) + (strcmp(argv[optind],"-") == 0);
        /* Build string vector */
        nargv = argc - optind - offset;
        PROTECT(s_argv = allocVector(STRSXP,nargv));
        for (i = 0; i <nargv; i++){
            STRING_PTR(s_argv)[i] = mkChar(argv[i+offset+optind]);
#ifdef DEBUG
            printf("Passing %s to R\n", argv[i+offset+optind]);
#endif
        }
        UNPROTECT(1);
        setVar(install("argv"),s_argv,R_GlobalEnv);
    } else {
        setVar(install("argv"),R_NilValue,R_GlobalEnv);
    }

    init_rand();				/* for tempfile() to work correctly */

    if (!vanilla) {
        FILE *fp;

        char rprofilesite[128];
        snprintf(rprofilesite, 110, "%s/etc/Rprofile.site", getenv("R_HOME"));
        if ((fp = fopen(rprofilesite, "r")) != 0) {
            fclose(fp);             		/* don't actually need it */
#ifdef DEBUG
            printf("Sourcing %s\n", rprofilesite);
#endif
            source(rprofilesite);
        }

        char dotrprofile[128];
        snprintf(dotrprofile, 110, "%s/.Rprofile", getenv("HOME"));
        if ((fp = fopen(dotrprofile, "r")) != 0) {
            fclose(fp);             		/* don't actually need it */
#ifdef DEBUG
            printf("Sourcing %s\n", dotrprofile);
#endif
            source(dotrprofile);
        }

        char *etclittler = "/etc/littler.r";	/* load /etc/litter.r if it exists */
        if ((fp = fopen(etclittler, "r")) != 0) {
            fclose(fp);        			/* don't actually need it */
#ifdef DEBUG
            printf("Sourcing %s\n", etclittler);
#endif
            source(etclittler);
        }

        char dotlittler[128];			/* load ~/.litter.r if it exists */
        snprintf(dotlittler, 110, "%s/.littler.r", getenv("HOME"));
        if ((fp = fopen(dotlittler, "r")) != 0) {
            fclose(fp);             		/* don't actually need it */
#ifdef DEBUG
            printf("Sourcing %s\n", dotlittler);
#endif
            source(dotlittler);
        }

        littler_InitTempDir();		/* Re-set up temporary directoy possibly reflecting user vars */

    }


    if (libpathstr != NULL) {		/* if requested by user, set libPaths */
        char buf[128];
        membuf_t pb = init_membuf(512);
        snprintf(buf, 127 - 12 - strlen(libpathstr), ".libPaths(\"%s\");", libpathstr);
        parse_eval(&pb, buf, 1, 0); 		/* evaluate this silently */
        destroy_membuf(pb);
    }

    if (libstr != NULL) {			/* if requested by user, load libraries */
        char *ptr, *token, *strptr;
        char buf[128];

        ptr = token = libstr;
        membuf_t pb = init_membuf(512);
        while (token != NULL) {
            token = strtok_r(ptr, ",", &strptr);
            ptr = NULL; 			/* after initial call strtok expects NULL */
            if (token != NULL) {
                snprintf(buf, 127 - 27 - strlen(token), "suppressMessages(library(%s));", token);
                parse_eval(&pb, buf, 1, 0); 	/* evaluate this silently */
            }
        }
        destroy_membuf(pb);
    }

    if (datastdin) {				/* if req. by user, read 'dat' from stdin */
        membuf_t pb = init_membuf(512);
        parse_eval(&pb, datastdincmd, 1, 0); 	/* evaluate this silently */
        destroy_membuf(pb);
    }

    /* Now determine which R code to evaluate */
    int exit_val = 0;
    if (evalstr != NULL) {
        /* we have a command line expression to evaluate */
        membuf_t pb = init_membuf(1024);
        exit_val = parse_eval(&pb, evalstr, 1, verbose);
        destroy_membuf(pb);
    } else if (optind < argc && (strcmp(argv[optind],"-") != 0)) {
        /* set environment variable giving path to script file */
#if defined(HAVE_REALPATH) && defined(PATH_MAX)
        char script_path[PATH_MAX + 1];
        if (realpath(argv[optind], script_path) != NULL)
            setenv("LITTLER_SCRIPT_PATH", script_path, 1);
        else
            setenv("LITTLER_SCRIPT_PATH", argv[optind], 1);
#else
        setenv("LITTLER_SCRIPT_PATH", argv[optind], 1);
#endif

        /* call R function source(filename) */
        exit_val = source(argv[optind]);
    } else {
        /* Or read from stdin */
        membuf_t lb = init_membuf(1024);
        membuf_t pb = init_membuf(1024);
        int lineno = 1;
        while(readline_stdin(&lb)){
            exit_val = parse_eval(&pb, (char*)lb->buf, lineno++, verbose);
            if (exit_val) break;
        }
        destroy_membuf(lb);
        destroy_membuf(pb);
    }
    littler_CleanUp(SA_NOSAVE, exit_val, 0);
    return(0); /* not reached, but making -Wall happy */
}
