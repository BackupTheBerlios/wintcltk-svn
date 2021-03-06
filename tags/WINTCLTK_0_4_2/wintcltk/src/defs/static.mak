# WinTclTk static.mak
# Copyright (c) 2006-07 Martin Matuska
#
# $Id$
#
all: install
install: install-tcl install-tk install-gdbm install-thread install-tdom install-xotcl install-tgdbm install-tls install-metakit install-mysqltcl install-pgtcl install-tcllib install-tklib install-bwidget install-mkziplib install-twapi 
uninstall: uninstall-tcl uninstall-tk uninstall-thread uninstall-tdom uninstall-xotcl uninstall-tgdbm uninstall-gdbm uninstall-tls uninstall-openssl uninstall-metakit uninstall-mysqlctl uninstall-pgtcl uninstall-postgresql uninstall-pthreads uninstall-tcllib uninstall-tklib uninstall-bwidget uninstall-mkziplib uninstall-zlib uninstall-twapi
clean: clean-tcl clean-tk clean-thread clean-tdom clean-xotcl clean-tgdbm clean-gdbm clean-tls clean-openssl clean-metakit clean-mysqltcl clean-pgtcl clean-postgresql clean-pthreads clean-tcllib clean-tklib clean-bwidget clean-mkziplib clean-zlib clean-twapi
distclean: distclean-tcl distclean-tk distclean-thread distclean-tdom distclean-xotcl distclean-tgdbm distclean-gdbm distclean-tls distclean-openssl distclean-metakit distclean-mysqltcl distclean-pgtcl distclean-postgresql distclean-pthreads distclean-tcllib distclean-tklib distclean-bwidget distclean-mkziplib distclean-zlib distclean-twapi
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
	@cd ${BUILDDIR}/tcl${TCLTK_VERSION}/win && ./configure --prefix=${PREFIX} --disable-shared --enable-static --enable-threads 

build-tcl: configure-tcl ${BUILDDIR} ${BUILDDIR}/tcl${TCLTK_VERSION}/win/tclsh84s.exe
${BUILDDIR}/tcl${TCLTK_VERSION}/win/tclsh84s.exe:
	@cd ${BUILDDIR}/tcl${TCLTK_VERSION}/win && make && strip *.exe

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
	@cd ${BUILDDIR}/tk${TCLTK_VERSION}/win && ./configure --prefix=${PREFIX} --disable-shared --enable-static --enable-threads

build-tk: configure-tk ${BUILDDIR}/tk${TCLTK_VERSION}/win/wish84s.exe 
${BUILDDIR}/tk${TCLTK_VERSION}/win/wish84s.exe:
	@cd ${BUILDDIR}/tk${TCLTK_VERSION}/win && make && strip *.exe

install-tk: build-tk ${PREFIX}/lib/tkConfig.sh 
${PREFIX}/lib/tkConfig.sh:
	@cd ${BUILDDIR}/tk${TCLTK_VERSION}/win && make install
	@cp ${PREFIX}/bin/tclsh84s.exe ${PREFIX}/bin/tclsh84.exe
	
uninstall-tk:
	@-cd ${PREFIX}/bin && rm wish*.exe
	@-cd ${PREFIX}/lib && rm -rf tk* libtk*.a libtkstub*.a tkConfig.sh
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

build-gdbm: configure-gdbm ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32/gdbm-static.a 
${BUILDDIR}/gdbm-${GDBM_VERSION}/win32/gdbm-static.a:
	@cd ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32 && make DLL=0

install-gdbm: build-gdbm ${PREFIX}/lib/gdbm-static.a
${PREFIX}/lib/gdbm-static.a: 
	@cd ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32 && make install DLL=0 prefix=$(PREFIX)

uninstall-gdbm:
	@-cd ${PREFIX} && rm -rf lib/gdbm-static.a include/dbm.h include/gdbm.h include/ndbm.h

clean-gdbm:
	@-cd ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32 && make clean

distclean-gdbm:
	@-rm -rf ${BUILDDIR}/gdbm-${GDBM_VERSION}
		
# tgdbm
fetch-tgdbm: ${DISTFILES} ${DISTFILES}/tgdbm${TGDBM_VERSION}.zip 
${DISTFILES}/tgdbm${TGDBM_VERSION}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.vogel-nest.de/wiki/uploads/Main/tgdbm${TGDBM_VERSION}.zip"

extract-tgdbm: fetch-tgdbm install-unzip ${BUILDDIR} ${BUILDDIR}/tgdbm${TGDBM_VERSION}
${BUILDDIR}/tgdbm${TGDBM_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tgdbm${TGDBM_VERSION}.zip.md5 || exit 1
	@cd ${BUILDDIR} && ${UNZIP} ${DISTFILES}/tgdbm$(TGDBM_VERSION).zip
	@cd ${BUILDDIR}/tgdbm$(TGDBM_VERSION) && patch -p0 < ${PATCHDIR}/tgdbm.static.patch
	@cd ${BUILDDIR}/tgdbm$(TGDBM_VERSION) && rm tgdbm.dll

configure-tgdbm: extract-tgdbm

build-tgdbm: configure-tgdbm ${BUILDDIR}/tgdbm$(TGDBM_VERSION)/tgdbm.a 
${BUILDDIR}/tgdbm${TGDBM_VERSION}/tgdbm.a:
	@cd ${BUILDDIR}/tgdbm${TGDBM_VERSION} && make -f Makefile.mingw TCL=$(PREFIX) GDBM_LIB_DIR=$(PREFIX)/bin GDBM_DIR=$(PREFIX)/include GDBM_WINDIR=$(PREFIX)/include STATIC_BUILD=1 GDBM_STATIC=1

install-tgdbm: build-tgdbm ${PREFIX}/lib/tgdbm$(TGDBM_VERSION)
${PREFIX}/lib/tgdbm$(TGDBM_VERSION):
	@mkdir -p $(PREFIX)/lib/tgdbm$(TGDBM_VERSION)
	@cd ${BUILDDIR}/tgdbm$(TGDBM_VERSION) && cp tgdbm.a qgdbm.tcl $(PREFIX)/lib/tgdbm$(TGDBM_VERSION)

uninstall-tgdbm:
	@-cd ${PREFIX} && rm -rf lib/tgdbm$(TGDBM_VERSION)	

clean-tgdbm:
	@-cd ${BUILDDIR}/tgdbm$(TGDBM_VERSION) && rm -rf mingw_release tgdbm.a

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
	@cd ${BUILDDIR}/thread${THREAD_VERSION} && CFLAGS="$(CFLAGS) -DGDBM_STATIC" ./configure --prefix=${PREFIX} --enable-static --disable-shared --enable-threads \
		--with-tcl=${PREFIX}/lib --with-gdbm 

build-thread: configure-thread ${BUILDDIR}/thread${THREAD_VERSION}/thread${THREAD_LIBVER}.a
${BUILDDIR}/thread${THREAD_VERSION}/thread${THREAD_LIBVER}.a :
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
	@cd ${BUILDDIR}/tDOM-${TDOM_VERSION} && ./configure --prefix="${PREFIX}" --with-tcl="${PREFIX}/lib" --disable-shared --enable-static

build-tdom: configure-tdom ${BUILDDIR}/tDOM-${TDOM_VERSION}/tdom${TDOM_LIBVER}.a
${BUILDDIR}/tDOM-${TDOM_VERSION}/tdom${TDOM_LIBVER}.a:
	@cd ${BUILDDIR}/tDOM-${TDOM_VERSION} && make

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
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && patch -p0 < ${PATCHDIR}/xotcl-static.patch
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && autoconf
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION}/library/xml/TclExpat-1.1 && autoconf

configure-xotcl: install-tcl install-gdbm extract-xotcl ${BUILDDIR}/xotcl-${XOTCL_VERSION}/Makefile 
${BUILDDIR}/xotcl-${XOTCL_VERSION}/Makefile:
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && CFLAGS="$(CFLAGS) -DGDBM_STATIC" ./configure --prefix=${PREFIX} --disable-shared --enable-static --enable-threads \
		--with-tcl=${PREFIX}/lib --with-actiweb --with-gdbm=${PREFIX}/include,${PREFIX}/bin	

build-xotcl: configure-xotcl ${BUILDDIR}/xotcl-${XOTCL_VERSION}/xotcl${XOTCL_LIBVER}.a
${BUILDDIR}/xotcl-${XOTCL_VERSION}/xotcl${XOTCL_LIBVER}.a:
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && make binaries xotclsh
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && make TCLSH_PROG=xotclsh.exe

install-xotcl: build-xotcl ${PREFIX}/lib/xotclConfig.sh
${PREFIX}/lib/xotclConfig.sh: 
	@cd ${BUILDDIR}/xotcl-${XOTCL_VERSION} && make install
	
uninstall-xotcl:
	@-cd ${PREFIX}/lib && rm -rf xotcl${XOTCL_VERSION} xotclConfig.sh
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
	@cd ${BUILDDIR}/openssl-${OPENSSL_VERSION} && sh ms/mingw32.sh

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
	@cd ${BUILDDIR}/tls${TLS_SHORT} && patch -p0 < ${PATCHDIR}/tls.static.patch

configure-tls: install-openssl extract-tls ${BUILDDIR}/tls${TLS_SHORT}/Makefile
${BUILDDIR}/tls${TLS_SHORT}/Makefile:
	@cd ${BUILDDIR}/tls${TLS_SHORT} && ./configure --prefix=${PREFIX} --enable-threads --disable-shared --enable-static --enable-gcc --with-ssl-dir=${PREFIX}

build-tls: configure-tls ${BUILDDIR}/tls${TLS_SHORT}/tls${TLS_LIBVER}s.a
${BUILDDIR}/tls${TLS_SHORT}/tls${TLS_LIBVER}s.a:
	@cd ${BUILDDIR}/tls${TLS_SHORT} && make

install-tls: build-tls ${PREFIX}/lib/tls${TLS_VERSION}
${PREFIX}/lib/tls${TLS_VERSION}: 
	@mkdir -p ${PREFIX}/lib/tls${TLS_VERSION}
	@cd ${BUILDDIR}/tls${TLS_SHORT} && cp tls${TLS_LIBVER}s.a ${PREFIX}/lib/tls${TLS_VERSION} 

uninstall-tls:
	@-cd ${PREFIX} && rm -rf lib/tls${TLS_VERSION}

clean-tls:
	@-cd ${BUILDDIR}/tls${TLS_SHORT} && make clean

distclean-tls:
	@-rm -rf ${BUILDDIR}/tls${TLS_SHORT}

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
build-zlib: configure-zlib ${BUILDDIR}/zlib-${ZLIB_VERSION}/libz.a
${BUILDDIR}/zlib-${ZLIB_VERSION}/libz.a:
	@cd ${BUILDDIR}/zlib-${ZLIB_VERSION} && make -f win32/Makefile.gcc

install-zlib: build-zlib ${PREFIX}/lib/libz.a
${PREFIX}/lib/libz.a:
	@cp ${BUILDDIR}/zlib-${ZLIB_VERSION}/zlib.h ${BUILDDIR}/zlib-${ZLIB_VERSION}/zconf.h ${PREFIX}/include
	@cp ${BUILDDIR}/zlib-${ZLIB_VERSION}/libz.a ${PREFIX}/lib
	@cp ${BUILDDIR}/zlib-${ZLIB_VERSION}/zlib1.dll ${PREFIX}/bin

uninstall-zlib:
	@-rm -f ${PREFIX}/include/zconf.h ${PREFIX}/include/zlib.h ${PREFIX}/lib/libz.a ${PREFIX}/bin/zlib1.dll

clean-zlib:
	@cd ${BUILDDIR}/zlib-${ZLIB_VERSION} && make -f win32/Makefile.gcc clean
	
distclean-zlib:
	@-rm -rf ${BUILDDIR}/zlib-${ZLIB_VERSION}

# static-zip

extract-zip-static: fetch-zip ${BUILDDIR} ${BUILDDIR}/zip-${ZIP_VERSION}
${BUILDDIR}/zip-${ZIP_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/zip$(ZIP_SHORT).tgz.md5 || exit 1
	@cd ${BUILDDIR} && tar xfz ${DISTFILES}/zip$(ZIP_SHORT).tgz
	
configure-zip-static: extract-zip-static install-zlib
build-zip-static: configure-zip-static ${BUILDDIR}/zip-${ZIP_VERSION}/zip.exe
${BUILDDIR}/zip-${ZIP_VERSION}/zip.exe:
	@cd ${BUILDDIR}/zip-${ZIP_VERSION} && make -f win32/makefile.gcc USEZLIB=1 LOC="-I$(PREFIX)/include" LD="gcc -L$(PREFIX)/lib"

clean-zip-static:
	@cd ${BUILDDIR}/zip-${ZIP_VERSION} && make -f win32/makefile.gcc clean
	
distclean-zip-static:
	@-rm -rf ${BUILDDIR}/zip-${ZIP_VERSION}
