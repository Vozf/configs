#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

 WheelUp::
      if( GetKeyState("XButton2") ) {
           Send, {Volume_Up}
      }
      else {
           Send, {WheelUp}
      }
 Return

 WheelDown::
      if( GetKeyState("XButton2") ) {
           Send, {Volume_Down}
      }
      else {
           Send, {WheelDown}
      }
 Return

 MButton::
      if( GetKeyState("XButton2") ) {
           Send, {Volume_Mute}
      }
      else {
           Send, {MButton}
      }
 Return

 CapsLock::Send, {Ctrl Down}{Shift Down}{Shift Up}{Ctrl Up}
