#!/bin/sh
#
# WinTclTk Makefile 
# Copyright (c) 2006 Martin Matuska
#
# $Id$
#
WINTCLTK_VERSION=0.2.2
#
INSTALLER=WinTclTk-MinGW-${WINTCLTK_VERSION}.exe
#
MAKENSIS?=${PROGRAMFILES}/NSIS/makensis.exe
ZIP?=$(shell which zip)

all: installer 
build:
	@cd src && make build
install:
	@cd src && make install
uninstall:
	@cd src && make uninstall
clean:
	@cd src && make clean
buildclean:
	@rm -rf build
sourceclean:
	@rm -rf wintcltk-${WINTCLTK_VERSION} wintcltk-${WINTCLTK_VERSION}.tar.gz wintcltk-${WINTCLTK_VERSION}.zip
installerclean:
	@rm -f ${INSTALLER} 
releaseclean: sourceclean installerclean
distclean: releaseclean buildclean 
	@cd src && make distclean
allclean: distclean
	@cd src && make allclean

installer: install ${INSTALLER}
${INSTALLER}:
	@[ -x ${MAKENSIS} ] || ( echo "Counld not find ${MAKENSIS}, please install NSIS or point the MAKENSIS environment variable to makensis.exe"; exit 1 ) 
	@cd installer && ${MAKENSIS} //DVERSION=${WINTCLTK_VERSION} //DOUTFILE=\"..\\${INSTALLER}\" wintcltk.nsi \

release: installer wintcltk-${WINTCLTK_VERSION}.tar.gz wintcltk-${WINTCLTK_VERSION}.zip

wintcltk-${WINTCLTK_VERSION}:
	@mkdir -p wintcltk-${WINTCLTK_VERSION}/src
	@cp -rf BUILD-* SOURCES.* Makefile doc wintcltk-${WINTCLTK_VERSION}
	@cp -rf src/Makefile src/md5sums src/patches wintcltk-${WINTCLTK_VERSION}/src 


wintcltk-${WINTCLTK_VERSION}.tar.gz: wintcltk-${WINTCLTK_VERSION}
	@tar cz --exclude CVS -f wintcltk-${WINTCLTK_VERSION}.tar.gz wintcltk-${WINTCLTK_VERSION}

wintcltk-${WINTCLTK_VERSION}.zip: wintcltk-${WINTCLTK_VERSION}
	@[ -x "${ZIP}" ] || ( echo "You require zip to create the source release in zip format. See SOURCES.txt for more information."; exit 1 ) 
	@zip -r wintcltk-${WINTCLTK_VERSION}.zip wintcltk-${WINTCLTK_VERSION} -x '*/CVS/*' > /dev/null 2>&1

