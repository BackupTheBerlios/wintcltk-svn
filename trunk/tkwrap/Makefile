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
SRCDIR?=	$(CURDIR)/../wintcltk/src

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
COMMAVERSION=	0,2,0,0
DOTVERSION=	0.2.0.0
PROGNAME=	TkWrap
FILENAME=	tkwrap.exe
COMPANYNAME=	WinTclTk (http://wintcltk.berlios.de)
COPYRIGHT=	© 2007 Martin Matuska
PRODUCTNAME=	TkWrap for Windows (minimal)
MANIFESTNAME=	TkWrap

ifndef WITHOUT_TK
WRAPNAME=	tkwrap
else
PROGNAME=	TclWrap
PRODUCTNAME=	TclWrap for Windows
MANIFESTNAME=	TclWrap
WRAPNAME=	tclwrap
endif

ifdef XOTCL
PRODUCTNAME=	TkWrap for Windows (XOTcl ${XOTCL_VERSION})
WRAPNAME=	xowrap
endif
ifdef FULL
PRODUCTNAME=	TkWrap for Windows (full)
WRAPNAME=	fullwrap
endif

ifdef TKCON
COMMAVERSION=	2,5,0,0
DOTVERSION=	2.5.0.0
PROGNAME=	Tkcon for Windows
FILENAME=	tkcon.exe
COPYRIGHT=	© 2007 Jeffrey Hobbs, Martin Matuska
PRODUCTNAME=	Tkcon for Windows
MANIFESTNAME=	Tkcon
ICONFILE=	tkcon.ico
WRAPNAME=	tkwrap
endif

ifdef XOTCLIDE
COMMAVERSION=	0,8,2,0
DOTVERSION=	0.8.2.0
PROGNAME=	XOTclIDE for Windows
FILENAME=	XOTclIDE.exe
COPYRIGHT=	© 2007 Artur Trzewik, Martin Matuska
PRODUCTNAME=	XOTclIDE for Windows
MANIFESTNAME=	XOTclIDE
ICONFILE=	xotclide.ico
WRAPNAME=	tkwrap
endif

###### Select a C compiler
#
CC = gcc -DSTATIC_BUILD=1 -D__WIN32 -D_MBCS -DWIN32 -DWINDOWS 

###### Select standard command-line options for the C compiler.
#
CFLAGS= -O2 -Wall -DSTATIC_BUILD -DUSE_ZLIB -DWRAPNAME=\"$(WRAPNAME)\" $(X11_INCLUDES)

ifndef FULL
OPT_SEL+= -DWITHOUT_TLS -DWITHOUT_MK4TCL -DWITHOUT_SNACK -DWITHOUT_TKTABLE -DWITHOUT_TKHTML -DWITHOUT_SQLITE
endif

ifndef XOTCL
OPT_SEL+= -DWITHOUT_XOTCL -DWITHOUT_TDOM
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
LIB_WINICO = $(INSTALLDIR)/Winico$(WINICO_VERSION)/Winico$(subst .,,$(WINICO_VERSION)).a
LIB_THREAD = $(INSTALLDIR)/thread$(THREAD_VERSION)/thread$(THREAD_LIBVER).a
LIB_MKZIPLIB = $(INSTALLDIR)/Mkziplib$(MKZIPLIB_VERSION)/Mkziplib$(MKZIPLIB_SHORT).a
LIB_MEMCHAN = $(INSTALLDIR)/Memchan$(MEMCHAN_VERSION)/memchan$(MEMCHAN_LIBVER).a
LIB_TGDBM = $(INSTALLDIR)/tgdbm$(TGDBM_VERSION)/tgdbm.a
LIB_Z = $(INSTALLDIR)/libz.a
INDEXES= zipdir/lib/base/pkgIndex.tcl zipdir/lib/thread/pkgIndex.tcl \
	zipdir/lib/tgdbm/pkgIndex.tcl mkZiplib-pkgindex memchan-pkgindex
	
ifdef FULL
LIB_OPENSSL = $(INSTALLDIR)/libssl.a $(INSTALLDIR)/libcrypto.a
LIB_TLS = $(INSTALLDIR)/tls$(TLS_VERSION)/tls$(TLS_LIBVER)s.a
LIB_MK4TCL = $(INSTALLDIR)/Mk4tcl/Mk4tcl.lib
LIB_TKTABLE = $(INSTALLDIR)/Tktable$(TKTABLE_VERSION)/Tktable$(subst .,,$(TKTABLE_VERSION)).a
LIB_TKHTML = $(INSTALLDIR)/Tkhtml$(TKHTML_VERSION)/Tkhtml$(TKHTML_LIBVER).a
LIB_SQLITE = $(INSTALLDIR)/sqlite$(SQLITE_VERSION)/sqlite$(SQLITE_LIBVER).a
LIB_SNACK = $(INSTALLDIR)/snack$(SNACK_SHORT)/libsnack.a $(INSTALLDIR)/snack$(SNACK_SHORT)/libsnackstub22.a
INDEXES += metakit-pkgindex \
	snack-pkgindex tls-pkgindex tkhtml-pkgindex sqlite-pkgindex \
	zipdir/lib/Tktable/pkgIndex.tcl
XOTCL = 1
DB = 1
endif

ifdef XOTCL
LIB_XOTCL = $(INSTALLDIR)/xotcl$(XOTCL_LIBVER).a 
LIB_TDOM = $(INSTALLDIR)/tdom$(TDOM_VERSION)/tdom$(TDOM_LIBVER).a
INDEXES += zipdir/lib/tdom/pkgIndex.tcl
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

#
# Winlibs
#
WINLIBS = -L/mingw/lib -lkernel32 -ladvapi32 -luser32 -lgdi32 -lcomdlg32 \
	-lwinspool -lole32 -lshell32 -luuid -limm32 -lcomctl32 -lwsock32 \
	-lstdc++ -lwinmm

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
   $(OPT_MISC) \
   $(OPT_SEL)

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
  $(LIB_WINICO) \
  $(LIB_TKTABLE) \
  $(LIB_TKHTML) \
  $(LIB_SQLITE) \
  $(LIB_SNACK) \
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
SCRIPTS += zipdir/lib/xotclide zipdir/lib/xosql/pkgIndex.tcl
endif

all: static $(FBUILD) $(DISTDIR) $(FBUILD)/null.zip $(FBUILD)/$(WRAPNAME)$(EXE)

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

$(DISTDIR)/$(WRAPNAME)$(EXE): $(FBUILD)/$(WRAPNAME)$(EXE)
	@cp $(FBUILD)/$(WRAPNAME)$(EXE) $(DISTDIR)/$(WRAPNAME)$(EXE)

$(FBUILD)/$(WRAPNAME)$(EXE): $(FBUILD)/$(WRAPNAME)_bare$(EXE) zipdir/freewrap.tcl zipdir/freewrapCmds.tcl $(ZSCRIPTS) $(XOTCL_SCRIPTS) $(INDEXES) $(SCRIPTS)
	@$(RM) $(FBUILD)/$(WRAPNAME)$(EXE)
	@$(CP) $(FBUILD)/$(WRAPNAME)_bare$(EXE) $(FBUILD)/tkwrap.zip
	@$(CAT) $(FBUILD)/null.zip >> $(FBUILD)/tkwrap.zip
	@$(TCLSH) $(FBSRC)/setinfo.tcl zipdir $(FBUILD)/$(WRAPNAME)$(EXE) $(TKWRAP_VERSION) $(FBUILD)/$(WRAPNAME)_bare$(EXE)
	@$(CP) -f $(FBSRC)/$(ICONFILE) zipdir
	@cd zipdir; pwd; rm -f tk/pkgIndex.tcl; $(ZIP) -rA9 -P `cat $(FBSRC)/currentPWD.txt` $(FBUILD)/tkwrap.zip *; cd ..
	@$(RENAME) $(FBUILD)/tkwrap.zip $(FBUILD)/$(WRAPNAME)$(EXE)

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
	
zipdir/lib/xosql/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(DELTREE) zipdir/lib/xosql
	@$(MKDIR) zipdir/lib/xosql
	@cd $(INSTALLDIR)/xosql && $(CP) -rf *.xotcl *.tcl $(CURDIR)/zipdir/lib/xosql
	@echo "lappend auto_path /lib/xosql" >> zipdir/lib/tcl/init-pkgs.tcl
	
zipdir/lib/base/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/base
	@echo "package ifneeded dde 1.2.4 [list load \"\" dde]" > zipdir/lib/base/pkgIndex.tcl
	@echo "package ifneeded registry 1.1.4 [list load \"\" registry]" >> zipdir/lib/base/pkgIndex.tcl
#ifndef WITHOUT_TK
	@echo "package ifneeded Winico 0.6 [list load \"\" Winico]" >> zipdir/lib/base/pkgIndex.tcl
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
	
metakit-pkgindex: zipdir/lib/tcl/init-pkgs.tcl
	@echo "package ifneeded Mk4tcl $(METAKIT_VERSION) [list load \"\" Mk4tcl]" >> zipdir/lib/base/pkgIndex.tcl
	
memchan-pkgindex: zipdir/lib/tcl/init-pkgs.tcl
	@echo "package ifneeded Memchan $(MEMCHAN_VERSION) [list load \"\" Memchan]" >> zipdir/lib/base/pkgIndex.tcl
	
mkZiplib-pkgindex: zipdir/lib/tcl/init-pkgs.tcl
	@echo "package ifneeded mkZiplib $(MKZIPLIB_VERSION) [list load \"\" mkZiplib]" >> zipdir/lib/base/pkgIndex.tcl

tkhtml-pkgindex: zipdir/lib/tcl/init-pkgs.tcl
	@echo "package ifneeded Tkhtml $(TKHTML_VERSION) [list load \"\" Tkhtml]" >> zipdir/lib/base/pkgIndex.tcl	
	
sqlite-pkgindex: zipdir/lib/tcl/init-pkgs.tcl
	@echo "package ifneeded sqlite3 $(SQLITE_VERSION) [list load \"\" sqlite3]" >> zipdir/lib/base/pkgIndex.tcl
	
snack-pkgindex: zipdir/lib/tcl/init-pkgs.tcl
	@echo "package ifneeded snack 2.2 [list load \"\" snack]" >> zipdir/lib/base/pkgIndex.tcl
	
tls-pkgindex: zipdir/lib/tcl/init-pkgs.tcl
	@echo "package ifneeded tls 1.50 [list load \"\" tls]" >> zipdir/lib/base/pkgIndex.tcl
	
zipdir/lib/Tktable/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/Tktable
	@echo "package ifneeded Tktable $(TKTABLE_VERSION) [list load \"\" Tktable]" > zipdir/lib/Tktable/pkgIndex.tcl
	@cd $(INSTROOT)/lib/Tktable$(TKTABLE_VERSION) && cp tkTable.tcl $(CURDIR)/zipdir/lib/Tktable/tkTable.tcl
	@echo "lappend auto_path /lib/Tktable" >> zipdir/lib/tcl/init-pkgs.tcl
	
zipdir/lib/tile/pkgIndex.tcl: zipdir/lib/tcl/init-pkgs.tcl
	@$(MKDIR) zipdir/lib/tile
	@cd $(INSTROOT)/lib/tile$(TILE_VERSION) && cp *.tcl $(CURDIR)/zipdir/lib/tile
	@echo "package ifneeded tile $(TILE_VERSION) [list load \"\" tile]" > zipdir/lib/tile/pkgIndex.tcl
	@echo "lappend auto_path /lib/tile" >> zipdir/lib/tcl/init-pkgs.tcl
	
zipdir/lib/tkcon: zipdir/lib/tcl/init-pkgs.tcl
	@echo "lappend auto_path /lib/tkcon" >> zipdir/lib/tcl/init-pkgs.tcl
	@$(DELTREE) zipdir/lib/tkcon
	@$(MKDIR) zipdir/lib/tkcon
	@cd $(INSTROOT)/lib/tkcon$(TKCON_VERSION) && cp tkcon.tcl pkgIndex.tcl $(CURDIR)/zipdir/lib/tkcon
	@sed -e 's|"dev"|"$(TKWRAP_VERSION)"|g' $(CURDIR)/patches/tkcon.patch > $(FBUILD)/tkcon.patch
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

wrap: all $(DISTDIR)/$(WRAPNAME)$(EXE)
		
fullwrap:
	@make clean wrap FULL=1

xowrap:
	@make clean wrap XOTCL=1

tkwrap:
	@make clean wrap

tclwrap:
	@make clean wrap WITHOUT_TK=1
	
tkcon:
	@make clean all FULL=1 TKCON=1
	@cp $(FSCRIPTS)/tkcon.tcl $(FBUILD)
	@cd $(FBUILD) && $(WRAPNAME)$(EXE) tkcon.tcl
	@mv $(FBUILD)/tkcon$(EXE) $(DISTDIR)/tkcon$(EXE)

xotclide:
	@make clean all FULL=1 XOTCLIDE=1
	@cp $(FSCRIPTS)/XOTclIDE.tcl $(FBUILD)
	@cd $(FBUILD) && $(WRAPNAME)$(EXE) XOTclIDE.tcl
	@mv $(FBUILD)/XOTclIDE$(EXE) $(DISTDIR)/XOTclIDE$(EXE)
		
$(FBUILD)/tkwrap.res.o: resheader resmanifest
	@cd $(FBSRC) && windres -i $(RESFILE) -I${BUILDDIR}/tk${TCLTK_VERSION}/win/rc -o $(FBUILD)/tkwrap.res.o
	
$(FBUILD)/$(WRAPNAME)_bare$(EXE): $(OBJ) $(LIBS)
	$(CC) $(LFLAGS) -o $(FBUILD)/$(WRAPNAME)_bare$(EXE) $(OBJ) $(LIBS) $(WINLIBS) $(X11_LIB_SWITCHES)
	$(STRIP) $(FBUILD)/$(WRAPNAME)_bare$(EXE)
# Comment out the following line if you do not want to compress the executable file with UPX.
	@[ -x "$(UPX)" ] && "$(UPX)" -9 $(FBUILD)/$(WRAPNAME)_bare$(EXE)

$(FBUILD)/tkwrap.o: $(FBSRC)/main.c
	$(CC) $(CFLAGS) $(OPT) -o $(FBUILD)/tkwrap.o -c $(FBSRC)/main.c

$(FBSRC)/fwcrypt.c: $(FBSRC)/setinfo.tcl
	cd ${FBSRC} && $(TCLSH) setinfo.tcl
	
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
