# README.txt
#
# WinTclTk TkWrap README
# Copyright (c) 2007 Martin Matuska
#
# $Id$
#

WinTclTk TkWrap - Tcl/Tk wrapper for Microsoft Windows
Version 0.2

Tcl/Tk scripts can be wrapped into single-file executables
that do not require any Tcl/Tk distributions installed.

Included wrapper files:

tkwrap.exe
xowrap.exe
fullwrap.exe

The following extensions from WinTclTk are included:

tkwrap.exe:

Tcl/Tk	 8.4.14
memchan	2.2.1
mkZiplib 1.0
Tgdbm    0.5
thread	 2.6.5
Winico	 0.5

xowrap.exe: = all tkwrap.exe packages +

tDOM	0.8.1
XOTcl	1.5.3

fullwrap.exe: = all xowrap.exe packages +

Metakit 2.4.9.6
snack   2.2.10
SQLite  3.3.17
Tkhtml  2.0
Tktable 2.9
tls	1.5

For in-file help and command line arguments please execute one of the wrapper files.

You can rename the exe files to any other filename (e.g. "wish.exe")
and use it as a standard shell.

For more information on packages please visit the WinTclTk homepage.
http://wintcltk.berlios.de

TkWrap is based on source code from the freeWrap project. Please see the freeWrap homepage for more information.
http://freewrap.sourceforge.net

Used icons are from the Tulliana 2.0 iconset by M.Umut Pulat, licensed under LGPL 2.1

WinTclTk homepage:
http://wintcltk.berlios.de
