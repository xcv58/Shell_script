on clickCheckbox(paneId, checkboxName)
  tell application "System Preferences"
    repeat until the current pane is not missing value and the current pane's id is paneId
      set the current pane to pane id paneId
    end repeat
  end tell
  tell application "System Events"
    tell process "System Preferences"
      repeat
        try
          click the checkbox checkboxName of window 1
          return
        end try
      end repeat
    end tell
  end tell
  tell application "System Preferences" to quit
end clickCheckbox

on run argv
  if the length of argv is not 2
    log "You must provide 'pane id' and checkbox name, like:"
    log "clickCheckboxInSystemPreferences com.apple.preference.general \"Automatically hide and show the menu bar\""
    log "clickCheckboxInSystemPreferences com.apple.preference.dock \"Automatically hide and show the Dock\""
    return
  end if
  set paneId to item 1 of argv
  set checkboxName to item 2 of argv
  clickCheckbox(paneId, checkboxName)
end run
