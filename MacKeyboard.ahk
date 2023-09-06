#SingleInstance Force

SendMode Input

CloseWindow() {
  WinGet ProcessName, ProcessName, A
  If ProcessName in QQ.exe,TIM.exe,WeChat.exe,WINWORD.EXE,EXCEL.EXE,POWERPNT.EXE
    Send !{F4}
  Else If ProcessName in bash.exe,pwsh.exe,powershell.exe,cmd.exe,wsl.exe
    WinClose A
  Else
    Send ^w
}

ConfirmToSignOut() {
  MsgBox 0x40034, Confirm, Are you sure you want to quit all applications and log out now?`n`nIf you do nothing`, you will be logged out automatically in 60 seconds., 60
  IfMsgBox Yes
    DllCall("ExitWindowsEx")
  IfMsgBox Timeout
    DllCall("ExitWindowsEx")
}

MinimizeApp() {
  WinGet ProcessPath, ProcessPath, A
  WinGet List, List, ahk_exe %ProcessPath%
  Loop % List
    WinMinimize % "ahk_id " List%A_Index%
}

NextWindow() {
  WinGet ProcessPath, ProcessPath, A
  WinActivateBottom ahk_exe %ProcessPath%
}

IsFullScreen() {   
  WinGet style, Style, A
  WinGetPos ,,,winW,winH, A
  Return ((style & 0x20800000) or winH < A_ScreenHeight or winW < A_ScreenWidth) ? false : true
}

Captura() {
  WinGetPos X, Y,,, A
  ; It seems like the size includes the shadow or something else
  ; It has to expand with 20, 10 to match the actual size
  WinMove A,, X, Y, 1940, 1090
  Run "C:\Program Files (x86)\Captura\Captura.exe"
}

LockAndTurnOffScreen() {
  DllCall("LockWorkStation")
  Sleep 3000
  SendMessage 0x112, 0xF170, 2, , Program Manager
}

; Common
!#Esc::Send ^+{Esc}             ; Task Manager
#`::NextWindow()                ; Next Window
F11::Send #d                    ; Show Desktop
#w::CloseWindow()               ; Close Window
#q::Send !{F4}                  ; Quit
^#q::LockAndTurnOffScreen()     ; Lock Screen
+#q::ConfirmToSignOut()         ; Sign Out
+!#q::DllCall("ExitWindowsEx")  ; Sign Out without Confirm
#r::Send ^r                     ; Refresh / Run / Replace
#+r::Send ^+r                   ; Force Refresh
#h::WinMinimize A               ; Minimize
!#h::Send #{Home}               ; Minimize All But This
#c::Send ^{Insert}              ; Copy
#v::Send +{Insert}              ; Paste
#m::WinMinimize A               ; Minimize
!#m::MinimizeApp()              ; Minimize App
^Left::Send ^#{Left}            ; Previous Desktop
^Right::Send ^#{Right}          ; Next Desktop
^#Space::Send #.                ; Character Viewer
!BackSpace::Send ^{BackSpace}   ; Delete Word
#BackSpace::Send {Delete}       ; Delete

; Finder / Explorer
#i::Send !{Enter}               ; Info / Properties

; Instant Messaging (QQ, WeChat, etc.)
^#a::Send ^!a                   ; Take Snapshot
^#z::Send ^!z                   ; Wake Up QQ
^#w::Send ^!w                   ; Wake Up Wechat
#Enter::Send ^{Enter}           ; Send Message / Break Line

; Individual
+#v::Send ^+{Insert}            ; Ditto Clipboard
^#r::Captura()                  ; Captura Record Screen
^#f::Send ^!f                   ; Wake Up Foxmail

; TODO: Use a pattern to remap all of these
#t::Send ^t                     ; New Tab
+#t::Send ^+t                   ; Reopen Closed Tab
#y::Send ^h                     ; Hitory
#o::Send ^o                     ; Open
#p::Send ^p                     ; Print
#a::Send ^a                     ; Select All
#s::Send ^s                     ; Save
#+s::Send ^+s                   ; Save As / Save All
#d::Send ^d                     ; Add to Favorites
#f::Send ^f                     ; Find...
#+f::Send ^+f                   ; Find in Files
!#f::Send ^h                    ; Find and Replace...
#g::Send ^g                     ; Go to / Find Next
#z::Send ^z                     ; Undo
+#z::Send ^y                    ; Redo
#x::Send ^x                     ; Cut
#n::Send ^n                     ; New File / New Window
+#n::Send ^+n                   ; New Window / New InPrivate Window
#/::Send ^/                     ; Comment / Uncomment

; Minimize Remote Desktop
#If IsFullScreen()
  ^Capslock::WinMinimize A
#If
