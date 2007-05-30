# WinTclTk Makefile 
# Copyright (c) 2006-07 Martin Matuska
#
# $Id$
#
CURDIR=	$(shell pwd)
SRCDIR=	$(CURDIR)/src
FREEWRAPDIR=	$(CURDIR)/freewrap
#
include $(SRCDIR)/defs/defs.mak
include $(SRCDIR)/defs/tools.mak
#
WINTCLTK_VERSION=0.5.1
#
INSTALLER=WinTclTk-${WINTCLTK_VERSION}.exe
#
MAKENSIS?=	"${PROGRAMFILES}/NSIS/makensis.exe"
#
BUILDDIR?=	"${CURDIR}/src/build"
PREFIX?=	"${CURDIR}/src/instroot"
MAKE_ENV=	PREFIX="${PREFIX}" BUILDDIR="${BUILDDIR}"

ifdef USE_UPX
UPXDEF=		//DUSE_UPX=1
endif

all: installer fw
build:
	@cd src && make build ${MAKE_ENV}
install:
	@cd src && make install ${MAKE_ENV}
uninstall:
	@cd src && make uninstall ${MAKE_ENV}
clean:
	@cd src && make clean ${MAKE_ENV}
buildclean:
	@cd src && make buildclean ${MAKE_ENV}
sourceclean:
	@rm -rf wintcltk-${WINTCLTK_VERSION} wintcltk-${WINTCLTK_VERSION}-src.tar.gz wintcltk-${WINTCLTK_VERSION}-src.zip
installerclean:
	@rm -f ${INSTALLER} 
releaseclean: sourceclean installerclean
distclean: releaseclean buildclean 
	@cd src && make distclean ${MAKE_ENV}
allclean: distclean
	@cd src && make allclean ${MAKE_ENV}

installer: install ${INSTALLER}
${INSTALLER}:
	@[ -x ${MAKENSIS} ] || ( echo "Counld not find ${MAKENSIS}, please install NSIS or point the MAKENSIS environment variable to makensis.exe"; exit 1 ) 
	@INSTROOT=`cd ${PREFIX} && pwd -W | sed -e 's,/,\\\\,g'`;\
	 BUILDDIR=`cd ${BUILDDIR} && pwd -W | sed -e 's,/,\\\\,g'`;\
		cd installer && ${MAKENSIS} $(UPXDEF) //DVERSION=${WINTCLTK_VERSION} //DOUTFILE=\"..\\${INSTALLER}\" //DINSTROOT="$${INSTROOT}" //DBUILDDIR="$${BUILDDIR}" wintcltk.nsi

static:
	@cd $(SRCDIR) && make STATIC_BUILD=1
		
fw: wintcltk-fw-$(WINTCLTK_FW_VERSION).zip

$(FREEWRAPDIR)/dist/std/freewrap.exe: static
	@cd $(FREEWRAPDIR) && make clean && make

$(FREEWRAPDIR)/dist/xotcl/freewrap.exe:	static
	@cd $(FREEWRAPDIR) && make clean DIST=xotcl && make DIST=xotcl

$(FREEWRAPDIR)/dist/full/freewrap.exe: static
	@cd $(FREEWRAPDIR) && make clean DIST=full && make DIST=full

wintcltk-fw-$(WINTCLTK_FW_VERSION).zip: $(FREEWRAPDIR)/dist/std/freewrap.exe $(FREEWRAPDIR)/dist/xotcl/freewrap.exe $(FREEWRAPDIR)/dist/full/freewrap.exe
	@cd $(FREEWRAPDIR)/dist && $(ZIP) -r $(CURDIR)/wintcltk-fw-$(WINTCLTK_FW_VERSION).zip std/freewrap.exe xotcl/freewrap.exe full/freewrap.exe
	@cd $(FREEWRAPDIR)/doc && $(ZIP) $(CURDIR)/wintcltk-fw-$(WINTCLTK_FW_VERSION).zip README.txt ChangeLog.txt
		
release: installer wintcltk-${WINTCLTK_VERSION}-src.tar.gz wintcltk-${WINTCLTK_VERSION}-src.zip

wintcltk-${WINTCLTK_VERSION}:
	@mkdir -p wintcltk-${WINTCLTK_VERSION}
	@cd wintcltk-${WINTCLTK_VERSION} && mkdir -p src/patches src/defs src/md5sums doc/licenses
	@cp Makefile wintcltk-${WINTCLTK_VERSION}
	@cp -rf src/Makefile wintcltk-${WINTCLTK_VERSION}/src
	@cp -rf src/defs/*.mak wintcltk-${WINTCLTK_VERSION}/src/defs
	@cp -rf src/md5sums/*.md5 wintcltk-${WINTCLTK_VERSION}/src/md5sums
	@cp -rf src/patches/*.patch wintcltk-${WINTCLTK_VERSION}/src/patches
	@cp doc/*.txt doc/*.htm wintcltk-${WINTCLTK_VERSION}/doc
	@cp doc/licenses/*.txt wintcltk-${WINTCLTK_VERSION}/doc/licenses

wintcltk-${WINTCLTK_VERSION}-src.tar.gz: wintcltk-${WINTCLTK_VERSION}
	@tar cz --exclude CVS -f wintcltk-${WINTCLTK_VERSION}-src.tar.gz wintcltk-${WINTCLTK_VERSION}

wintcltk-${WINTCLTK_VERSION}-src.zip: wintcltk-${WINTCLTK_VERSION} install-zip
	@zip -r wintcltk-${WINTCLTK_VERSION}-src.zip wintcltk-${WINTCLTK_VERSION} -x '*/CVS/*' > /dev/null 2>&1

