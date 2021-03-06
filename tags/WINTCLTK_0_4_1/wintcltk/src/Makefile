#!/bin/sh
#
# WinTclTk Makefile 
# Copyright (c) 2006 Martin Matuska
#
# $Id$
#
TCLTK_VERSION=		8.4.14
THREAD_VERSION=		2.6.5
XOTCL_VERSION=		1.5.3
TCLLIB_VERSION=		1.9
TKLIB_VERSION=		0.4.1
BWIDGET_VERSION=	1.8.0
TWAPI_VERSION=		1.1.5
ASED_VERSION=		3.0b16
XOTCLIDE_VERSION=	0.82
MKZIPLIB_VERSION=	1.0
TGDBM_VERSION=		0.5
METAKIT_VERSION=	2.4.9.6
MYSQLTCL_VERSION=	3.02
PGTCL_VERSION=		1.6.0
TLS_VERSION=		1.5.0
TDOM_VERSION=		0.8.1

XOTCL_LIBVER=		$(subst .,,$(XOTCL_VERSION))
XOTCLIDE_FILEVER=	$(XOTCLIDE_VERSION)-0
THREAD_LIBVER=		$(subst .,,$(THREAD_VERSION))
TDOM_LIBVER=		$(subst .,,$(TDOM_VERSION))
TKLIB_SHORT=		0.4
PGTCL_DOCVER=		20070115
PGTCL_REL=		1229
PGTCL_DOCREL=		1228
MKZIPLIB_SHORT=		10
TLS_SHORT=		1.5
TLS_LIBVER=		$(subst .,,$(TLS_SHORT))
ASED_DIR=		ased3.0

GDBM_VERSION=		1.8.3
GDBM_LIVBER=		$(subst .,,$(GDBM_VERSION))
OPENSSL_VERSION=	0.9.8e
OPENSSL_LIBVER=		0.9.8
ZLIB_VERSION=		1.2.3
POSTGRESQL_VERSION=	8.2.3
PTHREADS_VERSION=	2-8-0

SOURCEFORGE_MIRROR?=	heanet
GNU_MIRROR?=		ftp.gnu.org/pub/gnu
POSTGRESQL_MIRROR?=	ftp://ftp.us.postgresql.org/pub/mirrors/postgresql/source/v8.2.3/

WGET?=		$(shell which wget)
WGET_FLAGS=	"--passive-ftp"
UNZIP?=		$(shell which unzip)
PERL?=		$(shell which perl)
CURDIR=		$(shell pwd)

DISTFILES?=	${CURDIR}/distfiles
MD5SUMS=	${CURDIR}/md5sums
PATCHDIR=	${CURDIR}/patches
PREFIX?=	${CURDIR}/instroot
BUILDDIR?=	${CURDIR}/build

MESSAGE_WGET=		"You require wget to auto-download the sources. See SOURCES.txt for more information."
MESSAGE_UNZIP=		"You require unzip to extract this source. See SOURCES.txt for more information."
MESSAGE_OPENSSL_PERL=	"You require perl to configure OpenSSL. See BUILD-MinGW.txt for more information."

all: install
install: install-tcl install-tk install-gdbm install-thread install-tdom install-xotcl install-tgdbm install-tls install-metakit install-mysqltcl install-pgtcl install-xotclide install-tcllib install-tklib install-bwidget install-mkziplib install-twapi install-ased
uninstall: uninstall-tcl uninstall-tk uninstall-thread uninstall-tdom uninstall-xotcl uninstall-tgdbm uninstall-gdbm uninstall-tls uninstall-openssl uninstall-metakit uninstall-mysqlctl uninstall-pgtcl uninstall-postgresql uninstall-pthreads uninstall-xotclide uninstall-tcllib uninstall-tklib uninstall-bwidget uninstall-mkziplib uninstall-zlib uninstall-twapi uninstall-ased 
clean: clean-tcl clean-tk clean-thread clean-tdom clean-xotcl clean-tgdbm clean-gdbm clean-tls clean-openssl clean-metakit clean-mysqltcl clean-pgtcl clean-postgresql clean-pthreads clean-xotclide clean-tcllib clean-tklib clean-bwidget clean-mkziplib clean-zlib clean-twapi clean-ased
distclean: distclean-tcl distclean-tk distclean-thread distclean-tdom distclean-xotcl distclean-tgdbm distclean-gdbm distclean-tls distclean-openssl distclean-metakit distclean-mysqltcl distclean-pgtcl distclean-postgresql distclean-pthreads distclean-xotclide distclean-tcllib distclean-tklib distclean-bwidget distclean-mkziplib distclean-zlib distclean-twapi distclean-ased
allclean: distclean
	@rm *.tar.gz *.zip *.htm *.html

# directories
${DISTFILES}:
	@[ -d "${DISTFILES}" ] || mkdir -p ${DISTFILES}

${BUILDDIR}:
	@[ -d "${BUILDDIR}" ] || mkdir -p ${BUILDDIR}

# tcl	
fetch-tcl: ${DISTFILES} ${DISTFILES}/tcl${TCLTK_VERSION}-src.tar.gz 
${DISTFILES}/tcl${TCLTK_VERSION}-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcl/tcl${TCLTK_VERSION}-src.tar.gz"

extract-tcl: fetch-tcl ${BUILDDIR} ${BUILDDIR}/tcl${TCLTK_VERSION} 
${BUILDDIR}/tcl${TCLTK_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tcl${TCLTK_VERSION}-src.tar.gz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/tcl${TCLTK_VERSION}-src.tar.gz

configure-tcl: extract-tcl ${BUILDDIR}/tcl${TCLTK_VERSION}/win/Makefile
${BUILDDIR}/tcl${TCLTK_VERSION}/win/Makefile:
	@cd ${BUILDDIR}/tcl${TCLTK_VERSION}/win && ./configure --prefix=${PREFIX} --enable-shared --enable-threads 

build-tcl: configure-tcl ${BUILDDIR} ${BUILDDIR}/tcl${TCLTK_VERSION}/win/tclsh84.exe
${BUILDDIR}/tcl${TCLTK_VERSION}/win/tclsh84.exe:
	@cd ${BUILDDIR}/tcl${TCLTK_VERSION}/win && make && strip *.exe *.dll

install-tcl: build-tcl ${PREFIX}/lib/tclConfig.sh
${PREFIX}/lib/tclConfig.sh:
	@cd ${BUILDDIR}/tcl${TCLTK_VERSION}/win && make install

uninstall-tcl:
	@-cd ${PREFIX}/bin && rm tcl*.dll tclsh*.exe
	@-cd ${PREFIX}/lib && rm -rf dde1.2 libtclstub*.a tcl* libtcl*.a reg1.1 tclConfig.sh
	@-cd ${PREFIX}/include && rm tclDecls.h tcl.h tclPlatDecls.h
	
clean-tcl:
	@-cd ${BUILDDIR}/tcl${TCLTK_VERSION}/win && make clean

distclean-tcl:
	@-rm -rf ${BUILDDIR}/tcl${TCLTK_VERSION}

# tk
fetch-tk: ${DISTFILES} ${DISTFILES}/tk${TCLTK_VERSION}-src.tar.gz 
${DISTFILES}/tk${TCLTK_VERSION}-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcl/tk${TCLTK_VERSION}-src.tar.gz"

extract-tk: fetch-tk ${BUILDDIR} ${BUILDDIR}/tk${TCLTK_VERSION} 
${BUILDDIR}/tk${TCLTK_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tk${TCLTK_VERSION}-src.tar.gz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/tk${TCLTK_VERSION}-src.tar.gz

configure-tk: install-tcl extract-tk ${BUILDDIR}/tk${TCLTK_VERSION}/win/Makefile 
${BUILDDIR}/tk${TCLTK_VERSION}/win/Makefile:
	@cd ${BUILDDIR}/tk${TCLTK_VERSION}/win && ./configure --prefix=${PREFIX} --enable-shared --enable-threads

build-tk: configure-tk ${BUILDDIR}/tk${TCLTK_VERSION}/win/wish84.exe 
${BUILDDIR}/tk${TCLTK_VERSION}/win/wish84.exe:
	@cd ${BUILDDIR}/tk${TCLTK_VERSION}/win && make && strip *.exe *.dll

install-tk: build-tk ${PREFIX}/lib/tkConfig.sh 
${PREFIX}/lib/tkConfig.sh:
	@cd ${BUILDDIR}/tk${TCLTK_VERSION}/win && make install
	
uninstall-tk:
	@-cd ${PREFIX}/bin && rm tk*.dll wish*.exe
	@-cd ${PREFIX}/lib && rm -rf tk* libtk*.a libtkstub*.a tkConfig.shi
	@-cd ${PREFIX}/include && rm -rf X11 tk.h tkDecls.h tkIntXlibDecls.h tkPlatDecls.h 

clean-tk:
	@-cd ${BUILDDIR}/tk${TCLTK_VERSION}/win && make clean

distclean-tk:
	@-rm -rf ${BUILDDIR}/tk${TCLTK_VERSION}

# gdbm
fetch-gdbm: ${DISTFILES} ${DISTFILES}/gdbm-${GDBM_VERSION}.tar.gz 
${DISTFILES}/gdbm-${GDBM_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "ftp://${GNU_MIRROR}/gdbm/gdbm-${GDBM_VERSION}.tar.gz"

extract-gdbm: fetch-gdbm ${BUILDDIR} ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32
${BUILDDIR}/gdbm-${GDBM_VERSION}/win32:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/gdbm-${GDBM_VERSION}.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/gdbm-${GDBM_VERSION}.tar.gz
	@cd ${BUILDDIR} && patch -p0 < ${PATCHDIR}/gdbm.patch

configure-gdbm: extract-gdbm

build-gdbm: configure-gdbm ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32/shlib/gdbm.dll 
${BUILDDIR}/gdbm-${GDBM_VERSION}/win32/shlib/gdbm.dll:
	@cd ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32 && make && strip shlib/*.dll

install-gdbm: build-gdbm ${PREFIX}/bin/gdbm.dll
${PREFIX}/bin/gdbm.dll: 
	@cd ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32 && make install prefix=$(PREFIX)

uninstall-gdbm:
	@-cd ${PREFIX} && rm -rf bin/gdbm.dll include/dbm.h include/gdbm.h include/ndbm.h lib/gdbm.a

clean-gdbm:
	@-cd ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32 && make clean

distclean-gdbm:
	@-rm -rf ${BUILDDIR}/gdbm-${GDBM_VERSION}
		
# tgdbm
fetch-tgdbm: ${DISTFILES} ${DISTFILES}/tgdbm${TGDBM_VERSION}.zip 
${DISTFILES}/tgdbm${TGDBM_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.vogel-nest.de/wiki/uploads/Main/tgdbm${TGDBM_VERSION}.zip"

extract-tgdbm: fetch-tgdbm ${BUILDDIR} ${BUILDDIR}/tgdbm${TGDBM_VERSION}
${BUILDDIR}/tgdbm${TGDBM_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tgdbm${TGDBM_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@cd ${BUILDDIR} && ${UNZIP} ${DISTFILES}/tgdbm$(TGDBM_VERSION).zip
	@cd ${BUILDDIR}/tgdbm$(TGDBM_VERSION) && rm tgdbm.dll

configure-tgdbm: extract-tgdbm

build-tgdbm: configure-tgdbm ${BUILDDIR}/tgdbm$(TGDBM_VERSION)/tgdbm.dll 
${BUILDDIR}/tgdbm${TGDBM_VERSION}/tgdbm.dll:
	@cd ${BUILDDIR}/tgdbm${TGDBM_VERSION} && make -f Makefile.mingw TCL=$(PREFIX) GDBM_LIB_DIR=$(PREFIX)/bin GDBM_DIR=$(PREFIX)/include GDBM_WINDIR=$(PREFIX)/include && strip *.dll

install-tgdbm: build-tgdbm ${PREFIX}/lib/tgdbm$(TGDBM_VERSION)
${PREFIX}/lib/tgdbm$(TGDBM_VERSION):
	@mkdir -p $(PREFIX)/lib/tgdbm$(TGDBM_VERSION)
	@cd ${BUILDDIR}/tgdbm$(TGDBM_VERSION) && cp tgdbm.dll qgdbm.tcl $(PREFIX)/lib/tgdbm$(TGDBM_VERSION)
	@echo 'package ifneeded tgdbm' $(TGDBM_VERSION) '[list load [file join $$dir tgdbm.dll] tgdbm]' > $(PREFIX)/lib/tgdbm$(TGDBM_VERSION)/pkgIndex.tcl

uninstall-tgdbm:
	@-cd ${PREFIX} && rm -rf lib/tgdbm$(TGDBM_VERSION)	

clean-tgdbm:
	@-cd ${BUILDDIR}/tgdbm$(TGDBM_VERSION) && rm -rf mingw_release tgdbm.dll

distclean-tgdbm:
	@-rm -rf ${BUILDDIR}/tgdbm$(TGDBM_VERSION)

# thread
fetch-thread: ${DISTFILES} ${DISTFILES}/thread${THREAD_VERSION}.tar.gz 
${DISTFILES}/thread${THREAD_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcl/thread${THREAD_VERSION}.tar.gz"

extract-thread: fetch-thread ${BUILDDIR} ${BUILDDIR}/thread${THREAD_VERSION} 
${BUILDDIR}/thread${THREAD_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/thread${THREAD_VERSION}.tar.gz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/thread${THREAD_VERSION}.tar.gz
	@cd ${BUILDDIR}/thread${THREAD_VERSION} && patch -p0 < ${PATCHDIR}/thread.patch

configure-thread: install-tcl install-gdbm extract-thread ${BUILDDIR}/thread${THREAD_VERSION}/Makefile 
${BUILDDIR}/thread${THREAD_VERSION}/Makefile:
	@cd ${BUILDDIR}/thread${THREAD_VERSION} && ./configure --prefix=${PREFIX} --enable-shared --enable-threads \
		--with-tcl=${PREFIX}/lib --with-gdbm 

build-thread: configure-thread ${BUILDDIR}/thread${THREAD_VERSION}/thread${THREAD_LIBVER}.dll 
${BUILDDIR}/thread${THREAD_VERSION}/thread${THREAD_LIBVER}.dll :
	@cd ${BUILDDIR}/thread${THREAD_VERSION} && make

install-thread: build-thread ${PREFIX}/lib/thread${THREAD_VERSION}/pkgIndex.tcl
${PREFIX}/lib/thread${THREAD_VERSION}/pkgIndex.tcl: 
	@cd ${BUILDDIR}/thread${THREAD_VERSION} && make install	

uninstall-thread:
	@-cd ${PREFIX}/lib && rm -rf thread${THREAD_VERSION}

clean-thread: 
	@-cd ${BUILDDIR}/thread${THREAD_VERSION} && make clean 

distclean-thread: 
	@-rm -rf ${BUILDDIR}/thread${THREAD_VERSION}	

# tdom
fetch-tdom: ${DISTFILES} ${DISTFILES}/tDOM-${TDOM_VERSION}-mingw32-src.tar.gz 
${DISTFILES}/tDOM-${TDOM_VERSION}-mingw32-src.tar.gz :
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://download.berlios.de/wintcltk/tDOM-${TDOM_VERSION}-mingw32-src.tar.gz"

extract-tdom: fetch-tdom ${BUILDDIR} ${BUILDDIR}/tDOM-${TDOM_VERSION} 
${BUILDDIR}/tDOM-${TDOM_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tDOM-${TDOM_VERSION}-mingw32-src.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/tDOM-${TDOM_VERSION}-mingw32-src.tar.gz


configure-tdom: install-tcl extract-tdom ${BUILDDIR}/tDOM-${TDOM_VERSION}/Makefile 
${BUILDDIR}/tDOM-${TDOM_VERSION}/Makefile:
	@cd ${BUILDDIR}/tDOM-${TDOM_VERSION} && ./configure --prefix="${PREFIX}" --with-tcl="${PREFIX}/lib"	

build-tdom: configure-tdom ${BUILDDIR}/tDOM-${TDOM_VERSION}/tdom${TDOM_LIBVER}.dll
${BUILDDIR}/tDOM-${TDOM_VERSION}/tdom${TDOM_LIBVER}.dll:
	@cd ${BUILDDIR}/tDOM-${TDOM_VERSION} && make && strip *.dll

install-tdom: build-tdom ${PREFIX}/lib/tdomConfig.sh
${PREFIX}/lib/tdomConfig.sh: 
	@cd ${BUILDDIR}/tDOM-${TDOM_VERSION} && make install
	@mkdir ${PREFIX}/lib/tdom${TDOM_VERSION}/doc
	@cp ${BUILDDIR}/tDOM-${TDOM_VERSION}/LICENSE ${PREFIX}/lib/tdom${TDOM_VERSION}
	
uninstall-tdom:
	@-cd ${PREFIX}/lib && rm -rf tdom${TDOM_VERSION} tdomConfig.sh
	@-cd ${PREFIX}/include && rm tdom.h
	@-cd ${PREFIX}/man && rm -rf mann

clean-tdom: 
	@-cd ${BUILDDIR}/tDOM-${TDOM_VERSION} && make clean 

distclean-tdom: 
	@-rm -rf ${BUILDDIR}/tDOM-${TDOM_VERSION}

# xotcl
fetch-xotcl: ${DISTFILES} ${DISTFILES}/xotcl-${XOTCL_VERSION}.tar.gz 
${DISTFILES}/xotcl-${XOTCL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://media.wu-wien.ac.at/download/xotcl-${XOTCL_VERSION}.tar.gz"

extract-xotcl: fetch-xotcl ${BUILDDIR} ${BUILDDIR}/xotcl-${XOTCL_VERSION} 
${BUILDDIR}/xotcl-${XOTCL_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/xotcl-${XOTCL_VERSION}.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/xotcl-${XOTCL_VERSION}.tar.gz
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && patch -p1 < ${PATCHDIR}/xotcl.patch
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && autoconf
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION}/library/xml/TclExpat-1.1 && autoconf

configure-xotcl: install-tcl install-gdbm extract-xotcl ${BUILDDIR}/xotcl-${XOTCL_VERSION}/Makefile 
${BUILDDIR}/xotcl-${XOTCL_VERSION}/Makefile:
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && ./configure --prefix=${PREFIX} --enable-shared --enable-threads \
		--with-tcl=${PREFIX}/lib --with-actiweb --with-gdbm=${PREFIX}/include,${PREFIX}/bin	

build-xotcl: configure-xotcl ${BUILDDIR}/xotcl-${XOTCL_VERSION}/xotcl${XOTCL_LIBVER}.dll 
${BUILDDIR}/xotcl-${XOTCL_VERSION}/xotcl${XOTCL_LIBVER}.dll:
	echo $(XOTCL_SHORT)
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && make && strip *.dll library/*/*/*.dll

install-xotcl: build-xotcl ${PREFIX}/lib/xotclConfig.sh
${PREFIX}/lib/xotclConfig.sh: 
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && make install
	
uninstall-xotcl:
	@-cd ${PREFIX}/lib && rm -rf xotcl${XOTCL_VERSION} xotcl*.dll xotclConfig.sh
	@-cd ${PREFIX}/include && rm xotcl.h xotclDecls.h xotclInt.h xotclIntDecls.h

clean-xotcl: 
	@-cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && make clean 

distclean-xotcl: 
	@-rm -rf ${BUILDDIR}/xotcl-${XOTCL_VERSION}

# metakit
fetch-metakit: ${DISTFILES}/metakit-${METAKIT_VERSION}.tar.gz ${DISTFILES}/mk4tcl.html 
${DISTFILES}/metakit-${METAKIT_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.equi4.com/pub/mk/metakit-${METAKIT_VERSION}.tar.gz"
${DISTFILES}/mk4tcl.html:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} -O mk4tcl.html "http://www.equi4.com/metakit/tcl.html"

extract-metakit: fetch-metakit ${BUILDDIR} ${BUILDDIR}/metakit-${METAKIT_VERSION}
${BUILDDIR}/metakit-${METAKIT_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/metakit-${METAKIT_VERSION}.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/metakit-${METAKIT_VERSION}.tar.gz
	@cd ${BUILDDIR} && patch -p0 < ${PATCHDIR}/metakit.patch

configure-metakit: extract-metakit ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix/Makefile
${BUILDDIR}/metakit-${METAKIT_VERSION}/unix/Makefile:
	@cd ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix && ./configure --prefix=${PREFIX} --libdir=${PREFIX}/bin --with-tcl=${PREFIX}/include --enable-threads

build-metakit: configure-metakit ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix/Mk4tcl.dll 
${BUILDDIR}/metakit-${METAKIT_VERSION}/unix/Mk4tcl.dll:
	@cd ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix && make && strip *.dll

install-metakit: build-metakit ${PREFIX}/lib/Mk4tcl/Mk4tcl.dll
${PREFIX}/lib/Mk4tcl/Mk4tcl.dll: 
	@cd ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix && make install 
	@cp ${DISTFILES}/mk4tcl.html ${PREFIX}/lib/Mk4tcl

uninstall-metakit:
	@-cd ${PREFIX} && rm -rf bin/libmk4.dll include/mk4* lib/Mk4tcl 

clean-metakit:
	@-cd ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix && make clean

distclean-metakit:
	@-rm -rf ${BUILDDIR}/metakit-${METAKIT_VERSION}

# openssl
fetch-openssl: ${DISTFILES} ${DISTFILES}/openssl-${OPENSSL_VERSION}.tar.gz 
${DISTFILES}/openssl-${OPENSSL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"

extract-openssl: fetch-openssl ${BUILDDIR} ${BUILDDIR}/openssl-${OPENSSL_VERSION}
${BUILDDIR}/openssl-${OPENSSL_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/openssl-${OPENSSL_VERSION}.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/openssl-${OPENSSL_VERSION}.tar.gz >/dev/null 2>&1
	@cd ${BUILDDIR}/openssl-${OPENSSL_VERSION} && patch -p0 < ${PATCHDIR}/openssl.patch

configure-openssl: extract-openssl ${BUILDDIR}/openssl-${OPENSSL_VERSION}/configure.done
${BUILDDIR}/openssl-${OPENSSL_VERSION}/configure.done:
	@[ -x "${PERL}" ] || ( echo "$(MESSAGE_OPENSSL_PERL)"; exit 1 ) 
	@cd ${BUILDDIR}/openssl-${OPENSSL_VERSION} && Configure --prefix=${PREFIX} mingw shared threads && touch configure.done 

build-openssl: configure-openssl ${BUILDDIR}/openssl-${OPENSSL_VERSION}/libeay32.dll 
${BUILDDIR}/openssl-${OPENSSL_VERSION}/libeay32.dll:
	@cd ${BUILDDIR}/openssl-${OPENSSL_VERSION} && sh ms/mingw32.sh && strip *.dll

install-openssl: build-openssl ${PREFIX}/bin/libeay32.dll
${PREFIX}/bin/libeay32.dll: 
	@cd ${BUILDDIR}/openssl-${OPENSSL_VERSION} && make -f ms/mingw32a.mak install MKDIR="mkdir -p"
	@cp ${BUILDDIR}/openssl-${OPENSSL_VERSION}/out/libssl32.a ${PREFIX}/lib/libssl.dll.a
	@cp ${BUILDDIR}/openssl-${OPENSSL_VERSION}/out/libeay32.a ${PREFIX}/lib/libcrypto.dll.a
	@cp ${BUILDDIR}/openssl-${OPENSSL_VERSION}/libeay32.dll ${BUILDDIR}/openssl-${OPENSSL_VERSION}/libssl32.dll ${PREFIX}/bin

uninstall-openssl:
	@-cd ${PREFIX} && rm -rf bin/openssl.exe bin/libeay32.dll bin/libssl32.dll include/openssl lib/libssl*.a lib/libcrypto*.a 

clean-openssl:
	@-cd ${BUILDDIR}/openssl-${OPENSSL_VERSION} && make clean

distclean-openssl:
	@-rm -rf ${BUILDDIR}/openssl-${OPENSSL_VERSION}
	
# tls
fetch-tls: ${DISTFILES} ${DISTFILES}/tls${TLS_VERSION}-src.tar.gz 
${DISTFILES}/tls${TLS_VERSION}-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/tls/tls${TLS_VERSION}-src.tar.gz"

extract-tls: fetch-tls ${BUILDDIR} ${BUILDDIR}/tls${TLS_SHORT}
${BUILDDIR}/tls${TLS_SHORT}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tls${TLS_VERSION}-src.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/tls${TLS_VERSION}-src.tar.gz
	@cd ${BUILDDIR}/tls${TLS_SHORT} && patch -p0 < ${PATCHDIR}/tls.patch

configure-tls: install-openssl extract-tls ${BUILDDIR}/tls${TLS_SHORT}/Makefile
${BUILDDIR}/tls${TLS_SHORT}/Makefile:
	@cd ${BUILDDIR}/tls${TLS_SHORT} && ./configure --prefix=${PREFIX} --enable-threads --enable-shared --enable-gcc --with-ssl-dir=${PREFIX}

build-tls: configure-tls ${BUILDDIR}/tls${TLS_SHORT}/tls${TLS_LIBVER}.dll 
${BUILDDIR}/tls${TLS_SHORT}/tls${TLS_LIBVER}.dll:
	@cd ${BUILDDIR}/tls${TLS_SHORT} && make && strip *.dll

install-tls: build-tls ${PREFIX}/lib/tls${TLS_VERSION}
${PREFIX}/lib/tls${TLS_VERSION}: 
	@mkdir -p ${PREFIX}/lib/tls${TLS_VERSION}
	@cd ${BUILDDIR}/tls${TLS_SHORT} && cp pkgIndex.tcl license.terms tls.tcl tls.htm tls${TLS_LIBVER}.dll ${PREFIX}/lib/tls${TLS_VERSION} 

uninstall-tls:
	@-cd ${PREFIX} && rm -rf lib/tls${TLS_VERSION}

clean-tls:
	@-cd ${BUILDDIR}/tls${TLS_SHORT} && make clean

distclean-tls:
	@-rm -rf ${BUILDDIR}/tls${TLS_SHORT}

# tcllib
fetch-tcllib: ${DISTFILES} ${DISTFILES}/tcllib-${TCLLIB_VERSION}.tar.gz 
${DISTFILES}/tcllib-${TCLLIB_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcllib/tcllib-${TCLLIB_VERSION}.tar.gz"

extract-tcllib: fetch-tcllib ${BUILDDIR} ${BUILDDIR}/tcllib-${TCLLIB_VERSION} 
${BUILDDIR}/tcllib-${TCLLIB_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tcllib-${TCLLIB_VERSION}.tar.gz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/tcllib-${TCLLIB_VERSION}.tar.gz

configure-tcllib: install-tcl extract-tcllib ${BUILDDIR}/tcllib-${TCLLIB_VERSION}/Makefile 
${BUILDDIR}/tcllib-${TCLLIB_VERSION}/Makefile:
	@cd ${BUILDDIR}/tcllib-${TCLLIB_VERSION} && ./configure --prefix=${PREFIX}

build-tcllib: configure-tcllib 

install-tcllib: build-tcllib ${PREFIX}/lib/tcllib${TCLLIB_VERSION}/pkgIndex.tcl 
${PREFIX}/lib/tcllib${TCLLIB_VERSION}/pkgIndex.tcl:
	@cd ${BUILDDIR}/tcllib-${TCLLIB_VERSION} && make install-libraries

uninstall-tcllib:
	@-cd ${PREFIX}/lib && rm -rf tcllib${TCLLIB_VERSION}

clean-tcllib:
	@-cd ${BUILDDIR}/tcllib-${TCLLIB_VERSION} && make clean

distclean-tcllib:
	@-rm -rf ${BUILDDIR}/tcllib-${TCLLIB_VERSION}

# tklib
fetch-tklib: ${DISTFILES} ${DISTFILES}/tklib-${TKLIB_VERSION}.tar.gz 
${DISTFILES}/tklib-${TKLIB_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcllib/tklib-${TKLIB_VERSION}.tar.gz"

extract-tklib: fetch-tklib ${BUILDDIR} ${BUILDDIR}/tklib-${TKLIB_VERSION} 
${BUILDDIR}/tklib-${TKLIB_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tklib-${TKLIB_VERSION}.tar.gz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/tklib-${TKLIB_VERSION}.tar.gz

configure-tklib: install-tk extract-tklib ${BUILDDIR}/tklib-${TKLIB_VERSION}/Makefile 
${BUILDDIR}/tklib-${TKLIB_VERSION}/Makefile:
	@cd ${BUILDDIR}/tklib-${TKLIB_VERSION} && ./configure --prefix=${PREFIX}

build-tklib: configure-tklib 

install-tklib: build-tklib ${PREFIX}/lib/tklib${TKLIB_SHORT}/pkgIndex.tcl 
${PREFIX}/lib/tklib${TKLIB_SHORT}/pkgIndex.tcl:
	@cd ${BUILDDIR}/tklib-${TKLIB_VERSION} && make install-libraries

uninstall-tklib:
	@-cd ${PREFIX}/lib && rm -rf tklib${TKLIB_VERSION}

clean-tklib:
	@-cd ${BUILDDIR}/tklib-${TKLIB_VERSION} && make clean

distclean-tklib:
	@-rm -rf ${BUILDDIR}/tklib-${TKLIB_VERSION}

# bwidget
fetch-bwidget: ${DISTFILES} ${DISTFILES}/BWidget-${BWIDGET_VERSION}.tar.gz 
${DISTFILES}/BWidget-${BWIDGET_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcllib/BWidget-${BWIDGET_VERSION}.tar.gz"

extract-bwidget: fetch-bwidget ${BUILDDIR} ${BUILDDIR}/BWidget-${BWIDGET_VERSION} 
${BUILDDIR}/BWidget-${BWIDGET_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/BWidget-${BWIDGET_VERSION}.tar.gz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/BWidget-${BWIDGET_VERSION}.tar.gz

configure-bwidget: extract-bwidget
build-bwidget: configure-bwidget
 
install-bwidget: build-bwidget ${PREFIX}/lib/BWidget${BWIDGET_VERSION}/pkgIndex.tcl
${PREFIX}/lib/BWidget${BWIDGET_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/BWidget${BWIDGET_VERSION}
	@cp -Rp ${BUILDDIR}/BWidget-${BWIDGET_VERSION}/* ${PREFIX}/lib/BWidget${BWIDGET_VERSION}

uninstall-bwidget:
	@-cd ${PREFIX}/lib && rm -rf BWidget${BWIDGET_VERSION}

clean-bwidget:

distclean-bwidget:
	@-rm -rf ${BUILDDIR}/BWidget-${BWIDGET_VERSION}

# twapi
fetch-twapi: ${DISTFILES} ${DISTFILES}/twapi-${TWAPI_VERSION}.zip 
${DISTFILES}/twapi-${TWAPI_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/twapi/twapi-${TWAPI_VERSION}.zip"

extract-twapi: fetch-twapi ${BUILDDIR} ${BUILDDIR}/twapi 
${BUILDDIR}/twapi:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/twapi-${TWAPI_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@cd ${BUILDDIR} && ${UNZIP} ${DISTFILES}/twapi-${TWAPI_VERSION}.zip

configure-twapi: extract-twapi
build-twapi: configure-twapi

install-twapi: build-twapi ${PREFIX}/lib/twapi${TWAPI_VERSION}/pkgIndex.tcl
${PREFIX}/lib/twapi${TWAPI_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/twapi${TWAPI_VERSION}
	@cp -Rp ${BUILDDIR}/twapi/* ${PREFIX}/lib/twapi${TWAPI_VERSION}

uninstall-twapi:
	@-cd ${PREFIX}/lib && rm -rf twapi${TWAPI_VERSION}
	
clean-twapi:

distclean-twapi:
	@-rm -rf ${BUILDDIR}/twapi

# mysqltcl
fetch-mysqltcl: ${DISTFILES} ${DISTFILES}/mysqltcl-${MYSQLTCL_VERSION}.zip ${DISTFILES}/mysqltcl.html
${DISTFILES}/mysqltcl-${MYSQLTCL_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} "http://www.xdobry.de/mysqltcl/mysqltcl-${MYSQLTCL_VERSION}.zip"
${DISTFILES}/mysqltcl.html:
	@cd ${DISTFILES} && ${WGET} "http://www.xdobry.de/mysqltcl/mysqltcl.html"
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
 
extract-mysqltcl: fetch-mysqltcl ${BUILDDIR} ${BUILDDIR}/mysqltcl-${MYSQLTCL_VERSION} 
${BUILDDIR}/mysqltcl-${MYSQLTCL_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/mysqltcl-${MYSQLTCL_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@cd ${BUILDDIR} && ${UNZIP} ${DISTFILES}/mysqltcl-${MYSQLTCL_VERSION}.zip

configure-mysqltcl: extract-mysqltcl
build-mysqltcl: configure-mysqltcl

install-mysqltcl: build-mysqltcl ${PREFIX}/lib/mysqltcl${MYSQLTCL_VERSION}/pkgIndex.tcl
${PREFIX}/lib/mysqltcl${MYSQLTCL_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/mysqltcl${MYSQLTCL_VERSION}
	@cp -Rp ${DISTFILES}/mysqltcl.html ${BUILDDIR}/mysqltcl-${MYSQLTCL_VERSION}/* ${PREFIX}/lib/mysqltcl${MYSQLTCL_VERSION}

uninstall-mysqltcl:
	@-cd ${PREFIX}/lib && rm -rf mysqltcl${MYSQLTCL_VERSION}

clean-mysqltcl:

distclean-mysqltcl:
	@-rm -rf ${BUILDDIR}/mysqltcl-${MYSQLTCL_VERSION}

# zlib
fetch-zlib: ${DISTFILES} ${DISTFILES}/zlib-${ZLIB_VERSION}.tar.bz2
${DISTFILES}/zlib-${ZLIB_VERSION}.tar.bz2:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/libpng/zlib-${ZLIB_VERSION}.tar.bz2"

extract-zlib: fetch-zlib ${BUILDDIR} ${BUILDDIR}/zlib-${ZLIB_VERSION}
${BUILDDIR}/zlib-${ZLIB_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/zlib-${ZLIB_VERSION}.tar.bz2.md5 || exit 1
	@cd ${BUILDDIR} && tar xfj ${DISTFILES}/zlib-${ZLIB_VERSION}.tar.bz2
	
configure-zlib: extract-zlib
build-zlib: configure-zlib ${BUILDDIR}/zlib-${ZLIB_VERSION}/zlib1.dll
${BUILDDIR}/zlib-${ZLIB_VERSION}/zlib1.dll:
	@cd ${BUILDDIR}/zlib-${ZLIB_VERSION} && make -f win32/Makefile.gcc

install-zlib: build-zlib ${PREFIX}/bin/zlib1.dll
${PREFIX}/bin/zlib1.dll:
	@cp ${BUILDDIR}/zlib-${ZLIB_VERSION}/zlib.h ${BUILDDIR}/zlib-${ZLIB_VERSION}/zconf.h ${PREFIX}/include
	@cp ${BUILDDIR}/zlib-${ZLIB_VERSION}/libz.a ${PREFIX}/lib
	@cp ${BUILDDIR}/zlib-${ZLIB_VERSION}/zlib1.dll ${PREFIX}/bin

uninstall-zlib:
	@-rm -f ${PREFIX}/include/zconf.h ${PREFIX}/include/zlib.h ${PREFIX}/lib/libz.a ${PREFIX}/bin/zlib1.dll

clean-zlib:
	@cd ${BUILDDIR}/zlib-${ZLIB_VERSION} && make -f win32/Makefile.gcc clean
	
distclean-zlib:
	@-rm -rf ${BUILDDIR}/zlib-${ZLIB_VERSION}

# pthreads	
fetch-pthreads: ${DISTFILES} ${DISTFILES}/pthreads-w32-${PTHREADS_VERSION}-release.tar.gz
${DISTFILES}/pthreads-w32-${PTHREADS_VERSION}-release.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-${PTHREADS_VERSION}-release.tar.gz"

extract-pthreads: fetch-pthreads ${BUILDDIR} ${BUILDDIR}/pthreads-w32-${PTHREADS_VERSION}-release
${BUILDDIR}/pthreads-w32-${PTHREADS_VERSION}-release:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/pthreads-w32-${PTHREADS_VERSION}-release.tar.gz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/pthreads-w32-${PTHREADS_VERSION}-release.tar.gz

configure-pthreads: extract-pthreads
build-pthreads: configure-pthreads ${BUILDDIR}/pthreads-w32-${PTHREADS_VERSION}-release/pthreadGC2.dll
${BUILDDIR}/pthreads-w32-${PTHREADS_VERSION}-release/pthreadGC2.dll:
	@cd ${BUILDDIR}/pthreads-w32-${PTHREADS_VERSION}-release && make clean GC

install-pthreads: build-pthreads ${PREFIX}/bin/pthreadGC2.dll
${PREFIX}/bin/pthreadGC2.dll:
	@cd ${BUILDDIR}/pthreads-w32-${PTHREADS_VERSION}-release && (\
		cp pthreadGC2.dll ${PREFIX}/bin/pthreadGC2.dll; \
		cp libpthreadGC2.a ${PREFIX}/lib/libpthreadGC2.a; \
		cp implement.h need_errno.h pthread.h sched.h semaphore.h ${PREFIX}/include ) 

uninstall-pthreads:
	@-rm -f ${PREFIX}/bin/pthreadGC2.dll ${PREFIX}/lib/libpthreadGC2.a
	@-cd ${PREFIX}/include && rm -f implement.h need_errno.h pthread.h sched.h semaphore.h

clean-pthreads:
	@cd ${BUILDDIR}/pthreads-w32-${PTHREADS_VERSION}-release && make clean

distclean-pthreads:
	@-rm -rf ${BUILDDIR}/pthreads-w32-${PTHREADS_VERSION}-release

# postgresql
fetch-postgresql: ${DISTFILES} ${DISTFILES}/postgresql-base-${POSTGRESQL_VERSION}.tar.bz2 ${DISTFILES}/postgresql-test-${POSTGRESQL_VERSION}.tar.bz2
${DISTFILES}/postgresql-base-${POSTGRESQL_VERSION}.tar.bz2:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "${POSTGRESQL_MIRROR}/postgresql-base-${POSTGRESQL_VERSION}.tar.bz2"
${DISTFILES}/postgresql-test-${POSTGRESQL_VERSION}.tar.bz2:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "${POSTGRESQL_MIRROR}/postgresql-test-${POSTGRESQL_VERSION}.tar.bz2"

extract-postgresql: fetch-postgresql ${BUILDDIR} ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/src/include/sys/time.h 
${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/src/include/sys/time.h:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/postgresql-base-${POSTGRESQL_VERSION}.tar.bz2.md5 || exit 1
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/postgresql-test-${POSTGRESQL_VERSION}.tar.bz2.md5 || exit 1
	@cd ${BUILDDIR} && tar xfj ${DISTFILES}/postgresql-base-${POSTGRESQL_VERSION}.tar.bz2 
	@cd ${BUILDDIR} && tar xfj ${DISTFILES}/postgresql-test-${POSTGRESQL_VERSION}.tar.bz2
	@cd ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION} && patch -p0 < ${PATCHDIR}/postgresql.patch
	@mkdir -p ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/src/include/sys && \
	 touch ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/src/include/sys/time.h

configure-postgresql: extract-postgresql install-openssl install-zlib install-pthreads ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/GNUmakefile 
${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/GNUmakefile:
	@cd ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION} && ./configure --prefix=${PREFIX} --with-openssl \
		--enable-thread-safety LIBS="-L${PREFIX}/lib" CFLAGS="-I${PREFIX}/include" 

build-postgresql: configure-postgresql ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/src/interfaces/libpq/libpq.dll
${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/src/interfaces/libpq/libpq.dll:
	@cd ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION} && make LDFLAGS="-L${PREFIX}/lib"

install-postgresql: build-postgresql ${PREFIX}/bin/libpq.dll
${PREFIX}/bin/libpq.dll:
	@cd ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/src/include && make install
	@cd ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/src/interfaces/libpq && make install
	@cp ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}/COPYRIGHT ${PREFIX}/lib/COPYRIGHT-PostgreSQL
	@mv -f ${PREFIX}/lib/libpq.dll ${PREFIX}/bin/libpq.dll
	@strip ${PREFIX}/bin/libpq.dll

uninstall-postgresql:
	@-rm -f ${PREFIX}/bin/libpq.dll ${PREFIX}/lib/libpq.a ${PREFIX}/lib/COPYRIGHT-PostgreSQL
	@-cd ${PREFIX} && rm -rf postgres_ext.h pg_config.h pg_config_os.h include/postgresql share/postgresql

clean-postgresql:
	@cd ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION} && make clean

distclean-postgresql:
	@-rm -rf ${BUILDDIR}/postgresql-${POSTGRESQL_VERSION}

# pgtcl	
fetch-pgtcl: ${DISTFILES} ${DISTFILES}/pgtcl${PGTCL_VERSION}.tar.gz ${DISTFILES}/pgtcldocs-${PGTCL_DOCVER}.zip 
${DISTFILES}/pgtcl${PGTCL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} "http://pgfoundry.org/frs/download.php/${PGTCL_REL}/pgtcl${PGTCL_VERSION}.tar.gz"
${DISTFILES}/pgtcldocs-${PGTCL_DOCVER}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} "http://pgfoundry.org/frs/download.php/${PGTCL_DOCREL}/pgtcldocs-${PGTCL_DOCVER}.zip"

extract-pgtcl: fetch-pgtcl ${BUILDDIR} ${BUILDDIR}/pgtcl${PGTCL_VERSION} ${BUILDDIR}/pgtcldocs-${PGTCL_DOCVER}
${BUILDDIR}/pgtcl${PGTCL_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/pgtcl${PGTCL_VERSION}.tar.gz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/pgtcl${PGTCL_VERSION}.tar.gz
${BUILDDIR}/pgtcldocs-${PGTCL_DOCVER}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/pgtcldocs-${PGTCL_DOCVER}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@cd ${BUILDDIR} && ${UNZIP} ${DISTFILES}/pgtcldocs-${PGTCL_DOCVER}.zip

configure-pgtcl: extract-pgtcl install-postgresql ${BUILDDIR}/pgtcl${PGTCL_VERSION}/Makefile
${BUILDDIR}/pgtcl${PGTCL_VERSION}/Makefile:
	@cd ${BUILDDIR}/pgtcl${PGTCL_VERSION} && ./configure --prefix=${PREFIX} --enable-shared \
		--with-tcl=${PREFIX}/lib --with-postgres-include=${PREFIX}/include \
		--with-postgres-lib=${PREFIX}/lib SHARED_LIB_SUFFIX=".dll" \
		LIBS="-L${PREFIX}/lib -lcrypto.dll -lssl.dll" 

build-pgtcl: configure-pgtcl ${BUILDDIR}/pgtcl${PGTCL_VERSION}/pgtcl.dll
${BUILDDIR}/pgtcl${PGTCL_VERSION}/pgtcl.dll:
	@cd ${BUILDDIR}/pgtcl${PGTCL_VERSION} && make SHLIB_LD="gcc -shared"

install-pgtcl: build-pgtcl ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/pkgIndex.tcl
${PREFIX}/lib/pgtcl${PGTCL_VERSION}/pkgIndex.tcl:
	@cd ${BUILDDIR}/pgtcl${PGTCL_VERSION} && make install
	@cp ${BUILDDIR}/pgtcl${PGTCL_VERSION}/COPYRIGHT ${PREFIX}/lib/pgtcl${PGTCL_VERSION}
	@mkdir ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/docs && cp -rf ${BUILDDIR}/pgtcldocs-${PGTCL_DOCVER}/* ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/docs

uninstall-pgtcl:
	@-cd ${PREFIX} && rm -rf include/libpgtcl.h lib/pgtcl${PGTCL_VERSION}

clean-pgtcl:
	@cd ${BUILDDIR}/pgtcl${PGTCL_VERSION} && make clean

distclean-pgtcl:
	@-rm -rf ${BUILDDIR}/pgtcl${PGTCL_VERSION} pgtcldocs-${PGTCL_DOCVER}

# ased
fetch-ased: ${DISTFILES} ${DISTFILES}/ased${ASED_VERSION}.zip 
${DISTFILES}/ased${ASED_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} "http://www.mms-forum.de/ased/ased${ASED_VERSION}.zip"

extract-ased: fetch-ased ${BUILDDIR} ${BUILDDIR}/${ASED_DIR} 
${BUILDDIR}/${ASED_DIR}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/ased${ASED_VERSION}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@cd ${BUILDDIR} && ${UNZIP} ${DISTFILES}/ased${ASED_VERSION}.zip
	@cd ${BUILDDIR} && patch -p0 < ${PATCHDIR}/ased${ASED_VERSION}.patch

configure-ased: extract-ased
build-ased: configure-ased

install-ased: build-ased ${PREFIX}/${ASED_DIR}/ased.tcl
${PREFIX}/${ASED_DIR}/ased.tcl:
	@cp -Rp ${BUILDDIR}/${ASED_DIR} ${PREFIX}

uninstall-ased:
	@-cd ${PREFIX} && rm -rf ${ASED_DIR}

clean-ased:

distclean-ased:
	@-rm -rf ${BUILDDIR}/${ASED_DIR}

# xotclide
fetch-xotclide: ${DISTFILES} ${DISTFILES}/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz ${DISTFILES}/xotclide_doc.tar.gz 
${DISTFILES}/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.xdobry.de/xotclIDE/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz"
${DISTFILES}/xotclide_doc.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.xdobry.de/xotclIDE/xotclide_doc.tar.gz"

extract-xotclide: fetch-xotclide ${BUILDDIR} ${BUILDDIR}/xotclide-${XOTCLIDE_VERSION} 
${BUILDDIR}/xotclide-${XOTCLIDE_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz.md5 || exit 1
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/xotclide_doc.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz
	@-cd ${BUILDDIR}/xotclide-${XOTCLIDE_VERSION}/docs && tar xfz ${DISTFILES}/xotclide_doc.tar.gz 

configure-xotclide: install-xotcl extract-xotclide 
build-xotclide: configure-xotclide

install-xotclide: build-xotclide ${PREFIX}/lib/xotclIDE
${PREFIX}/lib/xotclIDE:
	@cd ${BUILDDIR}/xotclide-${XOTCLIDE_VERSION} && rm -f install && make install PREFIX=${PREFIX}

uninstall-xotclide:
	@-cd ${PREFIX} && rm -rf lib/xotclIDE

clean-xotclide:

distclean-xotclide:
	@-rm -rf ${BUILDDIR}/xotclIDE-${XOTCLIDE_VERSION}

# mkziplib
fetch-mkziplib: ${DISTFILES}/mkziplib${MKZIPLIB_SHORT}.zip
${DISTFILES}/mkziplib${MKZIPLIB_SHORT}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://mkextensions.sourceforge.net/mkZiplib${MKZIPLIB_SHORT}.zip"

extract-mkziplib: fetch-mkziplib ${BUILDDIR} ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION}/Makefile
${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION}/Makefile:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/mkZiplib${MKZIPLIB_SHORT}.zip.md5 || exit 1
	@cd ${BUILDDIR} && ${UNZIP} ${DISTFILES}/mkZiplib${MKZIPLIB_SHORT}.zip
	@-cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && rm -f *.dll *.exe
	@-cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && patch -p1 < ${PATCHDIR}/mkZiplib.patch

configure-mkziplib: extract-mkziplib

build-mkziplib: configure-mkziplib install-zlib ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION}/mkZiplib${MKZIPLIB_SHORT}.dll 
${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION}/mkZiplib${MKZIPLIB_SHORT}.dll:
	@cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && make strip CFLAGS="-I${PREFIX}/include" LIBS="${PREFIX}/bin/zlib1.dll" PREFIX="${PREFIX}"

install-mkziplib: build-mkziplib ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/pkgIndex.tcl
${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}
	@cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && cp pkgIndex.tcl mkZiplib${MKZIPLIB_SHORT}.dll ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}
	@cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && cp mkZiplib${MKZIPLIB_SHORT}.htm ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/mkZiplib.htm

uninstall-mkziplib:
	@-cd ${PREFIX} && rm -rf lib/mkZiplib${MKZIPLIB_VERSION}

clean-mkziplib:
	@-cd ${BUILDDIR}/mkziplib${MKZIPLIB_VERSION} && rm -f *.o *.dll *.exe

distclean-mkziplib:
	@-rm -rf ${BUILDDIR}/mkziplib${MKZIPLIB_VERSION}
