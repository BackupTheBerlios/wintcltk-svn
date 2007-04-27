package require Tk
package require XOTcl
set xotclidedir /lib/xotclIDE
source [file join $xotclidedir ideCore.tcl]
source [file join $xotclidedir ideBgError.tcl]
package require IDEStart
IDEStarter startFromMenu