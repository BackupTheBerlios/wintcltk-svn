# WinTclTk makefile for freeWrap
#
# Developed by Martin Matuska
# Based on UNIX makefile developed by Dennis R. LaBelle
#
# Edit the parameters to suit your configuration, then type "make".
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



# Name of the application program
#
## Name of the current extension to include
## FW_EXT=TCLSH  for TCL only program
## FW_EXT=       for TCL/TK only
#FW_EXT=TCLSH
FW_EXT=

# WinTclTk source dir
CURDIR=$(shell pwd)
SRCDIR?=	$(CURDIR)/../../src

# Include WinTclTk version defs
include $(SRCDIR)/defs/defs.mak

# WinTclTk install root
INSTROOT?=	$(SRCDIR)/instroots

# WinTckTk build directory
BUILDDIR?=	$(SRCDIR)/builds

#
## Full name of the application
PROG = freewrap$(FW_EXT)

# Current application program revision number
PROGREV = 6.2

###### The path for the top-level build directory
#
TOP = .

# Name of main program file.
MAINPRG = ../generic/main

# TCL/TK version info
TCLVERSIONDOT = 8.4
TCLVERSION = 84

# Location of previously compiled TCLSH program
TCLSH = ${INSTROOT}/bin/tclsh${TCLVERSION}s.exe

# Locations of various directories
INSTALL_BASE = ${INSTROOT}
INSTALL_LIB  = ${INSTROOT}/lib
INSTALL_INCL = ${INSTROOT}/include
TCLDIR       = ${BUILDDIR}/tcl$(TCLVERSIONDOT)/unix
TKDIR        = ${BUILDDIR}/tk$(TCLVERSIONDOT)/unix
INSTALLDIR   = ${INSTROOT}/lib
ZIPOBJDIR    = ${BUILDDIR}/zip-2.32

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

# X11 stuff
# A "-I" switch that can be used when compiling to make all of the
# X11 include files accessible .
#X11_INCLUDES		= -I/usr/X11R6/include

# Linker switch(es) to use to link with the X11 library archive.
#X11_LIB_SWITCHES = -L/usr/lib -L/usr/X11R6/lib -lX11 -ldl -lieee -lm -lpthread
###### Select a C compiler
#
CC = gcc -DSTATIC_BUILD=1 -DWIN32 -DWINDOWS -DUSE_ZLIB

###### Select standard command-line options for the C compiler.
#
CFLAGS= -O2 -Wall -DSTATIC_BUILD $(X11_INCLUDES)

###### Add these options to CFLAGS when linking object files into
#      an executable.
#
LFLAGS = -static -mwindows
#LFLAGS = -static -Xlinker -S
###### Name of the ZIP archiver program
#
ZIP = $(INSTROOT)/bin/zip.exe

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
ifeq ($(FW_EXT),TCLSH)
LIB_TK =
OPT_TK = -DWITHOUT_TK=1
else
LIB_TK = $(INSTALLDIR)/libtk$(TCLVERSION)s.a
endif

###### The name of the top-level directory of the TK script library
#
ifeq ($(FW_EXT),TCLSH)
SCRIPT_TK =
ZSCRIPT_TK =
else
SCRIPT_TK = $(INSTALL_LIB)/tk$(TCLVERSIONDOT)/tclIndex
ZSCRIPT_TK = zipdir/tk/tclIndex
endif

XOTCLSCRIPTS= zipdir/xotcl/xml

###### The linker option needed to include the Z compression library.
#      This library is required by both the Img extension and the
#      virtual file system.
#
LIB_Z = $(INSTALLDIR)/libz.a

# Other libs
LIB_GDBM = $(INSTALLDIR)/libgdbm-static.a
LIB_OPENSSL = $(INSTALLDIR)/libssl.a $(INSTALLDIR)/libcrypto.a
LIB_MKZIPLIB= $(INSTALLDIR)/mkZiplib$(MKZIPLIB_VERSION)/mkZiplib$(MKZIPLIB_LIBVER).a
LIB_TDOM = $(INSTALLDIR)/tdom$(TDOM_VERSION)/tdom$(TDOM_LIBVER).a
LIB_TLS = $(INSTALLDIR)/tls$(TLS_VERSION)/tls$(TLS_LIBVER)s.a
LIB_THREAD = $(INSTALLDIR)/thread$(THREAD_VERSION)/thread$(THREAD_LIBVER).a
LIB_TGDBM = $(INSTALLDIR)/tgdbm$(TGDBM_VERSION)/tgdbm.a
LIB_XOTCL = $(INSTALLDIR)/xotcl$(XOTCL_LIBVER).a 
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
OBJSZIP = $(TOP)/zipmain.o \
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
$(TOP)/freelib.o \
$(TOP)/freewrap$(FW_EXT).o \
$(TOP)/fwcrypt.o \
$(TOP)/zvfs.o \
$(TOP)/tkwinico.o \
$(TOP)/tclsh.res.o

# All script directories
#
ZSCRIPTS = $(ZSCRIPT_TCL) $(ZSCRIPT_TK) 

all: null.zip $(PROG)$(EXE) freewish$(FW_EXT)$(EXE)

zipdir/freewrap.tcl: $(TOP)/../generic/freewrap.tcl
	$(MKDIR) zipdir
	$(CP) $(TOP)/../generic/freewrap.tcl zipdir

zipdir/freewrapCmds.tcl: $(TOP)/../generic/freewrapCmds.tcl
	$(CP) $(TOP)/../generic/freewrapCmds.tcl zipdir/freewrapCmds.tcl

$(PROG)$(EXE): $(PROG)_bare$(EXE) zipdir/freewrap.tcl zipdir/freewrapCmds.tcl $(ZSCRIPTS)
	$(RM) $(PROG)$(EXE)
ifeq ($(FW_EXT),TCLSH)
	$(DELTREE) zipdir/tk
endif
	$(CP) $(PROG)_bare$(EXE) $(PROG).zip
	$(CAT) $(TOP)/null.zip >>$(PROG).zip
	$(TCLSH) $(TOP)/../generic/setinfo.tcl zipdir $(PROG)$(EXE) $(PROGREV) $(PROG)_bare$(EXE)
	echo .
	echo To continue, you must now enter the password key that was compiled into freeWrap.
	cat $(TOP)/../generic/currentPWD.txt
	echo .
	cd zipdir; pwd; $(ZIP) -rA9 ../$(PROG).zip *; cd ..
	$(RENAME) $(PROG).zip $(PROG)$(EXE)
	$(RM) freewish$(FW_EXT)$(EXE)
	$(CP) $(PROG)$(EXE) freewish$(FW_EXT)$(EXE)

null.zip:
	echo . | $(ZIP) null.zip -
	$(ZIP) null.zip -d -

zipdir/tcl/tclIndex: $(SCRIPT_TCL)
	$(DELTREE) zipdir/tcl
	$(MKDIR) zipdir/tcl
	$(TCLSH) $(TOP)/../generic/shrink.tcl tcl $(SCRIPT_TCL) $(ZSCRIPT_TCL)

zipdir/tk/tclIndex: $(SCRIPT_TK)
	$(DELTREE) zipdir/tk
	$(MKDIR) zipdir/tk
	$(TCLSH) $(TOP)/../generic/shrink.tcl tk $(SCRIPT_TK) $(ZSCRIPT_TK)
	
zipdir/xotcl/xml:
	$(DELTREE) zipdir/xotcl
	$(MKDIR) zipdir/xotcl
	$(CP) -rf $(XODIR)/actiweb $(XODIR)/apps $(XODIR)/comm $(XODIR)/lib $(XODIR)/patterns \
		$(XODIR)/rdf $(XODIR)/registry $(XODIR)/serialize $(XODIR)/store $(XODIR)/xml zipdir/xotcl
	@echo "global auto_path" > zipdir/tcl/init-pkgs.tcl
	@echo "lappend auto_path /xotcl/actiweb /xotcl/comm /xotcl/lib /xotcl/patterns /xotcl/rdf" >> zipdir/tcl/init-pkgs.tcl
	@echo "lappend auto_path /xotcl/rdf /xotcl/registry /xotcl/serialize /xotcl/store /xotcl/xml" >> zipdir/tcl/init-pkgs.tcl
	@echo "return" >> zipdir/tcl/init-xotcl.tcl
	@$(SED) -e 's|global auto_path|global auto_path; source /tcl/init-pkgs.tcl|g' zipdir/tcl/init.tcl > zipdir/tcl/init.tcl.bak
	@$(MV) zipdir/tcl/init.tcl.bak zipdir/tcl/init.tcl

$(TOP)/tclsh.res.o:
	windres $(HDR_TK) -i $(RESFILE) -o $(TOP)/tclsh.res.o
	
$(PROG)_bare$(EXE): $(OBJ) $(LIBS)
	$(CC) $(LFLAGS) -o $(PROG)_bare$(EXE) $(OBJ) $(LIBS) $(WINLIBS) $(X11_LIB_SWITCHES)
# Comment out the following line if you do not want to compress the executable file with UPX.
	upx -9 $(PROG)_bare$(EXE)
	
$(TOP)/freewrap$(FW_EXT).o: $(MAINPRG).c
	$(CC) $(CFLAGS) $(OPT) -o freewrap$(FW_EXT).o -c $(TOP)/$(MAINPRG).c

$(TOP)/../generic/fwcrypt.c: $(TOP)/../generic/setinfo.tcl
	$(TCLSH) $(TOP)/../generic/setinfo.tcl

$(TOP)/tkwinico.o: $(TOP)/tkwinico.c
	$(CC) $(CFLAGS) $(OPT) $(OPT_WINICO) -o tkwinico.o -c $(TOP)/tkwinico.c
	
$(TOP)/fwcrypt.o: $(TOP)/../generic/fwcrypt.c
	$(CC) $(CFLAGS) $(OPT) -o fwcrypt.o -c $(TOP)/../generic/fwcrypt.c

$(TOP)/zvfs.o: $(TOP)/../generic/zvfs.c
	$(CC) $(CFLAGS) $(OPT) -o zvfs.o -c $(TOP)/../generic/zvfs.c

$(TOP)/freelib.o : $(TOP)/../generic/freelib.c
	$(CC) $(CFLAGS) $(OPT) -o freelib.o -c $(TOP)/../generic/freelib.c

$(TOP)/zipmain.o : $(TOP)/../generic/zipmain.c
	$(CC) $(CFLAGS) $(OPT) -I$(ZIPOBJDIR) -DUNIX -DASMV -DASM_CRC -DNO_STRCHR -DNO_STRRCHR -DCRYPT -DHAVE_DIRENT_H -DHAVE_TERMIOS_H -o zipmain.o -c $(TOP)/../generic/zipmain.c

clean:
	$(RM) core
	$(RM) *.o
	$(RM) $(PROG)_bare$(EXE) freewish$(FW_EXT)$(EXE)
	$(RM) $(PROG)$(EXE)
	$(RM) *.zip
	$(DELTREE) zipdir








