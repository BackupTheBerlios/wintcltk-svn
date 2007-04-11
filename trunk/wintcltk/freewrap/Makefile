# WinTclTk freeWrap makefile
# Based on UNIX makefile developed by Dennis R. LaBelle
# Copyright (c) 2007 Dennis R. LaBelle, Martin Matuska
#
# $Id$
#
# NOTES: Important - please read.
#
#     1) With the addition of ZIP 2.0 style file encryption, the freeWrap
#        build process now includes an interactive step. During this step,
#        you must enter the password key that is compiled into freeWrap
#        at a console prompt. This password is automatically generated the
#        first time freeWrap is built and will be printed to the screen
#        immediately before you need to type it in. 
#

# Where are we?
CURDIR=$(shell pwd)

# Distribution and destination
DIST?=	std
DISTDIR=	$(CURDIR)/dist/std

ifeq ($(DIST),xotcl)
XOTCL=1
DISTDIR=	$(CURDIR)/dist/xotcl
endif
ifeq ($(DIST),full)
FULL=1
DISTDIR=	$(CURDIR)/dist/full
endif

# WinTclTk source dir
SRCDIR?=	$(CURDIR)/../src

# Include WinTclTk version defs
include $(SRCDIR)/defs/defs.mak

# WinTclTk install root
INSTROOT?=	$(SRCDIR)/instroots

# WinTckTk build directory
BUILDDIR?=	$(SRCDIR)/builds

# Current application program revision number
PROGREV = 6.2

# Path for the build directory
FBUILD=		$(CURDIR)/build

# Path to the sources directory
FBSRC=		$(CURDIR)/src

# Path to output directory
FBOUT=		$(CURDIR)/dist

# TCL/TK version info
TCLVERSIONDOT = 8.4
TCLVERSION = 84

# Location of previously compiled TCLSH program
TCLSH = ${INSTROOT}/bin/tclsh${TCLVERSION}s.exe

# Locations of various directories
INSTALL_BASE = $(INSTROOT)
INSTALL_LIB  = $(INSTROOT)/lib
INSTALL_INCL = $(INSTROOT)/include
TCLDIR       = $(BUILDDIR)/tcl$(TCLVERSIONDOT)/unix
TKDIR        = $(BUILDDIR)/tk$(TCLVERSIONDOT)/unix
INSTALLDIR   = $(INSTROOT)/lib
ZIPOBJDIR    = $(BUILDDIR)/zip-$(ZIP_VERSION)

###### Some operating system specific commands
RM = rm -f
CAT = cat
CP = cp -p
MV = mv -f
MKDIR = mkdir -p
RENAME = mv
DELTREE = rm -rf
SED = sed

#
# Resfile
RESFILE = ${BUILDDIR}/tcl$(TCLTK_VERSION)/win/tclsh.rc

###### Select a C compiler
#
CC = gcc -DSTATIC_BUILD=1 -DWIN32 -DWINDOWS 

###### Select standard command-line options for the C compiler.
#
CFLAGS= -O2 -Wall -DSTATIC_BUILD -DUSE_ZLIB $(X11_INCLUDES)

ifndef FULL
CFLAGS+= -DWITHOUT_TDOM -DWITHOUT_TLS -DWITHOUT_TGDBM
endif
ifndef XOTCL
CFLAGS+= -DWITHOUT_XOTCL
endif

###### Add these options to CFLAGS when linking object files into
#      an executable.
#
LFLAGS = -static -mwindows
###### Name of the ZIP archiver program
#
ZIP := $(ZIP)

###### Extention for executable files on the target machine.
#
EXE = .exe

###### A list of directory(s containing TCL header files "tcl.h" etc.
#
HDR_TCL = -I$(INSTALL_INCL)

###### The linker option used to link against the TCL library
#
LIB_TCL = $(INSTALLDIR)/libtcl$(TCLVERSION)s.a $(INSTALLDIR)/dde1.2/tcldde12s.a $(INSTALLDIR)/reg1.1/tclreg11s.a

###### The path to tclIndex in the top-level directory of the TCL script library
#
SCRIPT_TCL = $(INSTALL_LIB)/tcl$(TCLVERSIONDOT)/tclIndex

###### The location to store the minimized version of the TCL tclIndex file.
ZSCRIPT_TCL = zipdir/tcl/tclIndex

###### A list of directory(s) containing TK header files "tk.h" etc.
#      Leave undefined if not needed.
#
HDR_TK = -I$(INSTALL_INCL)

###### The directory containing the zlib header files "zlib.h".
#
HDR_ZLIB = -I$(INSTALL_INCL)

###### The linker option used to link against the TCL library
#
ifdef WITHOUT_TK
LIB_TK =
OPT_TK = -DWITHOUT_TK=1
else
LIB_TK = $(INSTALLDIR)/libtk$(TCLVERSION)s.a
endif

###### The name of the top-level directory of the TK script library
#
ifdef WITHOUT_TK
SCRIPT_TK =
ZSCRIPT_TK =
else
SCRIPT_TK = $(INSTALL_LIB)/tk$(TCLVERSIONDOT)/tclIndex
ZSCRIPT_TK = zipdir/tk/tclIndex
endif

###### The linker option needed to include the Z compression library.
#      This library is required by both the Img extension and the
#      virtual file system.
#
LIB_Z = $(INSTALLDIR)/libz.a

# Other libs
LIB_GDBM = $(INSTALLDIR)/libgdbm-static.a
LIB_THREAD = $(INSTALLDIR)/thread$(THREAD_VERSION)/thread$(THREAD_LIBVER).a
ifdef FULL
LIB_OPENSSL = $(INSTALLDIR)/libssl.a $(INSTALLDIR)/libcrypto.a
LIB_TDOM = $(INSTALLDIR)/tdom$(TDOM_VERSION)/tdom$(TDOM_LIBVER).a
LIB_TLS = $(INSTALLDIR)/tls$(TLS_VERSION)/tls$(TLS_LIBVER)s.a
LIB_TGDBM = $(INSTALLDIR)/tgdbm$(TGDBM_VERSION)/tgdbm.a
XOTCL = 1
endif
ifdef XOTCL
LIB_XOTCL = $(INSTALLDIR)/xotcl$(XOTCL_LIBVER).a 
endif
XODIR = $(INSTALLDIR)/xotcl$(XOTCL_VERSION)
	
###### Select which Tcl extensions to include.
#
#      To include a Tcl extension x, define LIB_x to be the linker options
#      needed to link against that extension.  To omit a Tcl extension,
#      leave LIB_x undefined and supply a definition for OPT_x that defines
#      the C preprocessor macro WITHOUT_x.
#

OPT_MISC=

OPT_WINICO = -DSTATIC_BUILD -DPACKAGE_NAME="\"Winico\"" -DPACKAGE_VERSION="\"0.5\""

#
# Winlibs
#
WINLIBS = -L/mingw/lib -lkernel32 -ladvapi32 -luser32 -lgdi32 -lcomdlg32 \
	-lwinspool -lole32 -lshell32 -luuid -limm32 -lcomctl32 -lwsock32

###############################################################################
# You should not have to change anything below this line
###############################################################################
#
# All Include files directives.
#
OPT = \
   $(HDR_TCL) \
   $(HDR_TK) \
   $(HDR_ZLIB) \
   $(OPT_TK) \
   $(OPT_MISC)

# All library options to the linker
#
LIBS = \
  $(LIB_Z) \
  $(LIB_TK) \
  $(LIB_TCL) \
  $(LIB_THREAD) \
  $(LIB_TGDBM) \
  $(LIB_XOTCL) \
  $(LIB_TDOM) \
  $(LIB_TLS) \
  $(LIB_OPENSSL) \
  $(LIB_GDBM)

# ZIP program object modules
OBJSZIP = $(FBUILD)/zipmain.o \
$(ZIPOBJDIR)/crc32.o \
$(ZIPOBJDIR)/crctab.o \
$(ZIPOBJDIR)/crypt.o \
$(ZIPOBJDIR)/deflate.o \
$(ZIPOBJDIR)/fileio.o \
$(ZIPOBJDIR)/globals.o \
$(ZIPOBJDIR)/nt.o \
$(ZIPOBJDIR)/trees.o \
$(ZIPOBJDIR)/ttyio.o  \
$(ZIPOBJDIR)/util.o \
$(ZIPOBJDIR)/win32.o \
$(ZIPOBJDIR)/win32zip.o \
$(ZIPOBJDIR)/zipfile.o \
$(ZIPOBJDIR)/zipup.o

# All object code modules
#
OBJ = $(OBJSZIP) \
$(FBUILD)/freelib.o \
$(FBUILD)/freewrap.o \
$(FBUILD)/fwcrypt.o \
$(FBUILD)/zvfs.o \
$(FBUILD)/tclsh.res.o

ifndef WITHOUT_TK
OBJ += $(FBUILD)/tkwinico.o
endif

# All script directories
#
ZSCRIPTS = $(ZSCRIPT_TCL) $(ZSCRIPT_TK) 

ifdef XOTCL
XOTCL_SCRIPTS = zipdir/xotcl/xml
endif

all: $(FBUILD) $(DISTDIR) $(FBUILD)/null.zip $(DISTDIR)/freewrap$(EXE) $(DISTDIR)/freewish$(EXE)

$(FBUILD):
	@$(MKDIR) $(FBUILD)

$(DISTDIR):
	@$(MKDIR) $(DISTDIR)	
	
zipdir/freewrap.tcl: $(FBSRC)/freewrap.tcl
	@$(MKDIR) zipdir
	@$(CP) $(FBSRC)/freewrap.tcl zipdir

zipdir/freewrapCmds.tcl: $(FBSRC)/freewrapCmds.tcl
	@$(CP) $(FBSRC)/freewrapCmds.tcl zipdir/freewrapCmds.tcl

$(DISTDIR)/freewrap$(EXE): $(DISTDIR)/freewrap_bare$(EXE) zipdir/freewrap.tcl zipdir/freewrapCmds.tcl $(ZSCRIPTS) $(XOTCL_SCRIPTS)
	@$(RM) $(DISTDIR)/freewrap$(EXE)
ifdef WITHOUT_TK
	@$(DELTREE) zipdir/tk
endif
	@$(CP) $(DISTDIR)/freewrap_bare$(EXE) $(DISTDIR)/freewrap.zip
	@$(CAT) $(FBUILD)/null.zip >> $(DISTDIR)/freewrap.zip
	@$(TCLSH) $(FBSRC)/setinfo.tcl zipdir $(DISTDIR)/freewrap$(EXE) $(PROGREV) $(DISTDIR)/freewrap_bare$(EXE)
	@cd zipdir; pwd; $(ZIP) -rA9 -P `cat $(FBSRC)/currentPWD.txt` $(DISTDIR)/freewrap.zip *; cd ..
	@$(RENAME) $(DISTDIR)/freewrap.zip $(DISTDIR)/freewrap$(EXE)
	@$(RM) $(DISTDIR)/freewish$(EXE)
	@$(CP) $(DISTDIR)/freewrap$(EXE) $(DISTDIR)/freewish$(EXE)

$(FBUILD)/null.zip:
	@echo . | $(ZIP) $(FBUILD)/null.zip -
	@$(ZIP) $(FBUILD)/null.zip -d -

zipdir/tcl/tclIndex: $(SCRIPT_TCL)
	@$(DELTREE) zipdir/tcl
	@$(MKDIR) zipdir/tcl
	@$(TCLSH) $(FBSRC)/shrink.tcl tcl $(SCRIPT_TCL) $(ZSCRIPT_TCL)

zipdir/tk/tclIndex: $(SCRIPT_TK)
	@$(DELTREE) zipdir/tk
	@$(MKDIR) zipdir/tk
	@$(TCLSH) $(FBSRC)/shrink.tcl tk $(SCRIPT_TK) $(ZSCRIPT_TK)
	
zipdir/xotcl/xml:
	@$(DELTREE) zipdir/xotcl
	@$(MKDIR) zipdir/xotcl
	@$(CP) -rf $(XODIR)/actiweb $(XODIR)/apps $(XODIR)/comm $(XODIR)/lib $(XODIR)/patterns \
		$(XODIR)/rdf $(XODIR)/registry $(XODIR)/serialize $(XODIR)/store $(XODIR)/xml zipdir/xotcl
	@echo "global auto_path" > zipdir/tcl/init-pkgs.tcl
	@echo "lappend auto_path /xotcl/actiweb /xotcl/comm /xotcl/lib /xotcl/patterns /xotcl/rdf" >> zipdir/tcl/init-pkgs.tcl
	@echo "lappend auto_path /xotcl/rdf /xotcl/registry /xotcl/serialize /xotcl/store /xotcl/xml" >> zipdir/tcl/init-pkgs.tcl
	@echo "return" >> zipdir/tcl/init-xotcl.tcl
	@$(SED) -e 's|global auto_path|global auto_path; source /tcl/init-pkgs.tcl|g' zipdir/tcl/init.tcl > zipdir/tcl/init.tcl.bak
	@$(MV) zipdir/tcl/init.tcl.bak zipdir/tcl/init.tcl

$(FBUILD)/tclsh.res.o:
	@cd $(FBSRC) && windres $(HDR_TK) -i $(RESFILE) -o $(FBUILD)/tclsh.res.o
	
$(DISTDIR)/freewrap_bare$(EXE): $(OBJ) $(LIBS)
	@$(CC) $(LFLAGS) -o $(DISTDIR)/freewrap_bare$(EXE) $(OBJ) $(LIBS) $(WINLIBS) $(X11_LIB_SWITCHES)
# Comment out the following line if you do not want to compress the executable file with UPX.
	@[ -x $(UPX) ] && $(UPX) -9 $(DISTDIR)/freewrap_bare$(EXE)
	
$(FBUILD)/freewrap.o: $(FBSRC)/main.c
	@$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/freewrap.o -c $(FBSRC)/main.c

$(FBSRC)/fwcrypt.c: $(FBSRC)/setinfo.tcl
	@cd ${FBSRC} && $(TCLSH) setinfo.tcl

$(FBUILD)/tkwinico.o: $(FBSRC)/tkwinico.c
	@$(CC) $(CFLAGS) $(OPT) $(OPT_WINICO) -o $(FBUILD)/tkwinico.o -c $(FBSRC)/tkwinico.c
	
$(FBUILD)/fwcrypt.o: $(FBSRC)/fwcrypt.c
	@$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/fwcrypt.o -c $(FBSRC)/fwcrypt.c

$(FBUILD)/zvfs.o: $(FBSRC)/zvfs.c
	@$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/zvfs.o -c $(FBSRC)/zvfs.c

$(FBUILD)/freelib.o : $(FBSRC)/freelib.c
	@$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/freelib.o -c $(FBSRC)/freelib.c

$(FBUILD)/zipmain.o : $(FBSRC)/zipmain.c
	@$(CC) $(CFLAGS) $(OPT) -I$(ZIPOBJDIR) -DUNIX -DASMV -DASM_CRC -DNO_STRCHR -DNO_STRRCHR -DCRYPT -DHAVE_DIRENT_H -DHAVE_TERMIOS_H -o $(FBUILD)/zipmain.o -c $(FBSRC)/zipmain.c

clean:
	$(RM) $(DISTDIR)/*.exe $(DISTDIR)/*.zip
	$(DELTREE) $(FBUILD) zipdir

distclean: clean
	$(RM) -f $(FBSRC)/currentPWD.txt $(FBSRC)/fwcrypt.c