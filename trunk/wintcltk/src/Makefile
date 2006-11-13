#!/bin/sh
#
# WinTclTk Makefile 
# Copyright (c) 2006 Martin Matuska
#
# $Id$
#
TCLTK_VERSION=8.4.14
XOTCL_VERSION=1.5.2
TCLLIB_VERSION=1.9
TKLIB_VERSION=0.4.1
BWIDGET_VERSION=1.8.0
TWAPI_VERSION=1.0b0
ASED_VERSION=3.0b16
XOTCLIDE_VERSION=0.80

XOTCL_LIBVER=152
XOTCLIDE_FILEVER=0.80-0
TKLIB_SHORT=0.4
ASED_DIR=ased3.0

SOURCEFORGE_MIRROR?=heanet

WGET?=$(shell which wget)
UNZIP?=$(shell which unzip)
CURDIR=$(shell pwd)
PREFIX=${CURDIR}/../build


all: install
build: build-tcl build-tk build-xotcl build-xotclide build-tcllib build-tklib build-bwidget build-twapi build-ased
install: install-tcl install-tk install-xotcl install-xotclide install-tcllib install-tklib install-bwidget install-twapi install-ased
uninstall: uninstall-tcl uninstall-tk uninstall-xotcl uninstall-xotclide uninstall-tcllib uninstall-tklib uninstall-bwidget uninstall-twapi uninstall-ased 
clean: clean-tcl clean-tk clean-xotcl clean-xotclide clean-tcllib clean-tklib clean-bwidget clean-twapi clean-ased
distclean: distclean-tcl distclean-tk distclean-xotcl distclean-xotclide distclean-tcllib distclean-tklib distclean-bwidget distclean-twapi distclean-ased

fetch-tcl: tcl${TCLTK_VERSION}-src.tar.gz 
tcl${TCLTK_VERSION}-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@wget "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcl/tcl${TCLTK_VERSION}-src.tar.gz"

extract-tcl: fetch-tcl tcl${TCLTK_VERSION} 
tcl${TCLTK_VERSION}:
	@md5sum -c md5sums/tcl${TCLTK_VERSION}-src.tar.gz.md5 || exit 1
	@tar xfz tcl${TCLTK_VERSION}-src.tar.gz

configure-tcl: extract-tcl tcl${TCLTK_VERSION}/win/Makefile
tcl${TCLTK_VERSION}/win/Makefile:
	@cd tcl${TCLTK_VERSION}/win && ./configure --prefix=${PREFIX} --enable-shared --enable-threads 

build-tcl: configure-tcl tcl${TCLTK_VERSION}/win/tclsh84.exe
tcl${TCLTK_VERSION}/win/tclsh84.exe:
	@cd tcl${TCLTK_VERSION}/win && make && strip *.exe *.dll

install-tcl: build-tcl ${PREFIX}/lib/tclConfig.sh
${PREFIX}/lib/tclConfig.sh:
	@cd tcl${TCLTK_VERSION}/win && make install

fetch-tk: tk${TCLTK_VERSION}-src.tar.gz 
tk${TCLTK_VERSION}-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@wget "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcl/tk${TCLTK_VERSION}-src.tar.gz"

extract-tk: fetch-tk tk${TCLTK_VERSION} 
tk${TCLTK_VERSION}:
	@md5sum -c md5sums/tk${TCLTK_VERSION}-src.tar.gz.md5 || exit 1
	@tar xfz tk${TCLTK_VERSION}-src.tar.gz

configure-tk: extract-tcl extract-tk tk${TCLTK_VERSION}/win/Makefile 

tk${TCLTK_VERSION}/win/Makefile:
	@cd tk${TCLTK_VERSION}/win && ./configure --prefix=${PREFIX} --enable-shared --enable-threads

build-tk: configure-tk tk${TCLTK_VERSION}/win/wish84.exe 
tk${TCLTK_VERSION}/win/wish84.exe:
	@cd tk${TCLTK_VERSION}/win && make && strip *.exe *.dll

install-tk: build-tk ${PREFIX}/lib/tkConfig.sh 
${PREFIX}/lib/tkConfig.sh:
	@cd tk${TCLTK_VERSION}/win && make install

fetch-xotcl: xotcl-${XOTCL_VERSION}.tar.gz 
xotcl-${XOTCL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@wget "http://media.wu-wien.ac.at/download/xotcl-${XOTCL_VERSION}.tar.gz"

extract-xotcl: fetch-xotcl xotcl-${XOTCL_VERSION} 
xotcl-${XOTCL_VERSION}:
	@md5sum -c md5sums/xotcl-${XOTCL_VERSION}.tar.gz.md5 || exit 1
	@-tar xfz xotcl-${XOTCL_VERSION}.tar.gz

configure-xotcl: install-tcl extract-xotcl xotcl-${XOTCL_VERSION}/Makefile 
xotcl-${XOTCL_VERSION}/Makefile:
	@cd xotcl-${XOTCL_VERSION} && ./configure --prefix=${PREFIX} --enable-shared --enable-threads \
		--with-tcl=${PREFIX}/lib	

build-xotcl: configure-xotcl xotcl-${XOTCL_VERSION}/xotcl${XOTCL_LIBVER}.dll 
xotcl-${XOTCL_VERSION}/xotcl${XOTCL_LIBVER}.dll:
	echo $(XOTCL_SHORT)
	@cd xotcl-${XOTCL_VERSION} && make && strip *.dll

install-xotcl: build-xotcl ${PREFIX}/lib/xotclConfig.sh
${PREFIX}/lib/xotclConfig.sh: 
	@cd xotcl-${XOTCL_VERSION} && make install


fetch-tcllib: tcllib-${TCLLIB_VERSION}.tar.gz 
tcllib-${TCLLIB_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcllib/tcllib-${TCLLIB_VERSION}.tar.gz"

extract-tcllib: fetch-tcllib tcllib-${TCLLIB_VERSION} 
tcllib-${TCLLIB_VERSION}:
	@md5sum -c md5sums/tcllib-${TCLLIB_VERSION}.tar.gz.md5 || exit 1
	@tar xfz tcllib-${TCLLIB_VERSION}.tar.gz

configure-tcllib: install-tcl extract-tcllib tcllib-${TCLLIB_VERSION}/Makefile 
tcllib-${TCLLIB_VERSION}/Makefile:
	@cd tcllib-${TCLLIB_VERSION} && ./configure --prefix=${PREFIX}

build-tcllib: configure-tcllib 

install-tcllib: build-tcllib ${PREFIX}/lib/tcllib${TCLLIB_VERSION}/pkgIndex.tcl 
${PREFIX}/lib/tcllib${TCLLIB_VERSION}/pkgIndex.tcl:
	@cd tcllib-${TCLLIB_VERSION} && make install-libraries

fetch-tklib: tklib-${TKLIB_VERSION}.tar.gz 
tklib-${TKLIB_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcllib/tklib-${TKLIB_VERSION}.tar.gz"

extract-tklib: fetch-tklib tklib-${TKLIB_VERSION} 
tklib-${TKLIB_VERSION}:
	@md5sum -c md5sums/tklib-${TKLIB_VERSION}.tar.gz.md5 || exit 1
	@tar xfz tklib-${TKLIB_VERSION}.tar.gz

configure-tklib: install-tk extract-tklib tklib-${TKLIB_VERSION}/Makefile 
tklib-${TKLIB_VERSION}/Makefile:
	@cd tklib-${TKLIB_VERSION} && ./configure --prefix=${PREFIX}

build-tklib: configure-tklib 

install-tklib: build-tklib ${PREFIX}/lib/tklib${TKLIB_SHORT}/pkgIndex.tcl 
${PREFIX}/lib/tklib${TKLIB_SHORT}/pkgIndex.tcl:
	@cd tklib-${TKLIB_VERSION} && make install-libraries

fetch-bwidget: BWidget-${BWIDGET_VERSION}.tar.gz 
BWidget-${BWIDGET_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcllib/BWidget-${BWIDGET_VERSION}.tar.gz"

extract-bwidget: fetch-bwidget BWidget-${BWIDGET_VERSION} 
BWidget-${BWIDGET_VERSION}:
	@md5sum -c md5sums/BWidget-${BWIDGET_VERSION}.tar.gz.md5 || exit 1
	@tar xfz BWidget-${BWIDGET_VERSION}.tar.gz

configure-bwidget: extract-bwidget
build-bwidget: configure-bwidget
 
install-bwidget: build-bwidget ${PREFIX}/lib/BWidget${BWIDGET_VERSION}/pkgIndex.tcl
${PREFIX}/lib/BWidget${BWIDGET_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/BWidget${BWIDGET_VERSION}
	@cp -Rp BWidget-${BWIDGET_VERSION}/* ${PREFIX}/lib/BWidget${BWIDGET_VERSION}

fetch-twapi: twapi-${TWAPI_VERSION}.zip 
twapi-${TWAPI_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/twapi/twapi-${TWAPI_VERSION}.zip"

extract-twapi: fetch-twapi twapi 
twapi:
	@md5sum -c md5sums/twapi-${TWAPI_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "You require unzip to extract this source. See SOURCES.txt for more information."; exit 1 ) 
	@unzip twapi-${TWAPI_VERSION}.zip

configure-twapi: extract-twapi
build-twapi: configure-twapi

install-twapi: build-twapi ${PREFIX}/lib/twapi${TWAPI_VERSION}/pkgIndex.tcl
${PREFIX}/lib/twapi${TWAPI_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/twapi${TWAPI_VERSION}
	@cp -Rp twapi/* ${PREFIX}/lib/twapi${TWAPI_VERSION}

fetch-ased: ased${ASED_VERSION}.zip 
ased${ASED_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@${WGET} "http://www.mms-forum.de/ased/ased${ASED_VERSION}.zip"

extract-ased: fetch-ased ${ASED_DIR} 
${ASED_DIR}:
	@md5sum -c md5sums/ased${ASED_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "You require unzip to extract this source. See SOURCES.txt for more information."; exit 1 ) 
	@${UNZIP} ased${ASED_VERSION}.zip
	@cd ${ASED_DIR} && patch < ../patches/ased${ASED_VERSION}.patch

configure-ased: extract-ased
build-ased: configure-ased

install-ased: build-ased ${PREFIX}/${ASED_DIR}/ased.tcl
${PREFIX}/${ASED_DIR}/ased.tcl:
	@cp -Rp ${ASED_DIR} ${PREFIX}

fetch-xotclide: xotclIDE-${XOTCLIDE_FILEVER}.tar.gz xotclide_doc.tar.gz 
xotclIDE-${XOTCLIDE_FILEVER}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@wget "http://www.xdobry.de/xotclIDE/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz"
xotclide_doc.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@wget "http://www.xdobry.de/xotclIDE/xotclide_doc.tar.gz"

extract-xotclide: fetch-xotclide xotclide-${XOTCLIDE_VERSION} 
xotclide-${XOTCLIDE_VERSION}:
	@md5sum -c md5sums/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz.md5 || exit 1
	@md5sum -c md5sums/xotclide_doc.tar.gz.md5 || exit 1
	@-tar xfz xotclIDE-${XOTCLIDE_FILEVER}.tar.gz
	@-cd xotclide-${XOTCLIDE_VERSION}/docs && tar xfz ../../xotclide_doc.tar.gz 

configure-xotclide: install-xotcl extract-xotclide 
build-xotclide: configure-xotclide

install-xotclide: build-xotclide ${PREFIX}/lib/xotclIDE
${PREFIX}/lib/xotclIDE:
	@cd xotclide-${XOTCLIDE_VERSION} && rm -f install && make install PREFIX=${PREFIX}

uninstall-tcl:
	@-cd ${PREFIX}/bin && rm tcl*.dll tclsh*.exe
	@-cd ${PREFIX}/lib && rm -rf dde1.2 libtclstub*.a tcl* libtcl*.a reg1.1 tclConfig.sh
	@-cd ${PREFIX}/include && rm tclDecls.h tcl.h tclPlatDecls.h

uninstall-tk:
	@-cd ${PREFIX}/bin && rm tk*.dll wish*.exe
	@-cd ${PREFIX}/lib && rm -rf tk* libtk*.a libtkstub*.a tkConfig.shi
	@-cd ${PREFIX}/include && rm -rf X11 tk.h tkDecls.h tkIntXlibDecls.h tkPlatDecls.h 

uninstall-xotcl:
	@-cd ${PREFIX}/lib && rm -rf xotcl${XOTCL_VERSION} xotcl*.dll xotclConfig.sh
	@-cd ${PREFIX}/include && rm xotcl.h xotclDecls.h xotclInt.h xotclIntDecls.h

uninstall-tcllib:
	@-cd ${PREFIX}/lib && rm -rf tcllib${TCLLIB_VERSION}

uninstall-tklib:
	@-cd ${PREFIX}/lib && rm -rf tklib${TKLIB_VERSION}

uninstall-BWidget:
	@-cd ${PREFIX}/lib && rm -rf BWidget${BWIDGET_VERSION}

uninstall-twapi:
	@-cd ${PREFIX}/lib && rm -rf twapi${TWAPI_VERSION}

uninstall-ased:
	@-cd ${PREFIX} && rm -rf ${ASED_DIR}

uninstall-xotclide:
	@-cd ${PREFIX} && rm -rf lib/xotclIDE

clean-tcl:
	@-cd tcl${TCLTK_VERSION}/win && make clean

distclean-tcl:
	@-rm -rf tcl${TCLTK_VERSION}

clean-tk:
	@-cd tk${TCLTK_VERSION}/win && make clean

distclean-tk:
	@-rm -rf tk${TCLTK_VERSION}

clean-xotcl:
	@-cd xotcl-${XOTCL_VERSION} && make clean 

distclean-xotcl:
	@-rm -rf xotcl-${XOTCL_VERSION}

clean-tcllib:
	@-cd tcllib-${TCLLIB_VERSION} && make clean

distclean-tcllib:
	@-rm -rf tcllib-${TCLLIB_VERSION}

clean-tklib:
	@-cd tklib-${TKLIB_VERSION} && make clean

distclean-tklib:
	@-rm -rf tklib-${TKLIB_VERSION}

clean-bwidget:

distclean-bwidget:
	@-rm -rf BWidget-${BWIDGET_VERSION}

clean-twapi:

distclean-twapi:
	@-rm -rf twapi

clean-ased:

distclean-ased:
	@-rm -rf ${ASED_DIR}

clean-xotclide:

distclean-xotclide:
	@-rm -rf xotclIDE-${XOTCLIDE_VERSION}
