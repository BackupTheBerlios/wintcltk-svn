#!/bin/sh
#
# WinTclTk Makefile 
# Copyright (c) 2006 Martin Matuska
#
# $Id$
#
WINTCLTK_VERSION=0.1
#
INSTALLER=WinTclTk-MinGW-${WINTCLTK_VERSION}.exe
#
MAKENSIS?=${PROGRAMFILES}/NSIS/makensis.exe

all: installer
build:
	@cd src && make build
install:
	@cd src && make install
uninstall:
	@cd src && make uninstall
clean:
	@cd src && make clean
distclean:
	@cd src && make distclean
tcl:
	@cd src && make install-tcl
tk:
	@cd src && make install-tk
xotcl:
	@cd src && make install-xotcl
tcllib:
	@cd src && make install-tcllib
tklib:
	@cd src && make install-tklib
bwidget:
	@cd src && make install-bwidget
twapi:
	@cd src && make install-twapi
ased:
	@cd src && make install-ased

installer: install ${INSTALLER}
${INSTALLER}:
	@[ -x ${MAKENSIS} ] || ( echo "Counld not find ${MAKENSIS}, please install NSIS or point the MAKENSIS environment variable to makensis.exe"; exit 1 ) 
	@cd installer && ${MAKENSIS} //DOUTFILE=\"..\\${INSTALLER}\" wintcltk.nsi \

clean-installer:
	-rm ${INSTALLER}
