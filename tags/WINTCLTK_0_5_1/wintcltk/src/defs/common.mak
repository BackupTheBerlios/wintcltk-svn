# WinTclTk commin.mak
# Copyright (c) 2006-07 Martin Matuska
#
# $Id$
#
# unzip

$(COMMONBUILD):
	@mkdir -p $(COMMONBUILD)
	
# openssl
fetch-openssl: ${DISTFILES} ${DISTFILES}/openssl-${OPENSSL_VERSION}.tar.gz 
${DISTFILES}/openssl-${OPENSSL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"

extract-openssl: fetch-openssl $(COMMONBUILD) $(COMMONBUILD)/openssl-${OPENSSL_VERSION}
$(COMMONBUILD)/openssl-${OPENSSL_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/openssl-${OPENSSL_VERSION}.tar.gz.md5 || exit 1
	@-cd $(COMMONBUILD) && tar xfz ${DISTFILES}/openssl-${OPENSSL_VERSION}.tar.gz >/dev/null 2>&1
	@cd $(COMMONBUILD)/openssl-${OPENSSL_VERSION} && patch -p0 < ${PATCHDIR}/openssl.patch

configure-openssl: extract-openssl $(COMMONBUILD)/openssl-${OPENSSL_VERSION}/configure.done
$(COMMONBUILD)/openssl-${OPENSSL_VERSION}/configure.done:
	@[ -x "${PERL}" ] || ( echo "$(MESSAGE_OPENSSL_PERL)"; exit 1 ) 
	@cd $(COMMONBUILD)/openssl-${OPENSSL_VERSION} && Configure --prefix=${PREFIX} mingw shared threads && touch configure.done 

build-openssl: configure-openssl $(COMMONBUILD)/openssl-$(OPENSSL_VERSION)/libeay32.dll 
$(COMMONBUILD)/openssl-$(OPENSSL_VERSION)/libeay32.dll:
	@cd $(COMMONBUILD)/openssl-${OPENSSL_VERSION} && sh ms/mingw32.sh && strip *.dll

install-openssl: build-openssl ${PREFIX}/bin/libeay32.dll
${PREFIX}/bin/libeay32.dll: 
	@cd $(COMMONBUILD)/openssl-${OPENSSL_VERSION} && make -f ms/mingw32a.mak install MKDIR="mkdir -p" INSTALLTOP="$(PREFIX)"
	@cp $(COMMONBUILD)/openssl-${OPENSSL_VERSION}/out/libssl32.a ${PREFIX}/lib/libssl.dll.a
	@cp $(COMMONBUILD)/openssl-${OPENSSL_VERSION}/out/libeay32.a ${PREFIX}/lib/libcrypto.dll.a
	@cp $(COMMONBUILD)/openssl-${OPENSSL_VERSION}/libeay32.dll $(COMMONBUILD)/openssl-${OPENSSL_VERSION}/libssl32.dll ${PREFIX}/bin
	@cp $(COMMONBUILD)/openssl-${OPENSSL_VERSION}/LICENSE ${PREFIX}/lib/OpenSSL.license

uninstall-openssl:
	@-cd ${PREFIX} && rm -rf bin/openssl.exe bin/libeay32.dll bin/libssl32.dll include/openssl lib/libssl*.a lib/libcrypto*.a 

clean-openssl:
	@-cd $(COMMONBUILD)/openssl-${OPENSSL_VERSION} && make clean

distclean-openssl:
	@-rm -rf $(COMMONBUILD)/openssl-${OPENSSL_VERSION}

# tkcon
fetch-tkcon: $(DISTFILES) $(DISTFILES)/tkcon-$(TKCON_SOURCE)-src.tar.gz
$(DISTFILES)/tkcon-$(TKCON_SOURCE)-src.tar.gz:
	@[ -x "$(WGET)" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd $(DISTFILES) && $(WGET) "http://download.berlios.de/wintcltk/tkcon-${TKCON_SOURCE}-src.tar.gz"

extract-tkcon: fetch-tkcon $(COMMONBUILD) $(COMMONBUILD)/tkcon
$(COMMONBUILD)/tkcon:
	@cd $(DISTFILES) && md5sum -c $(MD5SUMS)/tkcon-$(TKCON_SOURCE)-src.tar.gz.md5 || exit 1
	@cd $(COMMONBUILD) && tar xfz $(DISTFILES)/tkcon-$(TKCON_SOURCE)-src.tar.gz

configure-tkcon: extract-tkcon
build-tkcon: configure-tkcon

install-tkcon: install-tklib build-tkcon $(PREFIX)/lib/tkcon$(TKCON_VERSION)/pkgIndex.tcl
$(PREFIX)/lib/tkcon$(TKCON_VERSION)/pkgIndex.tcl:
	@mkdir -p $(PREFIX)/lib/tkcon$(TKCON_VERSION)
	@cd $(COMMONBUILD)/tkcon && cp -Rp tkcon.tcl pkgIndex.tcl README.txt Changelog extra docs $(PREFIX)/lib/tkcon$(TKCON_VERSION)

uninstall-tkcon:
	@-cd $(PREFIX)/lib && rm -rf tkcon$(TKCON_VERSION)

clean-tkcon:

distclean-tkcon:
	@-rm -rf $(COMMONBUILD)/tkcon

# xotclide
fetch-xotclide: ${DISTFILES} ${DISTFILES}/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz ${DISTFILES}/xotclide_doc.tar.gz 
${DISTFILES}/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.xdobry.de/xotclIDE/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz"
${DISTFILES}/xotclide_doc.tar.gz:
	@[ -x "${WGET}" ] || ( echo "You require wget to auto-download the sources. See SOURCES.txt for more information."; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.xdobry.de/xotclIDE/xotclide_doc.tar.gz"

extract-xotclide: fetch-xotclide ${COMMONBUILD} ${COMMONBUILD}/xotclide-${XOTCLIDE_VERSION} 
${COMMONBUILD}/xotclide-${XOTCLIDE_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz.md5 || exit 1
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/xotclide_doc.tar.gz.md5 || exit 1
	@-cd ${COMMONBUILD} && tar xfz ${DISTFILES}/xotclIDE-${XOTCLIDE_FILEVER}.tar.gz
	@-cd ${COMMONBUILD}/xotclide-${XOTCLIDE_VERSION}/docs && tar xfz ${DISTFILES}/xotclide_doc.tar.gz 

configure-xotclide: install-xotcl extract-xotclide 
build-xotclide: configure-xotclide

install-xotclide: build-xotclide ${PREFIX}/lib/xotclIDE
${PREFIX}/lib/xotclIDE:
	@cd ${COMMONBUILD}/xotclide-${XOTCLIDE_VERSION} && rm -f install && make install PREFIX=${PREFIX}
	@cd ${COMMONBUILD}/xotclide-${XOTCLIDE_VERSION} && cp -rf LICENSE docs ${PREFIX}/lib/xotclIDE

uninstall-xotclide:
	@-cd ${PREFIX} && rm -rf lib/xotclIDE

clean-xotclide:

distclean-xotclide:
	@-rm -rf ${COMMONBUILD}/xotclIDE-${XOTCLIDE_VERSION}

# xosql
fetch-xosql: ${DISTFILES} ${DISTFILES}/xosql-${XOSQL_VERSION}.tar.gz
${DISTFILES}/xosql-${XOSQL_VERSION}.tar.gz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 ) 
	@cd ${DISTFILES} && ${WGET} ${WGET_FLAGS} "http://www.xdobry.de/xosql/xosql-${XOSQL_VERSION}.tar.gz"

extract-xosql: fetch-xosql ${COMMONBUILD} ${COMMONBUILD}/xosql
${COMMONBUILD}/xosql:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/xosql-${XOSQL_VERSION}.tar.gz.md5 || exit 1
	@-cd ${COMMONBUILD} && tar xfz ${DISTFILES}/xosql-${XOSQL_VERSION}.tar.gz

configure-xosql: install-xotcl extract-xosql 
build-xosql: configure-xosql

install-xosql: build-xosql ${PREFIX}/lib/xosql
${PREFIX}/lib/xosql:
	@cp -rf ${COMMONBUILD}/xosql $(PREFIX)/lib

uninstall-xosql:
	@-cd ${PREFIX} && rm -rf lib/xosql

clean-xosql:

distclean-xosql:
	@-rm -rf ${COMMONBUILD}/xosql