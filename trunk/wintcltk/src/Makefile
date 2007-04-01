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
TWAPI_VERSION=1.1.5
ASED_VERSION=3.0b16
XOTCLIDE_VERSION=0.81
MKZIPLIB_VERSION=1.0
TGDBM_VERSION=0.5
METAKIT_VERSION=2.4.9.6
MYSQLTCL_VERSION=3.02
PGTCL_VERSION=1.6.0
TLS_VERSION=1.5.0

XOTCL_LIBVER=153
XOTCLIDE_FILEVER=0.81-0
TKLIB_SHORT=0.4
PGTCL_DOCVER=20070115
PGTCL_REL=1229
PGTCL_DOCREL=1228
MKZIPLIB_SHORT=10
TLS_SHORT=1.5
TLS_LIBVER=15
ASED_DIR=ased3.0

GDBM_VERSION=1.8.3
GDBM_LIVBER=183
OPENSSL_VERSION=0.9.8e
OPENSSL_LIBVER=0.9.8
ZLIB_VERSION=1.2.3
POSTGRESQL_VERSION=8.2.3
PTHREADS_VERSION=2-8-0

SOURCEFORGE_MIRROR?=heanet
GNU_MIRROR?=ftp.gnu.org/pub/gnu
POSTGRESQL_MIRROR?=ftp://ftp.us.postgresql.org/pub/mirrors/postgresql/source/v8.2.3/

WGET?=$(shell which wget)
WGET_FLAGS="--passive-ftp"
UNZIP?=$(shell which unzip)
PERL?=$(shell which perl)
CURDIR=$(shell pwd)
PREFIX=${CURDIR}/../build

MESSAGE_WGET="You require wget to auto-download the sources. See SOURCES.txt for more information."
MESSAGE_UNZIP="You require unzip to extract this source. See SOURCES.txt for more information."
MESSAGE_OPENSSL_PERL="You require perl to configure OpenSSL. See BUILD-MinGW.txt for more information."

all: install
install: install-tcl install-tk install-gdbm install-xotcl install-tgdbm install-tls install-metakit install-mysqltcl install-pgtcl install-xotclide install-tcllib install-tklib install-bwidget install-mkziplib install-twapi install-ased
uninstall: uninstall-tcl uninstall-tk uninstall-xotcl uninstall-tgdbm uninstall-gdbm uninstall-tls uninstall-openssl uninstall-metakit uninstall-mysqlctl uninstall-pgtcl uninstall-postgresql uninstall-pthreads uninstall-xotclide uninstall-tcllib uninstall-tklib uninstall-bwidget uninstall-mkziplib uninstall-zlib uninstall-twapi uninstall-ased 
clean: clean-tcl clean-tk clean-xotcl clean-tgdbm clean-gdbm clean-tls clean-openssl clean-metakit clean-mysqltcl clean-pgtcl clean-postgresql clean-pthreads clean-xotclide clean-tcllib clean-tklib clean-bwidget clean-mkziplib clean-zlib clean-twapi clean-ased
distclean: distclean-tcl distclean-tk distclean-xotcl distclean-tgdbm distclean-gdbm distclean-tls distclean-openssl distclean-metakit distclean-mysqltcl distclean-pgtcl distclean-postgresql distclean-pthreads distclean-xotclide distclean-tcllib distclean-tklib distclean-bwidget distclean-mkziplib distclean-zlib distclean-twapi distclean-ased
allclean: distclean
	@rm *.tar.gz *.zip *.htm *.html

fetch-tcl: tcl${TCLTK_VERSION}-src.tar.gz 
tcl${TCLTK_VERSION}-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcl/tcl${TCLTK_VERSION}-src.tar.gz"

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
	@${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcl/tk${TCLTK_VERSION}-src.tar.gz"

extract-tk: fetch-tk tk${TCLTK_VERSION} 
tk${TCLTK_VERSION}:
	@md5sum -c md5sums/tk${TCLTK_VERSION}-src.tar.gz.md5 || exit 1
	@tar xfz tk${TCLTK_VERSION}-src.tar.gz

configure-tk: install-tcl extract-tk tk${TCLTK_VERSION}/win/Makefile 

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
	@${WGET} ${WGET_FLAGS} "ftp://${GNU_MIRROR}/gdbm/gdbm-${GDBM_VERSION}.tar.gz"

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
	@${WGET} ${WGET_FLAGS} "http://www.vogel-nest.de/wiki/uploads/Main/tgdbm${TGDBM_VERSION}.zip"

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
	@${WGET} ${WGET_FLAGS} "http://media.wu-wien.ac.at/download/xotcl-${XOTCL_VERSION}.tar.gz"

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
	@${WGET} ${WGET_FLAGS} "http://www.equi4.com/pub/mk/metakit-${METAKIT_VERSION}.tar.gz"
mk4tcl.html:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} ${WGET_FLAGS} -O mk4tcl.html "http://www.equi4.com/metakit/tcl.html"

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

fetch-openssl: openssl-${OPENSSL_VERSION}.tar.gz 
openssl-${OPENSSL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} ${WGET_FLAGS} "http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"

extract-openssl: fetch-openssl openssl-${OPENSSL_VERSION}
openssl-${OPENSSL_VERSION}:
	@md5sum -c md5sums/openssl-${OPENSSL_VERSION}.tar.gz.md5 || exit 1
	@-tar xfz openssl-${OPENSSL_VERSION}.tar.gz >/dev/null 2>&1
	@cd openssl-${OPENSSL_VERSION} && patch -p0 < ../patches/openssl.patch

configure-openssl: extract-openssl openssl-${OPENSSL_VERSION}/configure.done openssl-${OPENSSL_VERSION}/include/openssl/crypto.h
openssl-${OPENSSL_VERSION}/configure.done:
	@[ -x "${PERL}" ] || ( echo "$(MESSAGE_OPENSSL_PERL)"; exit 1 ) 
	@cd openssl-${OPENSSL_VERSION} && Configure --prefix=${PREFIX} mingw shared threads && touch configure.done 
openssl-${OPENSSL_VERSION}/include/openssl/crypto.h:
	@cd openssl-${OPENSSL_VERSION} ; \
		cp crypto/*.h ssl/*.h *.h include/openssl/ ;\
		cp crypto/*/*test.c crypto/sha/sha*t.c ssl/*test.c test/ ;\
		cp test/dummytest.c test/rc5test.c ;\
		cp test/dummytest.c test/mdc2test.c ;

build-openssl: configure-openssl openssl-${OPENSSL_VERSION}/ssleay32-${OPENSSL_LIBVER}.dll 
openssl-${OPENSSL_VERSION}/ssleay32-${OPENSSL_LIBVER}.dll:
	@cd openssl-${OPENSSL_VERSION} && make && strip *.dll

install-openssl: build-openssl ${PREFIX}/bin/ssleay32.dll ${PREFIX}/lib/libssl.dll.a
${PREFIX}/lib/libssl.dll.a:
	@cd openssl-${OPENSSL_VERSION} && make install_sw
${PREFIX}/bin/ssleay32.dll: 
	@cp openssl-${OPENSSL_VERSION}/ssleay32-${OPENSSL_LIBVER}.dll ${PREFIX}/bin
	@cp openssl-${OPENSSL_VERSION}/cryptoeay32-${OPENSSL_LIBVER}.dll ${PREFIX}/bin

fetch-tls: tls${TLS_VERSION}-src.tar.gz 
tls${TLS_VERSION}-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/tls/tls${TLS_VERSION}-src.tar.gz"

extract-tls: fetch-tls tls${TLS_SHORT}
tls${TLS_SHORT}:
	@md5sum -c md5sums/tls${TLS_VERSION}-src.tar.gz.md5 || exit 1
	@-tar xfz tls${TLS_VERSION}-src.tar.gz
	@cd tls${TLS_SHORT} && patch -p0 < ../patches/tls.patch

configure-tls: install-openssl extract-tls tls${TLS_SHORT}/Makefile
tls${TLS_SHORT}/Makefile:
	@cd tls${TLS_SHORT} && ./configure --prefix=${PREFIX} --enable-threads --enable-shared --enable-gcc --with-ssl-dir=${PREFIX}

build-tls: configure-tls tls${TLS_SHORT}/tls${TLS_LIBVER}.dll 
tls${TLS_SHORT}/tls${TLS_LIBVER}.dll:
	@cd tls${TLS_SHORT} && make && strip *.dll

install-tls: build-tls ${PREFIX}/lib/tls${TLS_VERSION}
${PREFIX}/lib/tls${TLS_VERSION}: 
	@mkdir -p ${PREFIX}/lib/tls${TLS_VERSION}
	@cd tls${TLS_SHORT} && cp pkgIndex.tcl license.terms tls.tcl tls.htm tls${TLS_LIBVER}.dll ${PREFIX}/lib/tls${TLS_VERSION} 

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

fetch-zlib: zlib-${ZLIB_VERSION}.tar.bz2
zlib-${ZLIB_VERSION}.tar.bz2:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/libpng/zlib-${ZLIB_VERSION}.tar.bz2"

extract-zlib: fetch-zlib zlib-${ZLIB_VERSION}
zlib-${ZLIB_VERSION}:
	@md5sum -c md5sums/zlib-${ZLIB_VERSION}.tar.bz2.md5 || exit 1
	@tar xfj zlib-${ZLIB_VERSION}.tar.bz2
	
configure-zlib: extract-zlib
build-zlib: configure-zlib zlib-${ZLIB_VERSION}/zlib1.dll
zlib-${ZLIB_VERSION}/zlib1.dll:
	@cd zlib-${ZLIB_VERSION} && make -f win32/Makefile.gcc

install-zlib: build-zlib ${PREFIX}/bin/zlib1.dll
${PREFIX}/bin/zlib1.dll:
	@cp zlib-${ZLIB_VERSION}/zlib.h zlib-${ZLIB_VERSION}/zconf.h ${PREFIX}/include
	@cp zlib-${ZLIB_VERSION}/libz.a ${PREFIX}/lib
	@cp zlib-${ZLIB_VERSION}/zlib1.dll ${PREFIX}/bin
				
fetch-pthreads: pthreads-w32-${PTHREADS_VERSION}-release.tar.gz
pthreads-w32-${PTHREADS_VERSION}-release.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@${WGET} ${WGET_FLAGS} "ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-${PTHREADS_VERSION}-release.tar.gz"

extract-pthreads: fetch-pthreads pthreads-w32-${PTHREADS_VERSION}-release
pthreads-w32-${PTHREADS_VERSION}-release:
	@md5sum -c md5sums/pthreads-w32-${PTHREADS_VERSION}-release.tar.gz.md5 || exit 1
	@tar xfz pthreads-w32-${PTHREADS_VERSION}-release.tar.gz

configure-pthreads: extract-pthreads
build-pthreads: configure-pthreads pthreads-w32-${PTHREADS_VERSION}-release/pthreadGC2.dll
pthreads-w32-${PTHREADS_VERSION}-release/pthreadGC2.dll:
	@cd pthreads-w32-${PTHREADS_VERSION}-release && make clean GC

install-pthreads: build-pthreads ${PREFIX}/bin/pthreadGC2.dll
${PREFIX}/bin/pthreadGC2.dll:
	@cd pthreads-w32-${PTHREADS_VERSION}-release && (\
		cp pthreadGC2.dll ${PREFIX}/bin/pthreadGC2.dll; \
		cp libpthreadGC2.a ${PREFIX}/lib/libpthreadGC2.a; \
		cp implement.h need_errno.h pthread.h sched.h semaphore.h ${PREFIX}/include ) 

fetch-postgresql: postgresql-base-${POSTGRESQL_VERSION}.tar.bz2 postgresql-test-${POSTGRESQL_VERSION}.tar.bz2
postgresql-base-${POSTGRESQL_VERSION}.tar.bz2:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} ${WGET_FLAGS} "${POSTGRESQL_MIRROR}/postgresql-base-${POSTGRESQL_VERSION}.tar.bz2"
postgresql-test-${POSTGRESQL_VERSION}.tar.bz2:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@${WGET} ${WGET_FLAGS} "${POSTGRESQL_MIRROR}/postgresql-test-${POSTGRESQL_VERSION}.tar.bz2"

extract-postgresql: fetch-postgresql postgresql-${POSTGRESQL_VERSION}/src/include/sys/time.h 
postgresql-${POSTGRESQL_VERSION}/src/include/sys/time.h:
	@md5sum -c md5sums/postgresql-base-${POSTGRESQL_VERSION}.tar.bz2.md5 || exit 1
	@md5sum -c md5sums/postgresql-test-${POSTGRESQL_VERSION}.tar.bz2.md5 || exit 1
	@tar xfj postgresql-base-${POSTGRESQL_VERSION}.tar.bz2 
	@tar xfj postgresql-test-${POSTGRESQL_VERSION}.tar.bz2
	@cd postgresql-${POSTGRESQL_VERSION} && patch -p0 < ../patches/postgresql.patch
	@mkdir postgresql-${POSTGRESQL_VERSION}/src/include/sys && \
	 touch postgresql-${POSTGRESQL_VERSION}/src/include/sys/time.h

configure-postgresql: extract-postgresql install-openssl install-zlib install-pthreads postgresql-${POSTGRESQL_VERSION}/GNUmakefile 
postgresql-${POSTGRESQL_VERSION}/GNUmakefile:
	@cd postgresql-${POSTGRESQL_VERSION} && ./configure --prefix=${PREFIX} --with-openssl \
		--enable-thread-safety LIBS="-L${PREFIX}/lib" CFLAGS="-I${PREFIX}/include" 

build-postgresql: configure-postgresql postgresql-${POSTGRESQL_VERSION}/src/interfaces/libpq/libpq.dll
postgresql-${POSTGRESQL_VERSION}/src/interfaces/libpq/libpq.dll:
	@cd postgresql-${POSTGRESQL_VERSION} && make LDFLAGS="-L${PREFIX}/lib"

install-postgresql: build-postgresql ${PREFIX}/bin/libpq.dll
${PREFIX}/bin/libpq.dll:
	@cd postgresql-${POSTGRESQL_VERSION}/src/include && make install
	@cd postgresql-${POSTGRESQL_VERSION}/src/interfaces/libpq && make install
	@cp postgresql-${POSTGRESQL_VERSION}/COPYRIGHT ${PREFIX}/lib/COPYRIGHT-PostgreSQL
	@mv -f ${PREFIX}/lib/libpq.dll ${PREFIX}/bin/libpq.dll
	@strip ${PREFIX}/bin/libpq.dll
				
fetch-pgtcl: pgtcl${PGTCL_VERSION}.tar.gz pgtcldocs-${PGTCL_DOCVER}.zip 
pgtcl${PGTCL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@${WGET} "http://pgfoundry.org/frs/download.php/${PGTCL_REL}/pgtcl${PGTCL_VERSION}.tar.gz"
pgtcldocs-${PGTCL_DOCVER}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@${WGET} "http://pgfoundry.org/frs/download.php/${PGTCL_DOCREL}/pgtcldocs-${PGTCL_DOCVER}.zip"

extract-pgtcl: fetch-pgtcl pgtcl${PGTCL_VERSION} pgtcldocs-${PGTCL_DOCVER}
pgtcl${PGTCL_VERSION}:
	@md5sum -c md5sums/pgtcl${PGTCL_VERSION}.tar.gz.md5 || exit 1
	@tar xfz pgtcl${PGTCL_VERSION}.tar.gz
pgtcldocs-${PGTCL_DOCVER}:
	@md5sum -c md5sums/pgtcldocs-${PGTCL_DOCVER}.zip.md5 || exit 1
	@[ -x "${UNZIP}" ] || ( echo "$(MESSAGE_UNZIP)"; exit 1 ) 
	@unzip pgtcldocs-${PGTCL_DOCVER}.zip

configure-pgtcl: extract-pgtcl install-postgresql pgtcl${PGTCL_VERSION}/Makefile
pgtcl${PGTCL_VERSION}/Makefile:
	@cd pgtcl${PGTCL_VERSION} && ./configure --prefix=${PREFIX} --enable-shared \
		--with-tcl=${PREFIX}/lib --with-postgres-include=${PREFIX}/include \
		--with-postgres-lib=${PREFIX}/lib SHARED_LIB_SUFFIX=".dll" \
		LIBS="-L${PREFIX}/lib -lcrypto.dll -lssl.dll" 

build-pgtcl: configure-pgtcl pgtcl${PGTCL_VERSION}/pgtcl1.6.0.dll
pgtcl${PGTCL_VERSION}/pgtcl1.6.0.dll:
	@cd pgtcl${PGTCL_VERSION} && make SHLIB_LD="gcc -shared"

install-pgtcl: build-pgtcl ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/pkgIndex.tcl
${PREFIX}/lib/pgtcl${PGTCL_VERSION}/pkgIndex.tcl:
	@cd pgtcl${PGTCL_VERSION} && make install
	@cp pgtcl${PGTCL_VERSION}/COPYRIGHT ${PREFIX}/lib/pgtcl${PGTCL_VERSION}
	@mkdir ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/docs && cp -rf pgtcldocs-${PGTCL_DOCVER}/* ${PREFIX}/lib/pgtcl${PGTCL_VERSION}/docs

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
	@${WGET} ${WGET_FLAGS} "http://www.xdobry.de/xotclIDE/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz"
xotclide_doc.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@${WGET} ${WGET_FLAGS} "http://www.xdobry.de/xotclIDE/xotclide_doc.tar.gz"

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
	@${WGET} ${WGET_FLAGS} "http://mkextensions.sourceforge.net/mkZiplib${MKZIPLIB_SHORT}.zip"

extract-mkziplib: fetch-mkziplib mkZiplib${MKZIPLIB_VERSION}/Makefile
mkZiplib${MKZIPLIB_VERSION}/Makefile:
	@md5sum -c md5sums/mkZiplib${MKZIPLIB_SHORT}.zip.md5 || exit 1
	@unzip mkZiplib${MKZIPLIB_SHORT}.zip
	@-cd mkZiplib${MKZIPLIB_VERSION} && rm -f *.dll *.exe
	@-cd mkZiplib${MKZIPLIB_VERSION} && patch -p1 < ../patches/mkZiplib.patch

configure-mkziplib: extract-mkziplib

build-mkziplib: configure-mkziplib install-zlib mkZiplib${MKZIPLIB_VERSION}/mkZiplib${MKZIPLIB_SHORT}.dll 
mkZiplib${MKZIPLIB_VERSION}/mkZiplib${MKZIPLIB_SHORT}.dll:
	@cd mkZiplib${MKZIPLIB_VERSION} && make strip CFLAGS="-I${PREFIX}/include" LIBS="${PREFIX}/bin/zlib1.dll"

install-mkziplib: build-mkziplib ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/pkgIndex.tcl
${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}
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

uninstall-openssl:
	@-cd ${PREFIX} && rm -rf bin/openssl.exe bin/ssleay32-*.dll bin/cryptoeay32-*.dll include/openssl lib/libssl.* lib/libcrypto.* lib/engines

uninstall-tls:
	@-cd ${PREFIX} && rm -rf lib/tls${TLS_VERSION}

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

uninstall-zlib:
	@-rm -f ${PREFIX}/include/zconf.h ${PREFIX}/include/zlib.h ${PREFIX}/lib/libz.a ${PREFIX}/bin/zlib1.dll
	
uninstall-pthreads:
	@-rm -f ${PREFIX}/bin/pthreadGC2.dll ${PREFIX}/lib/libpthreadGC2.a
	@-cd ${PREFIX}/include && rm -f implement.h need_errno.h pthread.h sched.h semaphore.h

uninstall-postgresql:
	@-rm -f ${PREFIX}/bin/libpq.dll ${PREFIX}/lib/libpq.a ${PREFIX}/lib/COPYRIGHT-PostgreSQL
	@-cd ${PREFIX} && rm -rf postgres_ext.h pg_config.h pg_config_os.h include/postgresql share/postgresql
 
uninstall-pgtcl:
	@-cd ${PREFIX} && rm -rf include/libpgtcl.h lib/pgtcl${PGTCL_VERSION}

uninstall-ased:
	@-cd ${PREFIX} && rm -rf ${ASED_DIR}

uninstall-xotclide:
	@-cd ${PREFIX} && rm -rf lib/xotclIDE

uninstall-mkziplib:
	@-cd ${PREFIX} && rm -rf lib/mkZiplib${MKZIPLIB_VERSION}

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

clean-openssl:
	@-cd openssl-${OPENSSL_VERSION} && make clean

distclean-openssl:
	@-rm -rf openssl-${OPENSSL_VERSION}

clean-tls:
	@-cd tls${TLS_SHORT} && make clean

distclean-tls:
	@-rm -rf tls${TLS_SHORT}

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

clean-zlib:
	@cd zlib-${ZLIB_VERSION} && make -f win32/Makefile.gcc clean
	
distclean-zlib:
	@-rm -rf zlib-${ZLIB_VERSION}
	
clean-pthreads:
	@cd pthreads-w32-${PTHREADS_VERSION}-release && make clean

distclean-pthreads:
	@-rm -rf pthreads-w32-${PTHREADS_VERSION}-release

clean-postgresql:
	@cd postgresql-${POSTGRESQL_VERSION} && make clean

distclean-postgresql:
	@-rm -rf postgresql-${POSTGRESQL_VERSION}

clean-pgtcl:
	@cd pgtcl${PGTCL_VERSION} && make clean

distclean-pgtcl:
	@-rm -rf pgtcl${PGTCL_VERSION} pgtcldocs-${PGTCL_DOCVER}

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
