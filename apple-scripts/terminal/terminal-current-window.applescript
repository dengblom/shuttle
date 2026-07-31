--for testing uncomment the "on run" block
--on run
--	set argsCmd to "ps aux | grep [s]sh"
--	scriptRun(argsCmd)
--end run

on scriptRun(argsCmd)
	set withCmd to (argsCmd)
	CommandRun(withCmd)
end scriptRun

on CommandRun(withCmd)
	tell application "Terminal"
		reopen
		activate
		if (count of windows) is 0 then
			do script withCmd
		else
			do script withCmd in front window
		end if
	end tell
end CommandRun
