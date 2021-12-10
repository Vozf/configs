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

 CapsLock::Send, {Ctrl Down}{Shift Down}{Shift Up}{Ctrl Up}
 AppsKey::Run, "c:\Program Files\AutoHotKey\scripts\vlc_play_pause.ahk"
 Alt & F11::Run, "c:\Program Files\AutoHotKey\scripts\key.ahk"
