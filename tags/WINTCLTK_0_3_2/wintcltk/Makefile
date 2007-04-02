#!/bin/sh
#
# WinTclTk Makefile 
# Copyright (c) 2006 Martin Matuska
#
# $Id$
#
WINTCLTK_VERSION=0.3.2
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
	@[ -x "${ZIP}" ] || ( echo "You require zip to create the source release in zip format. See SOURCES.txt for more information."; exit 1 ) 
	@zip -r wintcltk-${WINTCLTK_VERSION}-src.zip wintcltk-${WINTCLTK_VERSION} -x '*/CVS/*' > /dev/null 2>&1

