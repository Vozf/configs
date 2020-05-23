SetTitleMatchMode, 2

winget, winList, list,,, Program Manager

Loop % winList
{
    curUID := winList%a_index%
    wingettitle, curWin, % "ahk_id " curUID
   if InStr(curWin, "VLC", true) {
      ControlSend,,{space},%curWin%
      ;WinActivate, VLC
      break
   }
   else if InStr(curWin, "- YouTube", true) or InStr(curWin, "Кухня", true) {

	ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1,%curWin%
	
	; Focuses on chrome without breaking focus on what you're doing
	ControlFocus,,ahk_id %controlID%
	
	; Checks to make sure YouTube isn't the first tab before starting the loop
	; Saves time when youtube is the tab it's on
	ControlSend, Chrome_RenderWidgetHostHWND1, {space} ,%curWin%
        break
  }
}
