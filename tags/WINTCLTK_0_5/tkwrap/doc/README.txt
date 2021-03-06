# README.txt
#
# WinTclTk TkWrap README
# Copyright (c) 2007 Martin Matuska
#
# $Id$
#

WinTclTk TkWrap - Tcl/Tk wrapper for Microsoft Windows
Version 0.2

With these files, Tcl/Tk scripts can be wrapped into single-file executables
that do not require any Tcl/Tk distributions installed.

Included wrapper files:

tkwrap.exe
xowrap.exe
fullwrap.exe

The following extensions from WinTclTk are included:

tkwrap.exe:

Tcl/Tk	8.4.14
Winico	0.5
thread	2.6.5

xowrap.exe: = all tkwrap.exe packages +

Tgdbm	0.5
XOTcl	1.5.3

fullwrap.exe: = all xowrap.exe packages +

tls	1.5
tDOM	0.8.1
memchan	2.2.1
Metakit 2.4.9.6

You can rename the exe files to any other filename (e.g. "wish.exe")
and use it as a standard shell.

Please refer to WinTclTk Project documentation for more information.
http://wintcltk.berlios.de

The wrappers are based on freeWrap and support all freeWrap command-line flags.
Please refer to the freeWrap documentation for more details:
http://freewrap.sourceforge.net/freeWrapDocs.pdf

Used icons are from the Tulliana 2.0 iconset by M.Umut Pulat, licensed under LGPL 2.1

WinTclTk homepage:
http://wintcltk.berlios.de
