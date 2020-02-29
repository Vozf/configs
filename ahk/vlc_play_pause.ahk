SetTitleMatchMode, 2


if WinExist("VLC") {
  ControlSend,,{space}, VLC
}
else {

	ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, YouTube
	
	; Focuses on chrome without breaking focus on what you're doing
	ControlFocus,,ahk_id %controlID%
	
	; Checks to make sure YouTube isn't the first tab before starting the loop
	; Saves time when youtube is the tab it's on
	ControlSend, Chrome_RenderWidgetHostHWND1, {space} , YouTube
}
