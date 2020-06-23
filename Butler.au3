; Handle includes
#include <Clipboard.au3>
#include <File.au3>

; Set variables for various things
Global $writeSpeed = 250 ; Anything less causes Ctrl and/or Shift to get "STUCK" on

; Hotkey vars: ^ = Ctrl, ! = Alt, + = Shift
HotKeySet("^+q","Terminate")
HotKeySet("^!v","PasteHere")
HotKeySet("^+{UP}","ScrollUp")

; "Pastes" whatevers in the Clipboard useful for typing into RDP sessions that's wont accept normal paste
Func PasteHere()
  Sleep($writeSpeed)
  $clipContents = ClipGet()
  MouseClick($MOUSE_CLICK_LEFT)
	Send($clipContents)
EndFunc

; Built to scroll back in MS Teams conversations as the search feature doesnt have a "jump to result" feature
Func ScrollUp()
  MouseWheel($MOUSE_WHEEL_UP, 5000)
EndFunc

; Good old fashioned loop
While 1
  Sleep(100)
WEnD

; Exit script
Func Terminate()
  Exit 0
EndFunc