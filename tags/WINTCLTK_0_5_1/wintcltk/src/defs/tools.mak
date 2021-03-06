# WinTclTk tools.mak
# Copyright (c) 2006-07 Martin Matuska
#
# $Id$
#
# unzip
TOOLBUILD?=	$(TOOLSDIR)/build

$(TOOLBUILD):
	@mkdir -p $(TOOLBUILD)
	
fetch-unzip: ${DISTFILES} ${DISTFILES}/unzip$(UNZIP_SHORT).tgz
${DISTFILES}/unzip$(UNZIP_SHORT).tgz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} $(WGET_FLAGS) "ftp://ftp.info-zip.org/pub/infozip/src/unzip$(UNZIP_SHORT).tgz"

extract-unzip: fetch-unzip $(TOOLBUILD) $(TOOLBUILD)/unzip-${UNZIP_VERSION}
$(TOOLBUILD)/unzip-${UNZIP_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/unzip$(UNZIP_SHORT).tgz.md5 || exit 1
	@cd $(TOOLBUILD) && tar xfz ${DISTFILES}/unzip$(UNZIP_SHORT).tgz
	
configure-unzip: extract-unzip install-zlib
build-unzip: configure-unzip $(TOOLBUILD)/unzip-${UNZIP_VERSION}/unzip.exe
$(TOOLBUILD)/unzip-${UNZIP_VERSION}/unzip.exe:
	@cd $(TOOLBUILD)/unzip-${UNZIP_VERSION} && make -f win32/makefile.gcc

install-unzip: build-unzip $(TOOLSDIR)/unzip.exe
$(TOOLSDIR)/unzip.exe:
	@cd $(TOOLBUILD)/unzip-${UNZIP_VERSION} && cp unzip.exe $(TOOLSDIR)

uninstall-unzip:
	@-rm -f $(TOOLSDIR)/unzip.exe

clean-unzip:
	@cd $(TOOLBUILD)/unzip-${UNZIP_VERSION} && make -f win32/makefile.gcc clean
	
distclean-unzip:
	@-rm -rf $(TOOLBUILD)/unzip-${UNZIP_VERSION}
	
# zip

fetch-zip: ${DISTFILES} ${DISTFILES}/zip$(ZIP_SHORT).tgz
${DISTFILES}/zip$(ZIP_SHORT).tgz:
	@[ -x "${WGET}" ] || ( echo "$(MESSAGE_WGET)"; exit 1 )
	@cd ${DISTFILES} && ${WGET} $(WGET_FLAGS) "ftp://ftp.info-zip.org/pub/infozip/src/zip$(ZIP_SHORT).tgz"

extract-zip: fetch-zip $(TOOLBUILD) $(TOOLBUILD)/zip-${ZIP_VERSION}
$(TOOLBUILD)/zip-${ZIP_VERSION}:
	@cd ${DISTFILES} && md5sum -c ${MD5SUMS}/zip$(ZIP_SHORT).tgz.md5 || exit 1
	@cd $(TOOLBUILD) && tar xfz ${DISTFILES}/zip$(ZIP_SHORT).tgz
	
configure-zip: extract-zip
build-zip:  configure-zip $(TOOLBUILD)/zip-${ZIP_VERSION}/zip.exe
$(TOOLBUILD)/zip-${ZIP_VERSION}/zip.exe:
	@cd $(TOOLBUILD)/zip-${ZIP_VERSION} && make -f win32/makefile.gcc

install-zip: build-zip $(TOOLSDIR)/zip.exe
$(TOOLSDIR)/zip.exe:
	@cd $(TOOLBUILD)/zip-${ZIP_VERSION} && cp zip.exe $(TOOLSDIR)

uninstall-zip:
	@-rm -f $(TOOLSDIR)/zip.exe

clean-zip:
	@cd $(TOOLBUILD)/zip-${ZIP_VERSION} && make -f win32/makefile.gcc clean
	
distclean-zip:
	@-rm -rf $(TOOLBUILD)/zip-${ZIP_VERSION}