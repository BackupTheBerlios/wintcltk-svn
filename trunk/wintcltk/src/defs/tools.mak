# WinTclTk tools.mak
# Copyright (c) 2006-07 Martin Matuska
#
# $Id$
#
# unzip
$(TOOLSDIR)/build:
	@mkdir -p $(TOOLSDIR)/build
	
fetch-unzip: ${DISTFILES} ${DISTFILES}/unzip$(UNZIP_SHORT).tgz
${DISTFILES}/unzip$(UNZIP_SHORT).tgz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} "ftp://ftp.info-zip.org/pub/infozip/src/unzip$(UNZIP_SHORT).tgz"

extract-unzip: fetch-unzip $(TOOLSDIR)/build $(TOOLSDIR)/build/unzip-${UNZIP_VERSION}
$(TOOLSDIR)/build/unzip-${UNZIP_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/unzip$(UNZIP_SHORT).tgz.md5 || exit 1
	@cd $(TOOLSDIR)/build && tar xfz ${DISTFILES}/unzip$(UNZIP_SHORT).tgz
	
configure-unzip: extract-unzip install-zlib
build-unzip: configure-unzip $(TOOLSDIR)/build/unzip-${UNZIP_VERSION}/unzip.exe
$(TOOLSDIR)/build/unzip-${UNZIP_VERSION}/unzip.exe:
	@cd $(TOOLSDIR)/build/unzip-${UNZIP_VERSION} && make -f win32/makefile.gcc

install-unzip: build-unzip $(TOOLSDIR)/unzip.exe
$(TOOLSDIR)/unzip.exe:
	@cd $(TOOLSDIR)/build/unzip-${UNZIP_VERSION} && cp unzip.exe $(TOOLSDIR)

uninstall-unzip:
	@-rm -f $(TOOLSDIR)/unzip.exe

clean-unzip:
	@cd $(TOOLSDIR)/build/unzip-${UNZIP_VERSION} && make -f win32/makefile.gcc clean
	
distclean-unzip:
	@-rm -rf $(TOOLSDIR)/build/unzip-${UNZIP_VERSION}
	
# zip

fetch-zip: ${DISTFILES} ${DISTFILES}/zip$(ZIP_SHORT).tgz
${DISTFILES}/zip$(ZIP_SHORT).tgz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} "ftp://ftp.info-zip.org/pub/infozip/src/zip$(ZIP_SHORT).tgz"

extract-zip: $(TOOLSDIR)/build $(TOOLSDIR)/build/zip-${ZIP_VERSION}
$(TOOLSDIR)/build/zip-${ZIP_VERSION}: fetch-zip 
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/zip$(ZIP_SHORT).tgz.md5 || exit 1
	@cd $(TOOLSDIR)/build && tar xfz ${DISTFILES}/zip$(ZIP_SHORT).tgz
	
configure-zip: extract-zip
build-zip: $(TOOLSDIR)/build/zip-${ZIP_VERSION}/zip.exe
$(TOOLSDIR)/build/zip-${ZIP_VERSION}/zip.exe: configure-zip
	@cd $(TOOLSDIR)/build/zip-${ZIP_VERSION} && make -f win32/makefile.gcc

install-zip: $(TOOLSDIR)/zip.exe
$(TOOLSDIR)/zip.exe: build-zip
	@cd $(TOOLSDIR)/build/zip-${ZIP_VERSION} && cp zip.exe $(TOOLSDIR)

uninstall-zip:
	@-rm -f $(TOOLSDIR)/zip.exe

clean-zip:
	@cd $(TOOLSDIR)/build/zip-${ZIP_VERSION} && make -f win32/makefile.gcc clean
	
distclean-zip:
	@-rm -rf $(TOOLSDIR)/build/zip-${ZIP_VERSION}

