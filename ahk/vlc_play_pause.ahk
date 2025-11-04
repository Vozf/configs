SetTitleMatchMode, 2

; WM_APPCOMMAND message
APPCOMMAND_PLAY_PAUSE := (14 << 16) ; Media Play/Pause command code
WM_APPCOMMAND := 0x319

winget, winList, list,,, Program Manager

Loop % winList
{
    curUID := winList%a_index%
    wingettitle, curWin, % "ahk_id " curUID

    ; --- Priority 1: VLC (Unchanged) ---
    if InStr(curWin, "VLC", true) {
        ControlSend,,{space},%curWin%
        break
    }
    
    ; --- Priority 2: Browser Tabs ---
    else if (InStr(curWin, "- YouTube", true) and not InStr(curWin, "Subscriptions - YouTube", true))
        or InStr(curWin, "Кухня", true) 
        or InStr(curWin, "- Google Drive", true)
        or InStr(curWin, "Pluralsight", true)
        or InStr(curWin, "Skills Boost", true)
        or InStr(curWin, "TUM-Live", true)
    {
        WinGet, curProcess, ProcessName, % "ahk_id " curUID

        ; --- Chrome/Edge logic (Unchanged) ---
        if (curProcess = "chrome.exe" or curProcess = "msedge.exe")
        {
            ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1,%curWin%
            ControlFocus,,ahk_id %controlID%
            ControlSend, Chrome_RenderWidgetHostHWND1, {space} ,%curWin%
            break
        }
        
        ; --- MODIFIED: Firefox logic ---
        else if (curProcess = "firefox.exe")
        {
            ; This sends the raw Windows message for "Play/Pause"
            ; It is a different method than ControlSend and more robust
            PostMessage, %WM_APPCOMMAND%,, %APPCOMMAND_PLAY_PAUSE%,, % "ahk_id " curUID
            break
        }
    }
}