#!/bin/sh
#
# WinTclTk make.defs
# Copyright (c) 2006 Martin Matuska
#
# $Id: Makefile 90 2007-04-06 11:58:32Z mmatuska $
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


MESSAGE_WGET=		"You require wget to auto-download the sources. See SOURCES.txt for more information."
MESSAGE_UNZIP=		"You require unzip to extract this source. See SOURCES.txt for more information."
MESSAGE_OPENSSL_PERL=	"You require perl to configure OpenSSL. See BUILD-MinGW.txt for more information."
