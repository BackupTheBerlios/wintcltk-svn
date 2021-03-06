# freeWrap is Copyright (c) 1998-2005 by Dennis R. LaBelle (labelled@nycap.rr.com)
# All Rights Reserved.
#
# This software is provided 'as-is', without any express or implied warranty. In no
# event will the authors be held liable for any damages arising from the use of 
# this software. 
#
# Permission is granted to anyone to use this software for any purpose, including
# commercial applications, and to alter it and redistribute it freely, subject to
# the following restrictions: 
#
# 1. The origin of this software must not be misrepresented; you must not claim 
#    that you wrote the original software. If you use this software in a product, an 
#    acknowledgment in the product documentation would be appreciated but is not
#    required. 
#
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software. 
#
# 3. This notice may not be removed or altered from any source distribution.
#
#
# This TCL/TK script is used to produce the freeWrap program.
#
# freeWrap allows creation of stand-alone TCL/TK executables without using a
# compiler. Renaming freeWrap to some other file name causes freeWrap to
# behave as a a stand-alone, single-file WISH that can be used to run any 
# TCL/TK script. 
#
# Revision history:
#
# Revison  Date           Author             Description
# -------  -------------  -----------------  ------------------------------------
#     0    Aug. 21, 1998  Dennis R. LaBelle  Original work
#   1.0    Sep. 19, 1998  Dennis R. LaBelle  Public issue
#   2.0    May  23, 1999  Dennis R. LaBelle  Implemented using MKTCLAPP (formerly Embedded TCL).
#   2.1    May  29, 1999  Dennis R. LaBelle  Reissued with substitute CONSOLE command.
#                                            Freewrap did not work on Windows machines without
#                                            TCL/TK installed if the normal WISH console was used.
#   2.2    June  2, 1999  Dennis R. LaBelle  Added a replacement for flush command to handle the STDOUT and STDERR channels
#   2.3    June 22, 1999  Dennis R. LaBelle  Modified to use the normal WISH console under Windows.
#   3.0    July 18, 1999  Dennis R. LaBelle  1) Added ability to wrap multiple scripts.
#                                            2) Added ability to wrap binary image files. (GIF, PPM, PGM)
#                                            3) Added automatic encryption of wrapped files.
#   3.1    Aug. 15, 1999  Dennis R. LaBelle  1) Corrected improper decryption of additional wrapped files
#                                            2) Corrected handling of line continuations (\ character) under Windows
#   3.2    Sept  8, 1999  Dennis R. LaBelle  1) Now uses [info nameofexecutable] instead of argv0
#                                            2) Added _freewrap_patchLevel variable to indicate Freewrap revision number
#                                            3) Added copyright notices
#   3.3    Oct.  4, 1999  Dennis R. LaBelle  1) Reinstated TCL "load" command in support of stubs load interface
#                                            2) Added -f command line option for freewrap
#   4.0    Dec.  5, 1999  Dennis R. LaBelle  1) Added curly brackets around wrapped file names to account for file
#                                               paths that include spaces.
#                                            2) Removed unused _freewrap_puts and _freewrap_flush procedures
#                                            3) Changed format for storing files at end of freewrap. Done to support
#                                               file distribution capabilities.
#                                            4) Binary files are now stored without first converting to a Hex string
#                                            5) Assigned exit function to WM_DELETE_WINDOW event of root window.
#                                            6) Added _freewrap_stubsize variable to indicate size of base Freewrap executable.
#                                            7) Added -p command line option to wrap distribution packages
#                                            8) tcl_interactive now set to 1 if used as stand-alone wish shell.
#   4.1    Mar. 26, 2000  Dennis R. LaBelle  1) Added a -b option for wrapping any type of binary file.
#                                            2) Added _freewrap_getExec procedure
#   4.2    Apr. 23, 2000  Dennis R. LaBelle  1) Replaced use of _freewrap_getExec proc in _freewrap_pkgfilecopy with in-line code.
#   4.3    May  17, 2000  Dennis R. LaBelle  1) Fixed "Main application script not specified" error when "\" was used in script name.
#                                               This problem was introduced by a "helpful" feature of TCL 8.3.0
#   4.4    Oct.  6, 2000  Dennis R. LaBelle  1) Added a -w "wrap using" option to specify the file to use as the freeWrap stub. This
#                                               allows cross-platform creation of wrapped applications.
#                                            2) Created ::freewrap namespace and moved all existing freewrap variables, commands and
#                                               procedures into it.
#                                            3) Added ::freewrap::getSpecialDir and ::freewrap::shortcut commands
#                                            4) Incorporated ms_shell_setup procedures by Earl Johhnson and included into
#                                               ::freewrap namespace
#   5.0    Dec.  31, 2001 Dennis R. LaBelle  1) Changed method of storing files at end of freeWrap. Converted to a ZIP file format.
#   5.3    Aug.  18, 2002 Dennis R. LaBelle  1) Corrected problems produced by interpretation of path name for main file to wrap.
#   5.4    Oct.  26, 2002 Dennis R. LaBelle  1) Output files are now placed in the current directory instead of the main source
#                                               file's directory.
#   5.6    Feb.   3, 2004 Dennis R. LaBelle  1) Added -i option to specify a program icon under Windows.
#                                            2) Modified code to use new ::freewrap::makeZIP command instead of separate ZIP program.
#                                            3) Removed source code encryption feature from freeWrap.
#   6.1    Aug.  27, 2005 Dennis R. LaBelle  1) Added -forcewrap option to force freeWrap to act as a wrapping program even if it has
#                                               been renamed.
#                                            2) Added -debug command line option to open a console while wrapping.
#   6.2    Jan.   2, 2006 Dennis R. LaBelle  1) Added ZIP 2.0 standard file encryption capability. By default, this feature is active.
#                                               This feature can be turned off by using the -e option on the freeWrap command line.
#                                            2) Removed call to freewrap::getStubSize procedure. Results were not used.


proc _freewrap_readfile {name} {
  # Read the named file and return its contents.
  set fd [open $name]
  fconfigure $fd -translation binary
  set data [read $fd]
  close $fd
  return $data
}


proc _freewrap_writefile {name data} {
  # Write the specified data to the named file.
  set fd [open $name w]
  fconfigure $fd -translation binary
  puts -nonewline $fd $data
  close $fd
}


proc _freewrap_decICO {dat} {
  # Decode Windows .ICO file contents into the individual bit maps
  set result {}
  binary scan $dat sss - type count
  for {set pos 6} {[incr count -1] >= 0} {incr pos 16} {
    binary scan $dat @${pos}ccccssii w h cc - p bc bir io
    if {$cc == 0} { set cc 256 }
    binary scan $dat @${io}a$bir image
    lappend result ${w}x${h}/$cc $image
  }
  return $result
}


proc _freewrap_iconReplace {filename newicon} {
     # For MS Windows application files, replace the program icon.
     set rtnval {}

     if {[file normalize $filename] == [info nameofexec]} {
	 return "file in use, cannot be prefix: [file normalize $filename]"
	}
     set out $filename
     if {[catch {zvfs::mount $filename /iconrep} result]} {
	  return $result
	}
     # we only look for an icon if the runtime is called *.exe (!)
     set fwname [file rootname $::freewrap::progname].ico
     catch { set origicon [_freewrap_readfile /iconrep/$fwname] }

     ::zvfs::unmount $filename

     if {[info exists origicon] && [file exists $newicon]} {
	  set header [_freewrap_readfile $filename]
	  set custicon [_freewrap_readfile $newicon]
	  array set newimg [_freewrap_decICO $custicon]
	  set kvlist [_freewrap_decICO $origicon]
	  foreach {k v} $kvlist {
		  if {[info exists newimg($k)]} {
		      set len [string length $v]
		      set pos [string first $v $header]
		      if {$pos < 0} {
			  lappend rtnval "icon $k: NOT FOUND"
			 } elseif {[string length $newimg($k)] != $len} {
				   lappend rtnval "icon $k: NOT SAME SIZE"
 				  } {
				     binary scan $header a${pos}a${len}a* prefix - suffix
				     set header "$prefix$newimg($k)$suffix"
				     lappend rtnval "icon $k: replaced"
				    }
		     }
		}
	  _freewrap_writefile $out $header
	  }
     return $rtnval
}


proc _freewrap_normalize {filename} {
# Return absolute path with . and .. resolved
global tcl_platform

set curDir [pwd]
if {$tcl_platform(platform) == "windows"} {
    set curDir [string range $curDir 2 end]
   }
set fullpath [file join $curDir $filename]
set newpath {}
foreach item [file split $fullpath] {
	  switch -- $item  {
		.	{ }
		..	{
			 set slen [llength $newpath]
			 incr slen -2
			 set newpath [lrange $newpath 0 $slen]
			}
		default	{ lappend newpath $item }
	         }
           }
eval "set rtnval \[file join $newpath\]"
return $rtnval
}


proc _freewrap_getExec {} {
# Returns the name of the executable file, taking into account any symbolic links
set fname [info nameofexecutable]
if {[file type $fname] == "link"} {
	set fname [file readlink $fname]
   }
return $fname
}


proc _freewrap_message {parent icon type title message} {
global tk_patchLevel

if {[info exists tk_patchLevel]} {
    tk_messageBox -parent $parent -icon $icon -type $type -title $title -message $message
   } { puts "$title: $message" }
}


proc _freewrap_wrapit {cmdline {DelList {}}} {
# Create a single file executable out of the specified scripts and image files.
# This is done by appending the specified files to the end of a copy of the freewrap program.
# 
# cmdline = freeWrap style command line
# DelList = list of files to remove from the current application archive section
#
global argv0
global tcl_platform
global env

# List of extensions recognized as belonging to binary files.
# Binary files must be handled differently (i.e. converted to hexadecimal string notation).
#
set ScriptExts {.tcl .tk .tsh}

# Process command line arguments
set argctr 0
set argstr ""
set nextAction default
set stubfile {}
set execname {}
set ICOfile {}
set encrypt 1
foreach arg $cmdline {
	  switch -- $arg {
		   {}		{
				 # Empty argument. Do nothing
				}
		   {-debug}	{
				 # Open console window so user can see debug messages
				 wm iconify .
				 console show
				 update
				}
		   {-e}	{
				 # turn off default encryption
				 set encrypt 0
				}
               {-i}	{
				 # Next argument is the name of an ICO file that should be used to replace the
                         # program icon under Windows.
                         set nextAction getICOfile
				}
		   {-f}	{
				 # Next argument is the name of a file containing a list of files, one per line
				 set nextAction LookInFile
				}
		   {-forcewrap} {}
		   {-o}	{
				 # Set output file name
				 set nextAction getExecName
				}
		   {-w}	{
				 # Next argument is the name of the file to use as the freeWrap stub.
				 # This option allows cross-platform construction of freeWrapped programs.
				 set nextAction getStubFile
				}
		   default	{
				 switch $nextAction {
					getICOfile	{
							 if {$tcl_platform(platform) == {windows}} { regsub -all {\\} $arg {/} ICOfile }
                                           set nextAction default
							}
					LookInFile	{
                                           set nextAction default
		                               if {![catch {open $arg} fin]} {
		                                   while {![eof $fin]} {
		                                          gets $fin line
		                                          set line [string trim $line]
		                                          if {$line != ""} {
		                                              if {[lsearch $ScriptExts [string tolower [file extension $line]]] != -1} {
		                                                  lappend argstr s$line
		                                                 } { lappend argstr b$line }
		                                              incr argctr
		                                             }
		                                         }
		                                   close $fin
                                              } {
                                                  catch {wm withdraw .}
                                                  _freewrap_message {.} warning ok {freeWrap error!} "Could not find list file: $arg.\n\nWrapping aborted."
                                                  return 10
                                                }
							}
					getStubFile	{
	                                     regsub -all {\\} $arg {/} stubfile
	                                     set nextAction default
	                                    }
					getExecName	{
	                                     regsub -all {\\} $arg {/} execname
	                                     set nextAction default
							}
					default	{
					   regsub -all {\\} $arg {/} arg2
                                           if {[lsearch $ScriptExts [string tolower [file extension $arg2]]] != -1} {
                                                lappend argstr s$arg2
                                               } { lappend argstr b$arg2 }
                                           incr argctr
                                          }
                            	}
				}
             }
      }
if {$argctr > 0} {
    set stub [_freewrap_getExec]
    set OSext [string tolower [file extension $stub]]
    if {$stubfile != {}} { set stub $stubfile }
    set DESText [string tolower [file extension $stub]]
    if {[string index [lindex $argstr 0] 0] != "s"} {
	  catch {wm withdraw .}
	  _freewrap_message {.} warning ok {freeWrap error!} {No main application script specified.}
	  return 1
	 }
    set filename [string range [lindex $argstr 0] 1 end]
    if {[file exists $filename]} {
	  set fname [file root [file tail $filename]]
	  if {[string length $execname] == 0} {
	      set execname ${fname}$DESText
	     }
	  set zipname  [file join ${fname}.zip]
	 } {
	    catch {wm withdraw .}
	    _freewrap_message {.} warning ok {freeWrap error!} "Could not find $filename to wrap."
	    return 6
	   }

    # Copy freeWrap program itself to produce initial output file.
    file copy -force $stub $zipname

    # Ensure the new file is writeable.
    if {$tcl_platform(platform) == {unix}} {
	file attributes $zipname -permissions 0700
       } {
		if {[file attributes $zipname -readonly] == 1} {
		    file attributes $zipname -readonly 0
		   }
	   }

    if {$ICOfile != {}} {
        # Replace wrapped application's program icon with user specified icon.
	  _freewrap_iconReplace $zipname $ICOfile
       }

    if {[file exists $zipname]} {
	  # remove the specified files from the archive
	  if { [info exists $DelList] } {
  	  	set cmd "::freewrap::makeZIP \"$zipname\" -Ad $DelList"
	  	catch $cmd result
  	  }

	  set totSize 0
	  set cmd {::freewrap::makeZIP -A9q}
	  if {$encrypt} { append cmd e }
	  append cmd " \"$zipname\""
	  set mainfile {}
	  set mainfile_org {}
	  set namelist {}
	  set orgPath {}
	  set encPath {}
	  while {$argctr > 0} {
			set pos [expr $argctr - 1]
			set filename [lindex $argstr $pos]

			# Add file to ZIP command line
			set filetype [string index $filename 0]
			set srcname [_freewrap_normalize [string range $filename 1 end]]
			if {[file exists $srcname]} {
			    if {$argctr == 1} {
				  # We are processing the main script
				  set mainfile $srcname
				 }
			    if {($filetype == {b}) && [::freewrap::isSameRev $srcname]} {
				  # process previously freeWrapped file
				  #
				  # Remove freeWrap stub from file
				  set pkgname [file join [file dirname $srcname] fwpkg_[file rootname [file tail $srcname]].zip]
				  file copy -force $srcname $pkgname
				  set cmdstr "::freewrap::makeZIP -jJA \"$pkgname\""
				  catch {eval $cmdstr} result
				  set srcname $pkgname
				 }
			   } {
				catch {wm withdraw .}
			 	_freewrap_message {.} warning ok {freeWrap error!} "Could not find $srcname to wrap."
			      return 4
			     }

			append namelist " \"$srcname\""

			incr argctr -1
		  }

	  # create configuration file to be used at run-time by wrapped application.
	  set configFile {_freewrap_init.txt}
	  if {[file exists _freewrap_init.txt]} {
		catch {wm withdraw .}
	 	_freewrap_message {.} warning ok {freeWrap error!} "Error creating $configFile.\n\nFile already exists."
		return 7
	     }
	  if {[catch {open $configFile w} fout]} {
		catch {wm withdraw .}
	 	_freewrap_message {.} warning ok {freeWrap error!} "Error creating $configFile.\n\n$fout."
		return 8
	     }
	  puts $fout [::freewrap::normalizePath $mainfile]
	  puts $fout "$::freewrap::progname $::freewrap::patchLevel"
	  close $fout
	  append namelist " \"$configFile\""

	  # Add all the files to the archive
	  while {[llength $namelist] > 0} {
		 set addcmd "$cmd [lrange $namelist 0 49]"
		 set namelist [lrange $namelist 50 end]
		 catch $addcmd result
		}

	  # Do some cleanup
	  foreach src $orgPath dest $encPath {
		    file rename -force $src $dest
		  }
	  file delete _freewrap_init.txt

	  # change output file to its final executable name
	  if {[catch {file delete -force $execname} result]} {
		catch {wm withdraw .}
		_freewrap_message {.} warning ok {freeWrap error!} "Unable to overwrite existing copy of $execname.\n\n$execname may be currently running."
		return 11
	     } {
		  file rename -force $zipname $execname
		 }
	 }
   } {
	catch {wm withdraw .}
	_freewrap_message {.} warning ok {freeWrap error!} {No main application script specified.}
	return 3
     }
return 0
}


proc _freewrap_main {} {
global argv0
global argv
global argc
global tcl_platform
global tcl_interactive
global tk_patchLevel

catch {console hide}
catch {wm protocol . WM_DELETE_WINDOW { exit 0}}
set _freewrap_progsrc ""

if {[string first -forcewrap $argv] != -1} {
    set wrapit 1
   } elseif {"[string tolower [file tail [_freewrap_getExec]]]" == [string tolower $::freewrap::progname]} {
             set wrapit 1
            } { set wrapit 0 }
if {$wrapit} {
    # wrap an application
    exit [_freewrap_wrapit $argv]
   } {
	 # Run as a stand-alone TCLSH/WISH or as a wrapped application.
	 set _freewrap_argv0 [file tail [_freewrap_getExec]]

       regsub -all {\\} [lindex $argv 0] {/} argv0
       set argv [lrange $argv 1 end]
       incr argc -1
	 set argv1 $argv0

	 # Remove unneeded procedures and variables
	 rename _freewrap_wrapit {}
	 rename _freewrap_getExec {}
	 rename _freewrap_normalize {}
	 rename _freewrap_readfile {}
	 rename _freewrap_writefile {}
	 rename _freewrap_decICO {}
	 rename _freewrap_iconReplace {}

       if {![catch {open $argv1 r} _freewrap_filein]} {
           # Read in the program source code
             set _freewrap_progsrc [read $_freewrap_filein]
             close $_freewrap_filein
		 info script $argv1
	     unset _freewrap_filein
	     unset argv1

           # Run the program
             rename _freewrap_message {}
             uplevel 1 [list if 1 $_freewrap_progsrc]
	     if {![info exists tk_patchLevel]} { exit 0 }
          } {
             if {$argv1 == {}} {
                 set tcl_interactive 1
		     if {[info command console] != {}} {
			   rename _freewrap_message {}
                     catch {console show}
                    }
		    } {
                   set msg "Unable to open\n$argv1"
                   catch {wm withdraw .}
                   _freewrap_message {.} warning ok $_freewrap_argv0 $msg
                   exit 5
                  }
		}
     }
}

