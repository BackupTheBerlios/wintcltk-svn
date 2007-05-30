# WinTclTk src Makefile 
# Copyright (c) 2006 Martin Matuska
#
# $Id$
#
CURDIR=	$(shell pwd)
SRCDIR=	$(CURDIR)
MDIR?=	defs

include $(MDIR)/defs.mak
include $(MDIR)/tools.mak

ifndef STATIC_BUILD
BUILDDIR?=	$(CURDIR)/build
PREFIX?=	$(CURDIR)/instroot
include $(MDIR)/shared.mak
else
BUILDDIR?=	$(CURDIR)/build_s
PREFIX?=	$(CURDIR)/instroot_s
include $(MDIR)/static.mak
endif

COMMONBUILD?=	$(CURDIR)/build_c
include $(MDIR)/common.mak