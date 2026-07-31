--for testing uncomment the "on run" block
--on run
--	set argsCmd to "ps aux | grep [s]sh"
--	set argsTheme to "Basic"
--	set argsTitle to "Custom title"
--	scriptRun(argsCmd, argsTheme, argsTitle)
--end run

on scriptRun(argsCmd, argsTheme, argsTitle)
	set withCmd to (argsCmd)
	set withTheme to (argsTheme)
	set theTitle to (argsTitle)
	CommandRun(withCmd, withTheme, theTitle)
end scriptRun

on CommandRun(withCmd, withTheme, theTitle)
	tell application "Terminal"
		if it is not running then
			set newTerm to do script withCmd in window 1
		else
			set newTerm to do script withCmd
		end if
		activate
		try
			set newTerm's current settings to settings set withTheme
		on error
			try
				set newTerm's current settings to settings set "Basic"
			end try
		end try
		try
			set custom title of front window to theTitle
		end try
	end tell
end CommandRun
