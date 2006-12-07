#!/bin/sh
#
# WinTclTk Makefile 
# Copyright (c) 2006 Martin Matuska
#
# $Id$
#
TCLTK_VERSION=8.4.14
XOTCL_VERSION=1.5.3
TCLLIB_VERSION=1.9
TKLIB_VERSION=0.4.1
BWIDGET_VERSION=1.8.0
TWAPI_VERSION=1.0.2
ASED_VERSION=3.0b16
XOTCLIDE_VERSION=0.80
MKZIPLIB_VERSION=1.0
TGDBM_VERSION=0.5
METAKIT_VERSION=2.4.9.6
MYSQLTCL_VERSION=3.02
PGTCL_VERSION=1.5.3

XOTCL_LIBVER=153
XOTCLIDE_FILEVER=0.80-0
TKLIB_SHORT=0.4
PGTCL_DOCVER=20060909
MKZIPLIB_SHORT=10
ASED_DIR=ased3.0

GDBM_VERSION=1.8.3
GDBM_LIVBER=183

SOURCEFORGE_MIRROR?=heanet
GNU_MIRROR?=ftp.gnu.org/pub/gnu

WGET?=$(shell which wget)
UNZIP?=$(shell which unzip)
ZLIB?=$(shell which zlib1.dll)
CURDIR=$(shell pwd)
PREFIX=${CURDIR}/../build

MESSAGE_WGET="You require wget to auto-download the sources. See SOURCES.txt for more information."
MESSAGE_UNZIP="You require unzip to extract this source. See SOURCES.txt for more information."

all: install
install: install-tcl install-tk install-gdbm install-xotcl install-tgdbm install-metakit install-mysqltcl install-pgtcl install-xotclide install-tcllib install-tklib install-bwidget install-mkziplib install-twapi install-ased
uninstall: uninstall-tcl uninstall-tk uninstall-xotcl uninstall-tgdbm uninstall-gdbm uninstall-metakit uninstall-mysqlctl uninstall-pgtcl uninstall-xotclide uninstall-tcllib uninstall-tklib uninstall-bwidget uninstall-mkziplib uninstall-twapi uninstall-ased 
clean: clean-tcl clean-tk clean-xotcl clean-tgdbm clean-gdbm clean-metakit clean-mysqltcl clean-pgtcl clean-xotclide clean-tcllib clean-tklib clean-bwidget clean-mkziplib clean-twapi clean-ased
distclean: distclean-tcl distclean-tk distclean-xotcl distclean-tgdbm distclean-gdbm distclean-metakit distclean-mysqltcl distclean-pgtcl distclean-xotclide distclean-tcllib distclean-tklib distclean-bwidget distclean-mkziplib distclean-twapi distclean-ased
allclean: distclean
	@rm *.tar.gz *.zip *.htm *.html

fetch-tcl: tcl${TCLTK_VERSION}-src.tar.gz 
tcl${TCLTK_VERSION}-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
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
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
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

fetch-gdbm: gdbm-${GDBM_VERSION}.tar.gz 
gdbm-${GDBM_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@wget "ftp://${GNU_MIRROR}/gdbm/gdbm-${GDBM_VERSION}.tar.gz"

extract-gdbm: fetch-gdbm gdbm-${GDBM_VERSION}/win32
gdbm-${GDBM_VERSION}/win32:
	@md5sum -c md5sums/gdbm-${GDBM_VERSION}.tar.gz.md5 || exit 1
	@-tar xfz gdbm-${GDBM_VERSION}.tar.gz
	@patch -p0 < patches/gdbm.patch

configure-gdbm: extract-gdbm

build-gdbm: configure-gdbm gdbm-${GDBM_VERSION}/win32/shlib/gdbm.dll 
gdbm-${GDBM_VERSION}/win32/shlib/gdbm.dll:
	@cd gdbm-${GDBM_VERSION}/win32 && make && strip shlib/*.dll

install-gdbm: build-gdbm ${PREFIX}/bin/gdbm.dll
${PREFIX}/bin/gdbm.dll: 
	@cd gdbm-${GDBM_VERSION}/win32 && make install prefix=$(PREFIX)

fetch-tgdbm: tgdbm${TGDBM_VERSION}.zip 
tgdbm${TGDBM_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@wget "http://www.vogel-nest.de/wiki/uploads/Main/tgdbm${TGDBM_VERSION}.zip"

extract-tgdbm: fetch-tgdbm tgdbm${TGDBM_VERSION}
tgdbm${TGDBM_VERSION}:
	@md5sum -c md5sums/tgdbm${TGDBM_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@unzip tgdbm$(TGDBM_VERSION).zip
	@cd tgdbm$(TGDBM_VERSION) && rm tgdbm.dll

configure-tgdbm: extract-tgdbm

build-tgdbm: configure-tgdbm tgdbm$(TGDBM_VERSION)/tgdbm.dll 
tgdbm${TGDBM_VERSION}/tgdbm.dll:
	@cd tgdbm${TGDBM_VERSION} && make -f Makefile.mingw TCL=$(PREFIX) GDBM_LIB_DIR=$(PREFIX)/bin GDBM_DIR=$(PREFIX)/include GDBM_WINDIR=$(PREFIX)/include && strip *.dll

install-tgdbm: build-tgdbm ${PREFIX}/lib/tgdbm$(TGDBM_VERSION)
${PREFIX}/lib/tgdbm$(TGDBM_VERSION):
	@mkdir -p $(PREFIX)/lib/tgdbm$(TGDBM_VERSION)
	@cd tgdbm$(TGDBM_VERSION) && cp tgdbm.dll qgdbm.tcl $(PREFIX)/lib/tgdbm$(TGDBM_VERSION)
	@echo 'package ifneeded tgdbm' $(TGDBM_VERSION) '[list load [file join $$dir tgdbm.dll] tgdbm]' > $(PREFIX)/lib/tgdbm$(TGDBM_VERSION)/pkgIndex.tcl

fetch-xotcl: xotcl-${XOTCL_VERSION}.tar.gz 
xotcl-${XOTCL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@wget "http://media.wu-wien.ac.at/download/xotcl-${XOTCL_VERSION}.tar.gz"

extract-xotcl: fetch-xotcl xotcl-${XOTCL_VERSION} 
xotcl-${XOTCL_VERSION}:
	@md5sum -c md5sums/xotcl-${XOTCL_VERSION}.tar.gz.md5 || exit 1
	@-tar xfz xotcl-${XOTCL_VERSION}.tar.gz
	@cd xotcl-${XOTCL_VERSION} && patch -p1 < ../patches/xotcl.patch
	@cd xotcl-${XOTCL_VERSION} && autoconf
	@cd xotcl-${XOTCL_VERSION}/library/xml/TclExpat-1.1 && autoconf

configure-xotcl: install-tcl install-gdbm extract-xotcl xotcl-${XOTCL_VERSION}/Makefile 
xotcl-${XOTCL_VERSION}/Makefile:
	@cd xotcl-${XOTCL_VERSION} && ./configure --prefix=${PREFIX} --enable-shared --enable-threads \
		--with-tcl=${PREFIX}/lib --with-actiweb --with-gdbm=${PREFIX}/include,${PREFIX}/bin	

build-xotcl: configure-xotcl xotcl-${XOTCL_VERSION}/xotcl${XOTCL_LIBVER}.dll 
xotcl-${XOTCL_VERSION}/xotcl${XOTCL_LIBVER}.dll:
	echo $(XOTCL_SHORT)
	@cd xotcl-${XOTCL_VERSION} && make && strip *.dll library/*/*/*.dll

install-xotcl: build-xotcl ${PREFIX}/lib/xotclConfig.sh
${PREFIX}/lib/xotclConfig.sh: 
	@cd xotcl-${XOTCL_VERSION} && make install

fetch-metakit: metakit-${METAKIT_VERSION}.tar.gz mk4tcl.html 
metakit-${METAKIT_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@wget "http://www.equi4.com/pub/mk/metakit-${METAKIT_VERSION}.tar.gz"
mk4tcl.html:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@wget -O mk4tcl.html "http://www.equi4.com/metakit/tcl.html"

extract-metakit: fetch-metakit metakit-${METAKIT_VERSION}
metakit-${METAKIT_VERSION}:
	@md5sum -c md5sums/metakit-${METAKIT_VERSION}.tar.gz.md5 || exit 1
	@-tar xfz metakit-${METAKIT_VERSION}.tar.gz
	@patch -p0 < patches/metakit.patch

configure-metakit: extract-metakit metakit-${METAKIT_VERSION}/unix/Makefile
metakit-${METAKIT_VERSION}/unix/Makefile:
	@cd metakit-${METAKIT_VERSION}/unix && ./configure --prefix=${PREFIX} --libdir=${PREFIX}/bin --with-tcl=${PREFIX}/include --enable-threads

build-metakit: configure-metakit metakit-${METAKIT_VERSION}/unix/Mk4tcl.dll 
metakit-${METAKIT_VERSION}/unix/Mk4tcl.dll:
	@cd metakit-${METAKIT_VERSION}/unix && make && strip *.dll

install-metakit: build-metakit ${PREFIX}/lib/Mk4tcl/Mk4tcl.dll
${PREFIX}/lib/Mk4tcl/Mk4tcl.dll: 
	@cd metakit-${METAKIT_VERSION}/unix && make install 
	@cp mk4tcl.html ${PREFIX}/lib/Mk4tcl

fetch-tcllib: tcllib-${TCLLIB_VERSION}.tar.gz 
tcllib-${TCLLIB_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
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
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
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
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
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
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/twapi/twapi-${TWAPI_VERSION}.zip"

extract-twapi: fetch-twapi twapi 
twapi:
	@md5sum -c md5sums/twapi-${TWAPI_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@unzip twapi-${TWAPI_VERSION}.zip

configure-twapi: extract-twapi
build-twapi: configure-twapi

install-twapi: build-twapi ${PREFIX}/lib/twapi${TWAPI_VERSION}/pkgIndex.tcl
${PREFIX}/lib/twapi${TWAPI_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/twapi${TWAPI_VERSION}
	@cp -Rp twapi/* ${PREFIX}/lib/twapi${TWAPI_VERSION}

fetch-mysqltcl: mysqltcl-${MYSQLTCL_VERSION}.zip mysqltcl.html
mysqltcl-${MYSQLTCL_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} "http://www.xdobry.de/mysqltcl/mysqltcl-${MYSQLTCL_VERSION}.zip"
mysqltcl.html:
	@${WGET} "http://www.xdobry.de/mysqltcl/mysqltcl.html"
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
 
extract-mysqltcl: fetch-mysqltcl mysqltcl-${MYSQLTCL_VERSION} 
mysqltcl-${MYSQLTCL_VERSION}:
	@md5sum -c md5sums/mysqltcl-${MYSQLTCL_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@unzip mysqltcl-${MYSQLTCL_VERSION}.zip

configure-mysqltcl: extract-mysqltcl
build-mysqltcl: configure-mysqltcl

install-mysqltcl: build-mysqltcl ${PREFIX}/lib/mysqltcl${MYSQLTCL_VERSION}/pkgIndex.tcl
${PREFIX}/lib/mysqltcl${MYSQLTCL_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/mysqltcl${MYSQLTCL_VERSION}
	@cp -Rp mysqltcl.html mysqltcl-${MYSQLTCL_VERSION}/* ${PREFIX}/lib/mysqltcl${MYSQLTCL_VERSION}

fetch-pgtcl: pgtcl${PGTCL_VERSION}-win32.zip pgtcldocs-${PGTCL_DOCVER}.zip 
pgtcl${PGTCL_VERSION}-win32.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} "http://pgfoundry.org/frs/download.php/1074/pgtcl1.5.3-win32.zip"
pgtcldocs-${PGTCL_DOCVER}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@${WGET} "http://pgfoundry.org/frs/download.php/1073/pgtcldocs-20060909.zip"

extract-pgtcl: fetch-pgtcl pgtcl${PGTCL_VERSION}-win32 pgtcldocs-${PGTCL_DOCVER}
pgtcl${PGTCL_VERSION}-win32:
	@md5sum -c md5sums/pgtcl${PGTCL_VERSION}-win32.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@unzip pgtcl${PGTCL_VERSION}-win32.zip
pgtcldocs-${PGTCL_DOCVER}:
	@md5sum -c md5sums/pgtcldocs-${PGTCL_DOCVER}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@unzip pgtcldocs-${PGTCL_DOCVER}.zip

configure-pgtcl: extract-pgtcl
build-pgtcl: configure-pgtcl

install-pgtcl: build-pgtcl ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/pkgIndex.tcl
${PREFIX}/lib/pgtcl${PGTCL_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/docs
	@cp -Rp pgtcl${PGTCL_VERSION}-win32/* ${PREFIX}/lib/pgtcl${PGTCL_VERSION}
	@cp -Rp pgtcldocs-${PGTCL_DOCVER}/* ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/docs

fetch-ased: ased${ASED_VERSION}.zip 
ased${ASED_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} "http://www.mms-forum.de/ased/ased${ASED_VERSION}.zip"

extract-ased: fetch-ased ${ASED_DIR} 
${ASED_DIR}:
	@md5sum -c md5sums/ased${ASED_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@${UNZIP} ased${ASED_VERSION}.zip
	@patch -p0 < patches/ased${ASED_VERSION}.patch

configure-ased: extract-ased
build-ased: configure-ased

install-ased: build-ased ${PREFIX}/${ASED_DIR}/ased.tcl
${PREFIX}/${ASED_DIR}/ased.tcl:
	@cp -Rp ${ASED_DIR} ${PREFIX}

fetch-xotclide: xotclIDE-${XOTCLIDE_FILEVER}.tar.gz xotclide_doc.tar.gz 
xotclIDE-${XOTCLIDE_FILEVER}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
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

fetch-mkziplib: mkziplib${MKZIPLIB_SHORT}.zip
mkziplib${MKZIPLIB_SHORT}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@wget "http://mkextensions.sourceforge.net/mkZiplib${MKZIPLIB_SHORT}.zip"

extract-mkziplib: fetch-mkziplib mkZiplib${MKZIPLIB_VERSION}/Makefile
mkZiplib${MKZIPLIB_VERSION}/Makefile:
	@md5sum -c md5sums/mkZiplib${MKZIPLIB_SHORT}.zip.md5 || exit 1
	@unzip mkZiplib${MKZIPLIB_SHORT}.zip
	@-cd mkZiplib${MKZIPLIB_VERSION} && rm -f *.dll *.exe
	@-cd mkZiplib${MKZIPLIB_VERSION} && patch -p1 < ../patches/mkZiplib.patch

configure-mkziplib: extract-mkziplib

build-mkziplib: configure-mkziplib mkZiplib${MKZIPLIB_VERSION}/mkZiplib${MKZIPLIB_SHORT}.dll 
mkZiplib${MKZIPLIB_VERSION}/mkZiplib${MKZIPLIB_SHORT}.dll:
	@cd mkZiplib${MKZIPLIB_VERSION} && make strip

install-mkziplib: build-mkziplib ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/pkgIndex.tcl
${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}
	@cp ${ZLIB} ${PREFIX}/bin
	@cd mkZiplib${MKZIPLIB_VERSION} && cp pkgIndex.tcl mkZiplib${MKZIPLIB_SHORT}.dll ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}
	@cd mkZiplib${MKZIPLIB_VERSION} && cp mkZiplib${MKZIPLIB_SHORT}.htm ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/mkZiplib.htm

uninstall-tcl:
	@-cd ${PREFIX}/bin && rm tcl*.dll tclsh*.exe
	@-cd ${PREFIX}/lib && rm -rf dde1.2 libtclstub*.a tcl* libtcl*.a reg1.1 tclConfig.sh
	@-cd ${PREFIX}/include && rm tclDecls.h tcl.h tclPlatDecls.h

uninstall-tk:
	@-cd ${PREFIX}/bin && rm tk*.dll wish*.exe
	@-cd ${PREFIX}/lib && rm -rf tk* libtk*.a libtkstub*.a tkConfig.shi
	@-cd ${PREFIX}/include && rm -rf X11 tk.h tkDecls.h tkIntXlibDecls.h tkPlatDecls.h 

uninstall-xotcl: uninstall-gdbm
	@-cd ${PREFIX}/lib && rm -rf xotcl${XOTCL_VERSION} xotcl*.dll xotclConfig.sh
	@-cd ${PREFIX}/include && rm xotcl.h xotclDecls.h xotclInt.h xotclIntDecls.h

uninstall-gdbm:
	@-cd ${PREFIX} && rm -rf bin/gdbm.dll include/dbm.h include/gdbm.h include/ndbm.h lib/gdbm.a

uninstall-tgdbm:
	@-cd ${PREFIX} && rm -rf lib/tgdbm$(TGDBM_VERSION)

uninstall-metakit:
	@-cd ${PREFIX} && rm -rf bin/libmk4.dll include/mk4* lib/Mk4tcl 

uninstall-tcllib:
	@-cd ${PREFIX}/lib && rm -rf tcllib${TCLLIB_VERSION}

uninstall-tklib:
	@-cd ${PREFIX}/lib && rm -rf tklib${TKLIB_VERSION}

uninstall-BWidget:
	@-cd ${PREFIX}/lib && rm -rf BWidget${BWIDGET_VERSION}

uninstall-twapi:
	@-cd ${PREFIX}/lib && rm -rf twapi${TWAPI_VERSION}

uninstall-mysqltcl:
	@-cd ${PREFIX}/lib && rm -rf mysqltcl${MYSQLTCL_VERSION}

uninstall-pgtcl:
	@-cd ${PREFIX}/lib && rm -rf pgtcl${PGTCL_VERSION}

uninstall-ased:
	@-cd ${PREFIX} && rm -rf ${ASED_DIR}

uninstall-xotclide:
	@-cd ${PREFIX} && rm -rf lib/xotclIDE

uninstall-mkziplib:
	@-cd ${PREFIX} && rm -rf bin/zlib1.dll lib/mkZiplib${MKZIPLIB_VERSION}

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

clean-tgdbm:
	@-cd tgdbm$(TGDBM_VERSION) && rm -rf mingw_release tgdbm.dll

distclean-tgdbm:
	@-rm -rf tgdbm$(TGDBM_VERSION)

clean-gdbm:
	@-cd gdbm-${GDBM_VERSION}/win32 && make clean

distclean-gdbm:
	@-rm -rf gdbm-${GDBM_VERSION}

clean-metakit:
	@-cd metakit-${METAKIT_VERSION}/unix && make clean

distclean-metakit:
	@-rm -rf metakit-${METAKIT_VERSION}

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

clean-mysqltcl:

distclean-mysqltcl:
	@-rm -rf mysqltcl-${MYSQLTCL_VERSION}

clean-pgtcl:

distclean-pgtcl:
	@-rm -rf pgtcl${PG_VERSION} pgtcldocs-${PGTCL_DOCVER}

clean-ased:

distclean-ased:
	@-rm -rf ${ASED_DIR}

clean-xotclide:

distclean-xotclide:
	@-rm -rf xotclIDE-${XOTCLIDE_VERSION}

clean-mkziplib:
	@-cd mkziplib${MKZIPLIB_VERSION} && rm -f *.o *.dll *.exe

distclean-mkziplib:
	@-rm -rf mkziplib${MKZIPLIB_VERSION}
