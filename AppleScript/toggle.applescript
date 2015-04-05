global foundCount
global hideCount
global frontmostCount

on toggle(appPath)
	if application appPath is running then
		set foundCount to foundCount + 1
		if frontmost of application appPath then
			if hideCount > 0 then return
			set hideCount to hideCount + 1
		else
			set frontmostCount to frontmostCount + 1
			tell application appPath to activate
			tell application appPath
				try
					if windows is {} then reopen
				on error errorMessage number errorNumber
					-- log errorMessage
					-- log errorNumber
				end try
			end tell
		end if
	end if
end toggle

on run argv
	set hideCount to 0
	set foundCount to 0
	set frontmostCount to 0
	repeat with arg in argv
		toggle(arg)
		if frontmostCount > 0 then exit repeat
	end repeat
	if frontmostCount is 0 and foundCount > 0 then
		tell application "System Events"
			set frontProcess to first process whose frontmost is true
			set visible of frontProcess to false
		end tell
	end if
	if foundCount is 0 then tell application (item 1 of argv) to activate
	return 0
end run