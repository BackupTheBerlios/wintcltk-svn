#!/bin/sh
#
# WinTclTk Makefile 
# Copyright (c) 2006 Martin Matuska
#
# $Id$
#
CURDIR=	$(shell pwd)
SRCDIR=	$(CURDIR)/src
#
include $(SRCDIR)/defs/defs.mak
#
WINTCLTK_VERSION=0.4.1
#
INSTALLER=WinTclTk-MinGW-${WINTCLTK_VERSION}.exe
#
MAKENSIS?=	"${PROGRAMFILES}/NSIS/makensis.exe"
#
BUILDDIR?=	"${CURDIR}/src/build"
PREFIX?=	"${CURDIR}/src/instroot"
MAKE_ENV=	PREFIX="${PREFIX}" BUILDDIR="${BUILDDIR}"

all: installer 
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
		cd installer && ${MAKENSIS} //DVERSION=${WINTCLTK_VERSION} //DOUTFILE=\"..\\${INSTALLER}\" //DINSTROOT="$${INSTROOT}" //DBUILDDIR="$${BUILDDIR}" wintcltk.nsi

release: installer wintcltk-${WINTCLTK_VERSION}-src.tar.gz wintcltk-${WINTCLTK_VERSION}-src.zip

wintcltk-${WINTCLTK_VERSION}:
	@mkdir -p wintcltk-${WINTCLTK_VERSION}
	@cd wintcltk-${WINTCLTK_VERSION} && mkdir -p src/md5sums src/patches doc/licenses
	@cp Makefile wintcltk-${WINTCLTK_VERSION}
	@cp src/Makefile wintcltk-${WINTCLTK_VERSION}/src
	@cp src/md5sums/*.md5 wintcltk-${WINTCLTK_VERSION}/src/md5sums
	@cp src/patches/*.patch wintcltk-${WINTCLTK_VERSION}/src/patches 
	@cp doc/*.txt doc/*.htm wintcltk-${WINTCLTK_VERSION}/doc
	@cp doc/licenses/*.txt wintcltk-${WINTCLTK_VERSION}/doc/licenses

wintcltk-${WINTCLTK_VERSION}-src.tar.gz: wintcltk-${WINTCLTK_VERSION}
	@tar cz --exclude CVS -f wintcltk-${WINTCLTK_VERSION}-src.tar.gz wintcltk-${WINTCLTK_VERSION}

wintcltk-${WINTCLTK_VERSION}-src.zip: wintcltk-${WINTCLTK_VERSION}
	@[ -x "${ZIP}" ] || ( echo "You require zip to create the source release in zip format. See BUILD-MinGW.txt for more information."; exit 1 ) 
	@zip -r wintcltk-${WINTCLTK_VERSION}-src.zip wintcltk-${WINTCLTK_VERSION} -x '*/CVS/*' > /dev/null 2>&1

