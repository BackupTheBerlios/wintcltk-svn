# WinTclTk make.defs
# Copyright (c) 2006-07 Martin Matuska
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
MEMCHAN_VERSION=	2.2.1
TRF_VERSION=		2.1p2
TCLVFS_VERSION=		1.3
TKCON_VERSION=		2.5
WINICO_VERSION=		0.6
TKTABLE_VERSION=	2.9
TILE_VERSION=		0.7.8
SNACK_VERSION=		2.2.10
SQLITE_VERSION=		3.3.17
TKTREECTRL_VERSION=	2.2.3
TKHTML_VERSION=		2.0
XOSQL_VERSION=		0.61

XOTCL_LIBVER=		$(subst .,,$(XOTCL_VERSION))
XOTCLIDE_FILEVER=	$(XOTCLIDE_VERSION)-0
THREAD_LIBVER=		$(subst .,,$(THREAD_VERSION))
TDOM_LIBVER=		$(subst .,,$(TDOM_VERSION))
TCLVFS_LIBVER=		$(subst .,,$(TCLVFS_VERSION))
TCLVFS_SOURCE=		20070412
SQLITE_LIBVER=		$(subst .,,$(SQLITE_VERSION))
SQLITE_TEA=		$(subst .,_,$(SQLITE_VERSION))
TKCON_SOURCE=		20070414
TKLIB_SHORT=		0.4
SNACK_SHORT=		2.2
PGTCL_DOCVER=		20070115
PGTCL_REL=		1229
PGTCL_DOCREL=		1228
MKZIPLIB_SHORT=		10
TLS_SHORT=		1.5
TLS_LIBVER=		$(subst .,,$(TLS_SHORT))
TRF_LIBVER=		21
TKTREECTRL_LIBVER=	22
TKHTML_LIBVER=		$(subst .,,$(TKHTML_VERSION))
MEMCHAN_LIBVER=		22
ASED_DIR=		ased3.0

GDBM_VERSION=		1.8.3
GDBM_LIVBER=		$(subst .,,$(GDBM_VERSION))
OPENSSL_VERSION=	0.9.8e
OPENSSL_LIBVER=		0.9.8
ZLIB_VERSION=		1.2.3
POSTGRESQL_VERSION=	8.2.4
PTHREADS_VERSION=	2-8-0

ZIP_VERSION=		2.32
ZIP_SHORT=		$(subst .,,$(ZIP_VERSION))
UNZIP_VERSION=		5.52
UNZIP_SHORT=		$(subst .,,$(UNZIP_VERSION))
BZIP2_VERSION=		1.0.4

SOURCEFORGE_MIRROR?=	heanet
GNU_MIRROR?=		ftp.gnu.org/pub/gnu
POSTGRESQL_MIRROR?=	ftp://ftp.us.postgresql.org/pub/mirrors/postgresql/source/v${POSTGRESQL_VERSION}/

TOOLSDIR=	$(SRCDIR)/tools

WGET?=		$(shell which wget)
WGET_FLAGS=	"--passive-ftp"
UNZIP=		$(TOOLSDIR)/unzip.exe
ZIP=		$(TOOLSDIR)/zip.exe
PERL?=		$(shell which perl)
UPX?=		$(shell which upx)

DISTFILES?=	$(SRCDIR)/distfiles
MD5SUMS=	$(SRCDIR)/md5sums
PATCHDIR=	$(SRCDIR)/patches

MESSAGE_WGET=		"You require wget to auto-download the sources. See SOURCES.txt for more information."
MESSAGE_OPENSSL_PERL=	"You require perl to configure OpenSSL. See BUILD-MinGW.txt for more information."
