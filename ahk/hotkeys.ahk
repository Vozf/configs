#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

 ~XButton2 & WheelUp::
      Send, {Volume_Up}
 Return

 ~XButton2 & WheelDown::
      Send, {Volume_Down}
 Return

 ~XButton2 & MButton::
      Send, {Volume_Mute}
 Return

; prevent double click on middle button
XButton2::	
	If (A_PriorHotkey=A_ThisHotkey && A_TimeSincePriorHotkey < 150)
		return
	Send {%A_ThisHotkey% down}
	KeyWait %A_ThisHotkey%
	Send {%A_ThisHotkey% up}
Return
; prevent double click on side Button 1 button
XButton1::	
	If (A_PriorHotkey=A_ThisHotkey && A_TimeSincePriorHotkey < 150)
		return
	Send {%A_ThisHotkey% down}
	KeyWait %A_ThisHotkey%
	Send {%A_ThisHotkey% up}
Return
; prevent double click on side button 2button
MButton::	
	If (A_PriorHotkey=A_ThisHotkey && A_TimeSincePriorHotkey < 150)
		return
	Send {%A_ThisHotkey% down}
	KeyWait %A_ThisHotkey%
	Send {%A_ThisHotkey% up}
Return
 CapsLock::Send, {Ctrl Down}{Shift Down}{Shift Up}{Ctrl Up}
 AppsKey::Run, "c:\Program Files\AutoHotKey\scripts\vlc_play_pause.ahk"
 Alt & F11::Run, "c:\Program Files\AutoHotKey\scripts\key.ahk"
