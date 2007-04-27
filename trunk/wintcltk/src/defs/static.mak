# WinTclTk static.mak
# Copyright (c) 2006-07 Martin Matuska
#
# $Id$
#
all: install
install: ${PREFIX} install-zip-static install-tcl install-tk install-gdbm install-thread install-tdom install-xotcl install-tgdbm install-tls install-metakit install-memchan install-trf install-mkziplib install-winico install-tklib install-tkhtml install-sqlite install-tktable install-snack install-tkcon install-xosql install-xotclide
uninstall: uninstall-zip-static uninstall-tcl uninstall-tk uninstall-thread uninstall-tdom uninstall-xotcl uninstall-tgdbm uninstall-gdbm uninstall-tls uninstall-openssl uninstall-metakit uninstall-memchan uninstall-trf uninstall-mkziplib uninstall-winico uninstall-tklib uninstall-tkhtml uninstall-sqlite uninstall-tktable uninstall-snack uninstall-tkcon uninstall-xosql uninstall-xotclide
clean: clean-zip-static clean-tcl clean-tk clean-thread clean-tdom clean-xotcl clean-tgdbm clean-gdbm clean-tls clean-openssl clean-metakit clean-memchan clean-trf clean-mkziplib clean-winico clean-tklib clean-tkhtml clean-sqlite clean-tktable clean-snack clean-tkcon clean-xosql clean-xotclide
distclean: distclean-zip-static distclean-tcl distclean-tk distclean-thread distclean-tdom distclean-xotcl distclean-tgdbm distclean-gdbm distclean-tls distclean-openssl distclean-metakit distclean-memchan distclean-trf distclean-mkziplib distclean-winico distclean-tklib distclean-tkhtml distclean-sqlite distclean-tktable distclean-snack distclean-tkcon distclean-xosql distclean-xotclide

# directories
${DISTFILES}:
	@[ -d "${DISTFILES}" ] || mkdir -p ${DISTFILES}

${BUILDDIR}:
	@[ -d "${BUILDDIR}" ] || mkdir -p ${BUILDDIR}

${PREFIX}:
	@[ -d "${PREFIX}" ] || mkdir -p ${PREFIX}/bin ${PREFIX}/lib ${PREFIX}/include

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

build-gdbm: configure-gdbm ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32/libgdbm-static.a 
${BUILDDIR}/gdbm-${GDBM_VERSION}/win32/libgdbm-static.a:
	@cd ${BUILDDIR}/gdbm-${GDBM_VERSION}/win32 && make DLL=0

install-gdbm: build-gdbm ${PREFIX}/lib/libgdbm-static.a
${PREFIX}/lib/libgdbm-static.a: 
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

install-thread: build-thread ${PREFIX}/lib/thread${THREAD_VERSION}/thread$(THREAD_LIBVER).a
${PREFIX}/lib/thread${THREAD_VERSION}/thread$(THREAD_LIBVER).a: 
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
	@cd ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix && CPPFLAGS="-DSTATIC_BUILD=1" ./configure --prefix=${PREFIX} --libdir=${PREFIX}/bin --with-tcl=${PREFIX}/include --enable-threads --disable-shared --enable-static

build-metakit: configure-metakit ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix/Mk4tcl.lib 
${BUILDDIR}/metakit-${METAKIT_VERSION}/unix/Mk4tcl.lib:
	@cd ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix && make

install-metakit: build-metakit ${PREFIX}/lib/Mk4tcl/Mk4tcl.lib
${PREFIX}/lib/Mk4tcl/Mk4tcl.lib: 
	@cd ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix && make install 

uninstall-metakit:
	@-cd ${PREFIX} && rm -rf bin/libmk4.lib include/mk4* lib/Mk4tcl

clean-metakit:
	@-cd ${BUILDDIR}/metakit-${METAKIT_VERSION}/unix && make clean

distclean-metakit:
	@-rm -rf ${BUILDDIR}/metakit-${METAKIT_VERSION}
	
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

install-zip-static: build-zip-static	
	
clean-zip-static:
	@cd ${BUILDDIR}/zip-${ZIP_VERSION} && make -f win32/makefile.gcc clean
	
distclean-zip-static:
	@-rm -rf ${BUILDDIR}/zip-${ZIP_VERSION}

# memchan
fetch-memchan: $(DISTFILES)/memchan-$(MEMCHAN_VERSION).tar.gz
$(DISTFILES)/memchan-$(MEMCHAN_VERSION).tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/memchan/memchan-$(MEMCHAN_VERSION).tar.gz"
		
extract-memchan: fetch-memchan $(BUILDDIR) $(BUILDDIR)/memchan-$(MEMCHAN_VERSION)/win/Makefile.gnu
$(BUILDDIR)/memchan-$(MEMCHAN_VERSION)/win/Makefile.gnu:
	@cd ${DISTFILES} && md5sum -c $(MD5SUMS)/memchan-$(MEMCHAN_VERSION).tar.gz.md5 || exit 1
	@cd $(BUILDDIR) && tar xfz $(DISTFILES)/memchan-$(MEMCHAN_VERSION).tar.gz
	@-cd $(BUILDDIR)/memchan-$(MEMCHAN_VERSION) && patch -p0 < $(PATCHDIR)/memchan.patch

configure-memchan: extract-memchan install-tcl

build-memchan: configure-memchan $(BUILDDIR)/memchan-$(MEMCHAN_VERSION)/win/memchan${MEMCHAN_LIBVER}.a
$(BUILDDIR)/memchan-$(MEMCHAN_VERSION)/win/memchan${MEMCHAN_LIBVER}.a :
	@cd $(BUILDDIR)/memchan-$(MEMCHAN_VERSION)/win && make -f Makefile.gnu memchan${MEMCHAN_LIBVER}.a TCL_INC_DIR="$(PREFIX)/include" DLL_LDLIBS="-L$(PREFIX)/lib -ltclstub84s"

install-memchan: build-memchan $(PREFIX)/lib/memchan$(MEMCHAN_VERSION)/memchan$(MEMCHAN_LIBVER).a
$(PREFIX)/lib/memchan$(MEMCHAN_VERSION)/memchan$(MEMCHAN_LIBVER).a:
	@mkdir -p $(PREFIX)/lib/memchan$(MEMCHAN_VERSION)
	@cp $(BUILDDIR)/memchan-$(MEMCHAN_VERSION)/win/memchan$(MEMCHAN_LIBVER).a $(PREFIX)/lib/memchan$(MEMCHAN_VERSION)
		
uninstall-memchan:
	@-cd $(PREFIX)/lib && rm -rf memchan${MEMCHAN_VERSION}

clean-memchan:
	@-cd $(BUILDDIR)/memchan-$(MEMCHAN_VERSION)/win && make -f Makefile.gnu clean

distclean-memchan:
	@-rm -rf $(BUILDDIR)/memchan-$(MEMCHAN_VERSION)	

# trf
fetch-trf: $(DISTFILES)/trf$(TRF_VERSION).tar.gz
$(DISTFILES)/trf$(TRF_VERSION).tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tcltrf/trf$(TRF_VERSION).tar.gz"
		
extract-trf: fetch-trf $(BUILDDIR) $(BUILDDIR)/trf$(TRF_VERSION)/win/Makefile.gnu
$(BUILDDIR)/trf$(TRF_VERSION)/win/Makefile.gnu:
	@cd ${DISTFILES} && md5sum -c $(MD5SUMS)/trf$(TRF_VERSION).tar.gz.md5 || exit 1
	@cd $(BUILDDIR) && tar xfz $(DISTFILES)/trf$(TRF_VERSION).tar.gz
	@-cd $(BUILDDIR)/trf$(TRF_VERSION) && patch -p0 < $(PATCHDIR)/trf.patch

configure-trf: extract-trf install-tcl

build-trf: configure-trf $(BUILDDIR)/trf$(TRF_VERSION)/win/libTrf$(TRF_LIBVER)s.a
$(BUILDDIR)/trf$(TRF_VERSION)/win/libTrf$(TRF_LIBVER)s.a:
	@cd $(BUILDDIR)/trf$(TRF_VERSION)/win && make -f Makefile.gnu libTrf21s.a TCL_SRC_DIR="$(BUILDDIR)/tcl$(TCLTK_VERSION)" ZLIB_STATIC="-DZLIB_STATIC_BUILD"

install-trf: build-trf $(PREFIX)/lib/trf$(TRF_VERSION)/libTrf$(TRF_LIBVER)s.a
$(PREFIX)/lib/trf$(TRF_VERSION)/libTrf$(TRF_LIBVER)s.a:
	@mkdir -p $(PREFIX)/lib/trf$(TRF_VERSION)
	@cd $(BUILDDIR)/trf$(TRF_VERSION)/win && cp libTrf$(TRF_LIBVER)s.a $(PREFIX)/lib/trf$(TRF_VERSION)
		
uninstall-trf:
	@-cd $(PREFIX)/lib && rm -rf trf${TRF_VERSION}
	@-cd $(PREFIX)/include && rm -f transform.h trfDecls.h

clean-trf:
	@-cd $(BUILDDIR)/trf$(TRF_VERSION)/win && make -f Makefile.gnu clean

distclean-trf:
	@-rm -rf $(BUILDDIR)/trf$(TRF_VERSION)

# tklib
fetch-tklib: ${DISTFILES} ${DISTFILES}/tklib-${TKLIB_VERSION}.tar.gz 
${DISTFILES}/tklib-${TKLIB_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/sourceforge/tklib/tklib-${TKLIB_VERSION}.tar.gz"

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
	
# mkziplib
fetch-mkziplib: ${DISTFILES}/mkziplib${MKZIPLIB_SHORT}.zip
${DISTFILES}/mkziplib${MKZIPLIB_SHORT}.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://mkextensions.sourceforge.net/mkZiplib${MKZIPLIB_SHORT}.zip"

extract-mkziplib: fetch-mkziplib install-unzip ${BUILDDIR} ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION}/Makefile
${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION}/Makefile:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/mkZiplib${MKZIPLIB_SHORT}.zip.md5 || exit 1
	@cd ${BUILDDIR} && ${UNZIP} ${DISTFILES}/mkZiplib${MKZIPLIB_SHORT}.zip
	@-cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && rm -f *.dll *.exe
	@-cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && patch -p1 < ${PATCHDIR}/mkZiplib.patch
	@-cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && patch -p1 < ${PATCHDIR}/mkZiplib.static.patch
	
configure-mkziplib: extract-mkziplib install-tcl

build-mkziplib: configure-mkziplib install-zlib ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION}/mkZiplib${MKZIPLIB_SHORT}.a 
${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION}/mkZiplib${MKZIPLIB_SHORT}.a:
	@cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && make CFLAGS="-I$(PREFIX)/include -DUSE_TCL_STUBS -DSTATIC_BUILD=1" TCLLIB="${PREFIX}/lib/libtclstub84s.a" PREFIX="${PREFIX}" LIBS=""

install-mkziplib: build-mkziplib ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/pkgIndex.tcl
${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}/pkgIndex.tcl:
	@mkdir -p ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}
	@cd ${BUILDDIR}/mkZiplib${MKZIPLIB_VERSION} && cp mkZiplib${MKZIPLIB_SHORT}.a pkgIndex.tcl ${PREFIX}/lib/mkZiplib${MKZIPLIB_VERSION}

uninstall-mkziplib:
	@-cd ${PREFIX} && rm -rf lib/mkZiplib${MKZIPLIB_VERSION}

clean-mkziplib:
	@-cd ${BUILDDIR}/mkziplib${MKZIPLIB_VERSION} && rm -f *.o *.a

distclean-mkziplib:
	@-rm -rf ${BUILDDIR}/mkziplib${MKZIPLIB_VERSION}

# winico
fetch-winico: ${DISTFILES} ${DISTFILES}/winico${subst .,,$(WINICO_VERSION)}src.zip
${DISTFILES}/winico${subst .,,$(WINICO_VERSION)}src.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/tktable/winico${subst .,,$(WINICO_VERSION)}src.zip"

extract-winico: fetch-winico ${BUILDDIR} ${BUILDDIR}/winico-${WINICO_VERSION}
${BUILDDIR}/winico-${WINICO_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/winico${subst .,,$(WINICO_VERSION)}src.zip.md5 || exit 1
	@-cd ${BUILDDIR} && $(UNZIP) ${DISTFILES}/winico${subst .,,$(WINICO_VERSION)}src.zip
	@-cd ${BUILDDIR}/winico-${WINICO_VERSION} && patch -p0 < $(PATCHDIR)/winico.patch
	@-cd ${BUILDDIR}/winico-${WINICO_VERSION} && patch -p0 < $(PATCHDIR)/winico.static.patch
	
configure-winico: install-tk extract-winico ${BUILDDIR}/winico-${WINICO_VERSION}/Makefile
${BUILDDIR}/winico-${WINICO_VERSION}/Makefile:
	@cd ${BUILDDIR}/winico-${WINICO_VERSION} && ./configure --prefix=${PREFIX} --enable-threads --disable-shared --enable-static --with-tcl=${PREFIX}/lib --with-tk=${PREFIX}/lib

build-winico: configure-winico ${BUILDDIR}/winico-${WINICO_VERSION}/Winico${subst .,,$(WINICO_VERSION)}.a 
${BUILDDIR}/winico-${WINICO_VERSION}/Winico${subst .,,$(WINICO_VERSION)}.a :
	@cd ${BUILDDIR}/winico-${WINICO_VERSION} && make binaries

install-winico: build-winico ${PREFIX}/lib/Winico${WINICO_VERSION}
${PREFIX}/lib/Winico${WINICO_VERSION}:
	@cd ${BUILDDIR}/winico-${WINICO_VERSION} && make install-binaries

uninstall-winico:
	@-cd ${PREFIX} && rm -rf lib/Winico${WINICO_VERSION}

clean-winico:
	@-cd ${BUILDDIR}/winico-${WINICO_VERSION} && make clean

distclean-winico:
	@-rm -rf ${BUILDDIR}/winico-${WINICO_VERSION}

# tktable
fetch-tktable: ${DISTFILES} ${DISTFILES}/Tktable$(TKTABLE_VERSION).tar.gz
${DISTFILES}/Tktable$(TKTABLE_VERSION).tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/tktable/Tktable$(TKTABLE_VERSION).tar.gz"

extract-tktable: fetch-tktable ${BUILDDIR} ${BUILDDIR}/Tktable${TKTABLE_VERSION}
${BUILDDIR}/Tktable${TKTABLE_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/Tktable$(TKTABLE_VERSION).tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/Tktable$(TKTABLE_VERSION).tar.gz
	@-cd ${BUILDDIR}/Tktable${TKTABLE_VERSION} && patch -p0 < $(PATCHDIR)/tktable.patch

configure-tktable: install-tk extract-tktable ${BUILDDIR}/Tktable${TKTABLE_VERSION}/Makefile
${BUILDDIR}/Tktable${TKTABLE_VERSION}/Makefile:
	@cd ${BUILDDIR}/Tktable${TKTABLE_VERSION} && ./configure --prefix=${PREFIX} --enable-threads --disable-shared --enable-static --with-tcl=${PREFIX}/lib --with-tk=${PREFIX}/lib

build-tktable: configure-tktable ${BUILDDIR}/tktable${TKTABLE_VERSION}/Tktable${subst .,,$(TKTABLE_VERSION)}.a
${BUILDDIR}/tktable${TKTABLE_VERSION}/Tktable${subst .,,$(TKTABLE_VERSION)}.a :
	@cd ${BUILDDIR}/tktable${TKTABLE_VERSION} && make binaries

install-tktable: build-tktable ${PREFIX}/lib/Tktable${TKTABLE_VERSION}
${PREFIX}/lib/Tktable${TKTABLE_VERSION}:
	@cd ${BUILDDIR}/Tktable${TKTABLE_VERSION} && make install

uninstall-tktable:
	@-cd ${PREFIX} && rm -rf lib/Tktable${TKTABLE_VERSION}

clean-tktable:
	@-cd ${BUILDDIR}/Tktable${TKTABLE_VERSION} && make clean

distclean-tktable:
	@-rm -rf ${BUILDDIR}/Tktable${TKTABLE_VERSION}
		
# snack
fetch-snack: ${DISTFILES} ${DISTFILES}/snack$(SNACK_VERSION).tar.gz ${DISTFILES}/ming.zip
${DISTFILES}/snack$(SNACK_VERSION).tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.speech.kth.se/snack/dist/snack${SNACK_VERSION}.tar.gz"
${DISTFILES}/ming.zip:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://people.montana.com/%7Ebowman/Software/ming.zip"
			
extract-snack: fetch-snack ${BUILDDIR} ${BUILDDIR}/snack${SNACK_VERSION}/win/i386-mingw32
${BUILDDIR}/snack${SNACK_VERSION}/win/i386-mingw32:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/snack$(SNACK_VERSION).tar.gz.md5 || exit 1
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/ming.zip.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/snack$(SNACK_VERSION).tar.gz
	@-cd ${BUILDDIR}/snack${SNACK_VERSION} && patch -p0 < $(PATCHDIR)/snack.patch && patch -p0 < $(PATCHDIR)/snack.static.patch
	@-cd ${BUILDDIR}/snack$(SNACK_VERSION)/win && $(UNZIP) ${DISTFILES}/ming.zip
	
configure-snack: install-tk extract-snack ${BUILDDIR}/snack${SNACK_VERSION}/win/Makefile
${BUILDDIR}/snack${SNACK_VERSION}/win/Makefile:
	@cd ${BUILDDIR}/snack${SNACK_VERSION}/win && \
		CFLAGS="$(CFLAGS) -I./i386-mingw32/include" \
		LDFLAGS="$(LDFLAGS) -L./i386-mingw32/lib" \
		./configure --prefix=${PREFIX} --enable-threads --disable-shared --enable-static --with-tcl=${PREFIX}/lib --with-tk=${PREFIX}/lib

build-snack: configure-snack ${BUILDDIR}/snack${SNACK_VERSION}/win/libsnack.a 
${BUILDDIR}/snack${SNACK_VERSION}/win/libsnack.a :
	@cd ${BUILDDIR}/snack${SNACK_VERSION}/win && make

install-snack: build-snack ${PREFIX}/lib/snack${SNACK_SHORT}
${PREFIX}/lib/snack$(SNACK_SHORT):
	@cd $(BUILDDIR)/snack$(SNACK_VERSION)/win && make install
	@cd $(BUILDDIR)/snack$(SNACK_VERSION) && cp -f doc/tcl-man.html $(PREFIX)/lib/snack$(SNACK_SHORT)
	
uninstall-snack:
	@-cd ${PREFIX} && rm -rf lib/snack$(SNACK_SHORT)

clean-snack:
	@-cd ${BUILDDIR}/snack${SNACK_VERSION} && make clean

distclean-snack:
	@-rm -rf ${BUILDDIR}/snack${SNACK_VERSION}
	
# tkhtml
fetch-tkhtml: ${DISTFILES} ${DISTFILES}/tkhtml-$(TKHTML_VERSION)-src.tar.gz
${DISTFILES}/tkhtml-$(TKHTML_VERSION)-src.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://download.berlios.de/wintcltk/tkhtml-${TKHTML_VERSION}-src.tar.gz"

extract-tkhtml: fetch-tkhtml ${BUILDDIR} ${BUILDDIR}/tkhtml-${TKHTML_VERSION}
${BUILDDIR}/tkhtml-${TKHTML_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/tkhtml-$(TKHTML_VERSION)-src.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/tkhtml-$(TKHTML_VERSION)-src.tar.gz

configure-tkhtml: install-tk extract-tkhtml ${BUILDDIR}/tkhtml-${TKHTML_VERSION}/Makefile
${BUILDDIR}/tkhtml-${TKHTML_VERSION}/Makefile:
	@cd ${BUILDDIR}/tkhtml-${TKHTML_VERSION} && ./configure --prefix=${PREFIX} --enable-threads --disable-shared --enable-static --with-tcl=${PREFIX}/lib --with-tk=${PREFIX}/lib

build-tkhtml: configure-tkhtml ${BUILDDIR}/tkhtml-${TKHTML_VERSION}/Tkhtml$(TKHTML_LIBVER).a
${BUILDDIR}/tkhtml-${TKHTML_VERSION}/Tkhtml$(TKHTML_LIBVER).a:
	@cd ${BUILDDIR}/tkhtml-${TKHTML_VERSION} && make STLIB_LD="ar rcs" CFLAGS_DEFAULT="-O2" \
		SHLIB_CFLAGS="" LDFLAGS_OPTIMIZE="" EXTRA_CFLAGS="" \
		Tkhtml_LIB_FILE="Tkhtml$(TKHTML_LIBVER).a" Tkhtmlstub_LIB_FILE="Tkhtmlstub$(TKHTML_LIBVER).a"

install-tkhtml: build-tkhtml ${PREFIX}/lib/tkhtml${TKHTML_VERSION}
${PREFIX}/lib/tkhtml${TKHTML_VERSION}:
	@cd ${BUILDDIR}/tkhtml-${TKHTML_VERSION} && make install \
		Tkhtml_LIB_FILE="Tkhtml$(TKHTML_LIBVER).a" Tkhtmlstub_LIB_FILE="Tkhtmlstub$(TKHTML_LIBVER).a"
	
uninstall-tkhtml:
	@-cd ${PREFIX} && rm -rf lib/Tkhtml${TKHTML_VERSION}

clean-tkhtml:
	@-cd ${BUILDDIR}/tkhtml-${TKHTML_VERSION} && make clean \
		Tkhtml_LIB_FILE="Tkhtml$(TKHTML_LIBVER).a" Tkhtmlstub_LIB_FILE="Tkhtmlstub$(TKHTML_LIBVER).a"

distclean-tkhtml:
	@-rm -rf ${BUILDDIR}/tkhtml-${TKHTML_VERSION}
	
# sqlite
fetch-sqlite: ${DISTFILES} ${DISTFILES}/sqlite-$(SQLITE_TEA)-tea.tar.gz
${DISTFILES}/sqlite-$(SQLITE_TEA)-tea.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.sqlite.org/sqlite-$(SQLITE_TEA)-tea.tar.gz"

extract-sqlite: fetch-sqlite ${BUILDDIR} ${BUILDDIR}/sqlite-$(SQLITE_TEA)-tea
${BUILDDIR}/sqlite-${SQLITE_TEA}-tea:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/sqlite-$(SQLITE_TEA)-tea.tar.gz.md5 || exit 1
	@-cd ${BUILDDIR} && tar xfz ${DISTFILES}/sqlite-$(SQLITE_TEA)-tea.tar.gz

configure-sqlite: install-tk extract-sqlite ${BUILDDIR}/sqlite-${SQLITE_TEA}-tea/Makefile
${BUILDDIR}/sqlite-${SQLITE_TEA}-tea/Makefile:
	@cd ${BUILDDIR}/sqlite-${SQLITE_TEA}-tea && ./configure --prefix=$(PREFIX) --enable-threads --disable-shared --enable-static --with-tcl=${PREFIX}/lib

build-sqlite: configure-sqlite ${BUILDDIR}/sqlite-${SQLITE_TEA}-tea/sqlite$(SQLITE_LIBVER).a
${BUILDDIR}/sqlite-${SQLITE_TEA}-tea/sqlite$(SQLITE_LIBVER).a:
	@cd ${BUILDDIR}/sqlite-${SQLITE_TEA}-tea && make

install-sqlite: build-sqlite ${PREFIX}/lib/sqlite${SQLITE_VERSION}
${PREFIX}/lib/sqlite${SQLITE_VERSION}:
	@cd ${BUILDDIR}/sqlite-${SQLITE_TEA}-tea && make install
	
uninstall-sqlite:
	@-cd ${PREFIX} && rm -rf lib/sqlite${SQLITE_VERSION}

clean-sqlite:
	@-cd ${BUILDDIR}/sqlite-${SQLITE_VERSION} && make clean

distclean-sqlite:
	@-rm -rf ${BUILDDIR}/sqlite-${SQLITE_VERSION}