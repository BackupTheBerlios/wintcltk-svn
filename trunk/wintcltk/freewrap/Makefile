# TkWrap makefile
# Copyright (c) 2007, Martin Matuska
# WinTclTk project: http://wintcltk.berlios.de
#
# Based on freeWrap UNIX makefile
# Copyright (c) 2006, Dennis R. LaBelle 
#
# $Id$
#

# TkWrap version
TKWRAP_VERSION?=	0.2

# Where are we?
CURDIR=$(shell pwd)

# Destination directory
DISTDIR=	$(CURDIR)/dist

ifdef FULL
XOTCL=1
endif

# WinTclTk source dir
SRCDIR?=	$(CURDIR)/../src

# Include WinTclTk version defs
include $(SRCDIR)/defs/defs.mak

# WinTclTk install root
INSTROOT?=	$(SRCDIR)/instroot_s

# WinTckTk build directory
BUILDDIR?=	$(SRCDIR)/build_s

# Path for the build directory
FBUILD=		$(CURDIR)/build

# Path to the sources directory
FBSRC=		$(CURDIR)/src

# Path for the scripts directory
FSCRIPTS=	$(CURDIR)/scripts

# Path to output directory
FBOUT=		$(CURDIR)/dist#

# Tcl Versions
TCLVERSIONDOT=	8.4
TCLVERSION=	$(subst .,,$(TCLVERSIONDOT))

# Location of previously compiled TCLSH program
TCLSH = ${INSTROOT}/bin/tclsh$(TCLVERSION)s.exe

# Locations of various directories
INSTALL_BASE = $(INSTROOT)
INSTALL_LIB  = $(INSTROOT)/lib
INSTALL_INCL = $(INSTROOT)/include
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
STRIP=	strip

#
# Resfile
RESFILE = $(FBSRC)/tkwrap.rc
RESHEADER= $(FBSRC)/tkwraprc.h
ICONFILE=	tkwrap.ico

# Resheader defies
COMMAVERSION=	6,2,0,0
DOTVERSION=	6.2.0.0
PROGNAME=	TkWrap (minimal)
FILENAME=	tkwrap.exe
COMPANYNAME=	WinTclTk project (http://wintcltk.berlios.de)
COPYRIGHT=	© 2007 Martin Matuska
PRODUCTNAME=	TkWrap for Windows (minimal)
MANIFESTNAME=	TkWrap

ifdef XOTCL
PROGNAME=	TkWrap (XOTcl)
PRODUCTNAME=	TkWrap for Windows (XOTcl ${XOTCL_VERSION})
endif
ifdef FULL
PROGNAME=	TkWrap (full)
PRODUCTNAME=	TkWrap for Windows (full)
endif

ifdef TKCON
COMMAVERSION=	2,5,0,0
DOTVERSION=	2.5.0.0
PROGNAME=	Tkcon for Windows
FILENAME=	tkcon.exe
COMPANYNAME=	WinTclTk project (http://wintcltk.berlios.de)
COPYRIGHT=	© 2007 Jeffrey Hobbs, Martin Matuska
PRODUCTNAME=	Tkcon for Windows
MANIFESTNAME=	Tkcon
ICONFILE=	tkcon.ico
endif

ifdef XOTCLIDE
COMMAVERSION=	0,8,2,0
DOTVERSION=	0.8.2.0
PROGNAME=	XOTclIDE for Windows
FILENAME=	XOTclIDE.exe
COMPANYNAME=	WinTclTk project (http://wintcltk.berlios.de)
COPYRIGHT=	© 2007 Artur Trzewik, Martin Matuska
PRODUCTNAME=	XOTclIDE for Windows
MANIFESTNAME=	XOTclIDE
ICONFILE=	xotclide.ico
endif

###### Select a C compiler
#
CC = gcc -DSTATIC_BUILD=1 -D__WIN32 -D_MBCS -DWIN32 -DWINDOWS 

###### Select standard command-line options for the C compiler.
#
CFLAGS= -O2 -Wall -DSTATIC_BUILD -DUSE_ZLIB $(X11_INCLUDES)

ifndef FULL
CFLAGS+= -DWITHOUT_TDOM -DWITHOUT_TLS -DWITHOUT_TGDBM -DWITHOUT_MK4TCL -DWITHOUT_MKZIPLIB -DWITHOUT_MEMCHAN
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
ZIP := $(BUILDDIR)/zip-$(ZIP_VERSION)/zip.exe

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
ZSCRIPT_TCL = zipdir/lib/tcl/tclIndex

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
ZSCRIPT_TK = zipdir/lib/tk/tclIndex
endif

# Libraries neede
LIB_GDBM = $(INSTALLDIR)/libgdbm-static.a
LIB_THREAD = $(INSTALLDIR)/thread$(THREAD_VERSION)/thread$(THREAD_LIBVER).a
LIB_Z = $(INSTALLDIR)/libz.a
INDEXES= zipdir/lib/base/pkgIndex.tcl zipdir/lib/thread/pkgIndex.tcl
ifdef FULL
LIB_OPENSSL = $(INSTALLDIR)/libssl.a $(INSTALLDIR)/libcrypto.a
LIB_TDOM = $(INSTALLDIR)/tdom$(TDOM_VERSION)/tdom$(TDOM_LIBVER).a
LIB_TLS = $(INSTALLDIR)/tls$(TLS_VERSION)/tls$(TLS_LIBVER)s.a
LIB_MK4TCL = $(INSTALLDIR)/Mk4tcl/Mk4tcl.lib
LIB_MKZIPLIB = $(INSTALLDIR)/Mkziplib$(MKZIPLIB_VERSION)/Mkziplib$(MKZIPLIB_SHORT).a
LIB_MEMCHAN = $(INSTALLDIR)/Memchan$(MEMCHAN_VERSION)/memchan$(MEMCHAN_LIBVER).a
LIB_TGDBM = $(INSTALLDIR)/tgdbm$(TGDBM_VERSION)/tgdbm.a
INDEXES += zipdir/lib/Mk4tcl/pkgIndex.tcl \
	zipdir/lib/memchan/pkgIndex.tcl \
	zipdir/lib/tdom/pkgIndex.tcl \
	zipdir/lib/tgdbm/pkgIndex.tcl \
	zipdir/lib/mkZiplib/pkgIndex.tcl \
	zipdir/lib/tls/pkgIndex.tcl
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

OPT_MISC= -DNTSD_EAS

OPT_WINICO = -DSTATIC_BUILD -DPACKAGE_NAME="\"Winico\"" -DPACKAGE_VERSION="\"0.5\""

#
# Winlibs
#
WINLIBS = -L/mingw/lib -lkernel32 -ladvapi32 -luser32 -lgdi32 -lcomdlg32 \
	-lwinspool -lole32 -lshell32 -luuid -limm32 -lcomctl32 -lwsock32 \
	-lstdc++

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
  $(LIB_TK) \
  $(LIB_TCL) \
  $(LIB_THREAD) \
  $(LIB_TGDBM) \
  $(LIB_XOTCL) \
  $(LIB_TDOM) \
  $(LIB_TLS) \
  $(LIB_MK4TCL) \
  $(LIB_MKZIPLIB) \
  $(LIB_MEMCHAN) \
  $(LIB_OPENSSL) \
  $(LIB_GDBM) \
  $(LIB_Z)

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
$(FBUILD)/tkwrap.o \
$(FBUILD)/fwcrypt.o \
$(FBUILD)/zvfs.o \
$(FBUILD)/tkwrap.res.o

ifndef WITHOUT_TK
OBJ += $(FBUILD)/tkwinico.o
endif

# All script directories
#
ZSCRIPTS = $(ZSCRIPT_TCL)
ifndef WITHOUT_TK
ZSCRIPTS += $(ZSCRIPT_TK)
endif

ifdef XOTCL
XOTCL_SCRIPTS = zipdir/lib/xotcl/xml
endif
ifdef TKCON
SCRIPTS += zipdir/lib/ctext zipdir/lib/tkcon
endif
ifdef XOTCLIDE
SCRIPTS += zipdir/lib/xotclide
endif

all: static $(FBUILD) $(DISTDIR) $(FBUILD)/null.zip $(FBUILD)/tkwrap$(EXE)

static:
	@cd $(SRCDIR) && make install STATIC_BUILD=1

$(FBUILD):
	@$(MKDIR) $(FBUILD)

$(DISTDIR):
	@$(MKDIR) $(DISTDIR)	
	
zipdir/freewrap.tcl: $(FBSRC)/freewrap.tcl
	@$(MKDIR) zipdir
	@$(CP) $(FBSRC)/freewrap.tcl zipdir

zipdir/freewrapCmds.tcl: $(FBSRC)/freewrapCmds.tcl
	@$(CP) $(FBSRC)/freewrapCmds.tcl zipdir/freewrapCmds.tcl

$(DISTDIR)/tkwrap$(EXE): $(FBUILD)/tkwrap$(EXE)
	@cp $(FBUILD)/tkwrap$(EXE) $(DISTDIR)/tkwrap$(EXE)

$(FBUILD)/tkwrap$(EXE): $(FBUILD)/tkwrap_bare$(EXE) zipdir/freewrap.tcl zipdir/freewrapCmds.tcl $(ZSCRIPTS) $(XOTCL_SCRIPTS) $(INDEXES) $(SCRIPTS)
	@$(RM) $(FBUILD)/tkwrap$(EXE)
	@$(CP) $(FBUILD)/tkwrap_bare$(EXE) $(FBUILD)/tkwrap.zip
	@$(CAT) $(FBUILD)/null.zip >> $(FBUILD)/tkwrap.zip
	@$(TCLSH) $(FBSRC)/setinfo.tcl zipdir $(FBUILD)/tkwrap$(EXE) $(TKWRAP_VERSION) $(FBUILD)/tkwrap_bare$(EXE)
	@$(CP) -f $(FBSRC)/$(ICONFILE) zipdir
	@cd zipdir; pwd; rm -f tk/pkgIndex.tcl; $(ZIP) -rA9 -P `cat $(FBSRC)/currentPWD.txt` $(FBUILD)/tkwrap.zip *; cd ..
	@$(RENAME) $(FBUILD)/tkwrap.zip $(FBUILD)/tkwrap$(EXE)

$(FBUILD)/null.zip:
	@echo . | $(ZIP) $(FBUILD)/null.zip -
	@$(ZIP) $(FBUILD)/null.zip -d -
	
zipdir/lib/tcl/tclIndex: $(SCRIPT_TCL)
	@$(DELTREE) zipdir/lib/tcl
	@$(MKDIR) zipdir/lib/tcl
	@$(TCLSH) $(FBSRC)/shrink.tcl tcl $(SCRIPT_TCL) $(ZSCRIPT_TCL)

zipdir/lib/tcl/init-pkgs.tcl: zipdir/lib/tcl/tclIndex
	@$(SED) -e 's|global auto_path|global auto_path; source /lib/tcl/init-pkgs.tcl|g' zipdir/lib/tcl/init.tcl > zipdir/lib/tcl/init.tcl.bak
	@$(MV) zipdir/lib/tcl/init.tcl.bak zipdir/lib/tcl/init.tcl
	@echo "global auto_path" > zipdir/lib/tcl/init-pkgs.tcl

zipdir/lib/tk/tclIndex: zipdir/lib/tcl/init-pkgs.tcl $(SCRIPT_TK)
	@$(DELTREE) zipdir/lib/tk
	@$(MKDIR) zipdir/lib/tk
	@$(TCLSH) $(FBSRC)/shrink.tcl tk $(SCRIPT_TK) $(ZSCRIPT_TK)
	@sed -e 's|\[file .* tk84.dll\]|""|g' zipdir/lib/Tk/pkgIndex.tcl > zipdir/lib/Tk/pkgIndex.tcl.new
	@$(MV) zipdir/lib/Tk/pkgIndex.tcl.new zipdir/lib/Tk/pkgIndex.tcl
			
zipdir/lib/xotcl/xml: zipdir/lib/tcl/init-pkgs.tcl
	@$(DELTREE) zipdir/lib/xotcl
	@$(MKDIR) zipdir/lib/xotcl
	@$(CP) -rf $(XODIR)/pkgIndex.tcl $(XODIR)/actiweb $(XODIR)/apps $(XODIR)/comm $(XODIR)/lib $(XODIR)/patterns \
		$(XODIR)/rdf $(XODIR)/registry $(XODIR)/serialize $(XODIR)/store $(XODIR)/xml zipdir/lib/xotcl
	@sed -e 's|\[file join $$dir xotc.*a\]|""|g' $(XODIR)/pkgIndex.tcl > zipdir/lib/xotcl/pkgIndex.tcl
	@echo -n "lappend auto_path /lib/xotcl /lib/xotcl/actiweb /lib/xotcl/comm" >> zipdir/lib/tcl/init-pkgs.tcl
	@echo -n " /lib/xotcl/lib /lib/xotcl/patterns /lib/xotcl/rdf" >> zipdir/lib/tcl/init-pkgs.tcl
	@echo -n " /lib/xotcl/rdf /lib/xotcl/registry /lib/xotcl/serialize" >> zipdir/lib/tcl/init-pkgs.tcl
	@echo " /lib/xotcl/store /lib/xotcl/xml" >> zipdir/lib/tcl/init-pkgs.tcl

zipdir/lib/xotclide: zipdir/lib/tcl/init-pkgs.tcl
	@$(DELTREE) zipdir/lib/xotclIDE
	@$(MKDIR) zipdir/lib/xotclIDE
	@$(CP) -rf $(INSTALLDIR)/xotclIDE/* zipdir/lib/xotclIDE
	@echo "lappend auto_path /lib/xotclIDE" >> zipdir/lib/tcl/init-pkgs.tcl
	
zipdir/lib/Mk4tcl/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/Mk4tcl
	@sed -e 's|\[file join $$dir Mk4tcl.lib\]|""|g' $(INSTALLDIR)/Mk4tcl/pkgIndex.tcl > zipdir/lib/Mk4tcl/pkgIndex.tcl
	@echo "lappend auto_path /lib/Mk4tcl" >> zipdir/lib/tcl/init-pkgs.tcl
	
zipdir/lib/memchan/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/memchan
	@echo "package ifneeded Memchan $(MEMCHAN_VERSION) [list load \"\" Memchan]" > zipdir/lib/memchan/pkgIndex.tcl
	@echo "lappend auto_path /lib/memchan" >> zipdir/lib/tcl/init-pkgs.tcl

zipdir/lib/base/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/base
	@echo "package ifneeded dde 1.2.4 [list load \"\" dde]" > zipdir/lib/base/pkgIndex.tcl
	@echo "package ifneeded registry 1.1.4 [list load \"\" registry]" >> zipdir/lib/base/pkgIndex.tcl
#ifndef WITHOUT_TK
	@echo "package ifneeded Winico 0.5 [list load \"\" Winico]" >> zipdir/lib/base/pkgIndex.tcl
#endif
	@echo "lappend auto_path /lib/base" >> zipdir/lib/tcl/init-pkgs.tcl
	
zipdir/lib/thread/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/thread
	@$(CP) $(INSTALLDIR)/thread$(THREAD_VERSION)/ttrace.tcl zipdir/lib/thread/ttrace.tcl
	@echo "package ifneeded Thread $(THREAD_VERSION) [list load \"\" Thread]" > zipdir/lib/thread/pkgIndex.tcl
	@echo "package ifneeded Ttrace $(THREAD_VERSION) [list source [file join \$$dir ttrace.tcl]]" >> zipdir/lib/thread/pkgIndex.tcl
	@echo "lappend auto_path /lib/thread" >> zipdir/lib/tcl/init-pkgs.tcl

zipdir/lib/tdom/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/tdom
	@$(CP) $(INSTALLDIR)/tdom$(TDOM_VERSION)/tdom.tcl zipdir/lib/tdom/tdom.tcl
	@echo "package ifneeded tdom $(TDOM_VERSION) \"load [list \"\" tdom]; source [list [file join \$$dir tdom.tcl]]\"" > zipdir/lib/tdom/pkgIndex.tcl
	@echo "lappend auto_path /lib/tdom" >> zipdir/lib/tcl/init-pkgs.tcl	

zipdir/lib/tgdbm/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/tgdbm
	@$(CP) $(INSTALLDIR)/tgdbm$(TGDBM_VERSION)/qgdbm.tcl zipdir/lib/tgdbm/qgdbm.tcl
	@echo "package ifneeded tgdbm $(TGDBM_VERSION) [list load \"\" tgdbm]" > zipdir/lib/tgdbm/pkgIndex.tcl
	@echo "package ifneeded qgdbm $(TGDBM_VERSION) [list source [file join \$$dir qgdbm.tcl]]" >> zipdir/lib/tgdbm/pkgIndex.tcl
	@echo "lappend auto_path /lib/tgdbm" >> zipdir/lib/tcl/init-pkgs.tcl

zipdir/lib/mkZiplib/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/mkZiplib
	@echo "package ifneeded mkZiplib $(MKZIPLIB_VERSION) [list load \"\" mkZiplib]" > zipdir/lib/mkZiplib/pkgIndex.tcl
	@echo "lappend auto_path /lib/mkZiplib" >> zipdir/lib/tcl/init-pkgs.tcl

zipdir/lib/tls/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/tls
	@echo "package ifneeded tls 1.50 [list load \"\" tls]" > zipdir/lib/tls/pkgIndex.tcl
	@echo "lappend auto_path /lib/tls" >> zipdir/lib/tcl/init-pkgs.tcl

zipdir/lib/tkcon: zipdir/lib/tcl/init-pkgs.tcl
	@echo "lappend auto_path /lib/tkcon" >> zipdir/lib/tcl/init-pkgs.tcl
	@$(DELTREE) zipdir/lib/tkcon
	@$(MKDIR) zipdir/lib/tkcon
	@cd $(INSTROOT)/lib/tkcon$(TKCON_VERSION) && cp tkcon.tcl pkgIndex.tcl $(CURDIR)/zipdir/lib/tkcon
	@sed -e 's|"dev"|"$(WINTCLTK_FW_VERSION)"|g' $(CURDIR)/patches/tkcon.patch > $(FBUILD)/tkcon.patch
	@cd $(CURDIR)/zipdir/lib/tkcon && patch -p2 < $(FBUILD)/tkcon.patch
		
zipdir/lib/ctext: zipdir/lib/tcl/init-pkgs.tcl
	@echo "lappend auto_path /lib/ctext" >> zipdir/lib/tcl/init-pkgs.tcl
	@$(DELTREE) zipdir/lib/ctext
	@$(MKDIR) zipdir/lib/ctext
	@$(CP) -rf $(INSTROOT)/lib/tklib$(TKLIB_SHORT)/ctext/* zipdir/lib/ctext
		
resheader:
	@echo "#define COMMAVERSION $(COMMAVERSION)" > $(RESHEADER)
	@echo "#define DOTVERSION \"$(DOTVERSION)\"" >> $(RESHEADER)
	@echo "#define PROGNAME \"$(PROGNAME)\"" >> $(RESHEADER)
	@echo "#define FILENAME \"$(FILENAME)\"" >> $(RESHEADER)
	@echo "#define COMPANYNAME \"$(COMPANYNAME)\"" >> $(RESHEADER)
	@echo "#define COPYRIGHT \"$(COPYRIGHT)\"" >> $(RESHEADER)
	@echo "#define PRODUCTNAME \"$(PRODUCTNAME)\"" >> $(RESHEADER)
	@echo "#define ICONFILE \"$(ICONFILE)\"" >> $(RESHEADER)
	
resmanifest:
	@$(SED) -e 's|%%VERSION%%|$(DOTVERSION)|g' -e 's|%%NAME%%|$(MANIFESTNAME)|g' \
		$(FBSRC)/tkwrap.manifest.in > $(FBSRC)/tkwrap.manifest

tkwrap: all $(DISTDIR)/tkwrap$(EXE)
		
full:
	@make clean tkwrap FULL=1

tkcon:
	@make clean all FULL=1 TKCON=1
	@cp $(FSCRIPTS)/tkcon.tcl $(FBUILD)
	@cd $(FBUILD) && tkwrap$(EXE) tkcon.tcl
	@mv $(FBUILD)/tkcon$(EXE) $(DISTDIR)/tkcon$(EXE)

xotclide:
	@make clean all FULL=1 XOTCLIDE=1
	@cp $(FSCRIPTS)/XOTclIDE.tcl $(FBUILD)
	@cd $(FBUILD) && tkwrap$(EXE) XOTclIDE.tcl
	@mv $(FBUILD)/XOTclIDE$(EXE) $(DISTDIR)/XOTclIDE$(EXE)
		
$(FBUILD)/tkwrap.res.o: resheader resmanifest
	@cd $(FBSRC) && windres -i $(RESFILE) -I${BUILDDIR}/tk${TCLTK_VERSION}/win/rc -o $(FBUILD)/tkwrap.res.o
	
$(FBUILD)/tkwrap_bare$(EXE): $(OBJ) $(LIBS)
	$(CC) $(LFLAGS) -o $(FBUILD)/tkwrap_bare$(EXE) $(OBJ) $(LIBS) $(WINLIBS) $(X11_LIB_SWITCHES)
	$(STRIP) $(FBUILD)/tkwrap_bare$(EXE)
# Comment out the following line if you do not want to compress the executable file with UPX.
	@[ -x "$(UPX)" ] && "$(UPX)" -9 $(FBUILD)/tkwrap_bare$(EXE)

$(FBUILD)/tkwrap.o: $(FBSRC)/main.c
	$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/tkwrap.o -c $(FBSRC)/main.c

$(FBSRC)/fwcrypt.c: $(FBSRC)/setinfo.tcl
	cd ${FBSRC} && $(TCLSH) setinfo.tcl

$(FBUILD)/tkwinico.o: $(FBSRC)/tkwinico.c
	$(CC) $(CFLAGS) $(OPT) $(OPT_WINICO) -o $(FBUILD)/tkwinico.o -c $(FBSRC)/tkwinico.c
	
$(FBUILD)/fwcrypt.o: $(FBSRC)/fwcrypt.c
	$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/fwcrypt.o -c $(FBSRC)/fwcrypt.c

$(FBUILD)/zvfs.o: $(FBSRC)/zvfs.c
	$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/zvfs.o -c $(FBSRC)/zvfs.c
	
$(FBUILD)/freelib.o : $(FBSRC)/freelib.c
	$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/freelib.o -c $(FBSRC)/freelib.c

$(FBUILD)/zipmain.o : $(FBSRC)/zipmain.c
	$(CC) $(CFLAGS) $(OPT) -I$(ZIPOBJDIR) -DUNIX -DASMV -DASM_CRC -DNO_STRCHR -DNO_STRRCHR -DCRYPT -DHAVE_DIRENT_H -DHAVE_TERMIOS_H -o $(FBUILD)/zipmain.o -c $(FBSRC)/zipmain.c

clean:
	-$(DELTREE) $(FBUILD) zipdir

distclean: clean
	$(RM) -f $(FBSRC)/currentPWD.txt $(FBSRC)/fwcrypt.c
