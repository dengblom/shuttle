--for testing uncomment the "on run" block
--on run
--	set argsCmd to "ps aux | grep [s]creen"
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
		activate
		delay 0.15

		if (not running) or ((count of windows) is 0) then
			reopen
			delay 0.25
			set newTab to do script withCmd in window 1
			my applyThemeAndTitle(newTab, withTheme, theTitle)
			return
		end if

		set tabsBefore to count of tabs of front window
		set uiWorked to my pressCommandT()
		delay 0.45

		set tabCreated to false
		try
			set tabCreated to (uiWorked and ((count of tabs of front window) > tabsBefore))
		end try

		if tabCreated then
			-- Command must be typed into the new tab. Do not call `do script` here:
			-- bare or targeted `do script` opens an extra window on modern Terminal
			-- after Cmd+T has already created a tab.
			try
				set selected of tab (count of tabs of front window) of front window to true
			end try
			delay 0.1
			set newTab to selected tab of front window
			my typeCommandInFrontTerminal(withCmd)
			my applyThemeAndTitle(newTab, withTheme, theTitle)
		else
			-- Accessibility missing or Cmd+T failed → new window session
			set newTab to do script withCmd
			my applyThemeAndTitle(newTab, withTheme, theTitle)
		end if
	end tell
end CommandRun

on applyThemeAndTitle(newTab, withTheme, theTitle)
	tell application "Terminal"
		try
			set current settings of newTab to settings set withTheme
		on error
			try
				set current settings of newTab to settings set "Basic"
			end try
		end try
		try
			set title displays custom title of front window to true
			set custom title of newTab to theTitle
		end try
	end tell
end applyThemeAndTitle

on pressCommandT()
	try
		tell application "System Events"
			tell process "Terminal"
				set frontmost to true
				delay 0.05
				keystroke "t" using {command down}
			end tell
		end tell
		return true
	end try
	return false
end pressCommandT

on typeCommandInFrontTerminal(withCmd)
	-- Type the command string (not clipboard paste) so we don't fight menu focus
	-- or paste targets. Requires Accessibility for Shuttle.app.
	tell application "System Events"
		tell process "Terminal"
			set frontmost to true
			delay 0.1
			keystroke withCmd
			delay 0.05
			keystroke return
		end tell
	end tell
end typeCommandInFrontTerminal
