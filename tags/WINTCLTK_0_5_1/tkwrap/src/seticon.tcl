# This TCL script is used by the freeWrap Makefile
#
# Purpose:
#     1) On Windows, replace the standard WISH/TK program icon with our own freeWrap icon.
#
catch {console show}

set mountpt {}

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
     global mountpt

     # For MS Windows application files, replace the program icon.
     set rtnval {}

     if {[file normalize $filename] == [info nameofexec]} {
	 return "file in use, cannot be prefix: [file normalize $filename]"
	}
     set out $filename
     if {[catch {zvfs::mount $filename $mountpt/iconrep} result]} {
	  return $result
	}
     # we only look for an icon if the runtime is called *.exe (!)
     set iconpath $mountpt/iconrep/[file rootname $::freewrap::progname].ico
     catch { set origicon [_freewrap_readfile $iconpath] }

     ::zvfs::unmount $filename

     if {[info exists origicon] && [file exists $newicon]} {
	  set header [_freewrap_readfile $filename]
	  set custicon [_freewrap_readfile $newicon]
	  array set newimg [_freewrap_decICO $custicon]
	  foreach {k v} [_freewrap_decICO $origicon] {
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
	} { set rtnval "Could not read $iconpath" }
     return $rtnval
}


proc main {} {
global argv
global tcl_platform

if {$argv != {}} {
    set filename $argv
    if {$tcl_platform(platform) == {windows}} {
        # Replace the standard WISH/TK program icon with our own freeWrap icon.
        _freewrap_iconReplace $filename freewrap.ico
        set ICOname [file rootname $::freewrap::progname].ico
	  if {$ICOname != {freewrap.ico}} { file copy -force freewrap.ico $ICOname }
        exec zip -A $filename $ICOname
       }
   }
}

main

exit

