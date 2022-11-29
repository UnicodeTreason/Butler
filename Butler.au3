; Handle includes
#include <Clipboard.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

; Set variables for various things
Global $actionSpeed = 500 ; Anything less than 250 causes Ctrl and/or Shift to get "STUCK" on

; Hotkey vars: ^ = Ctrl, ! = Alt, + = Shift
HotKeySet("^+q","Terminate")
HotKeySet("^!v","PasteHere")
HotKeySet("^!+?","Help")

Func Percent($number, $percent)
    Return Int(($number / $percent) * 100)
EndFunc

Func Help()
    Sleep($actionSpeed)
    MsgBox($MB_SYSTEMMODAL, "Help", "This message box should contain help, but alas it does not.")
EndFunc

; "Pastes" whatevers in the Clipboard useful for typing into RDP sessions that's wont accept normal paste
Func PasteHere()
    Sleep($actionSpeed)
    $ClipContents = ClipGet()
    $ClipboardLength = StringLen($ClipContents)
    ProgressOn("Pasting Progress", "Pasting Data", "0%", -1, 0, $DLG_NOTITLE)
    MouseClick($MOUSE_CLICK_LEFT)

    For $i = 1 To $ClipboardLength Step 1
        Sleep(500)
        $PercentDone = Percent($i, $ClipboardLength)
        $CurrCharacter = StringMid($ClipContents, $i, 1)
        ConsoleWrite("i:" & $i & " StringLen: " & $ClipboardLength & " Percent: " & $PercentDone & " Char: " & $CurrCharacter & @CRLF)
        ProgressSet($PercentDone, $PercentDone & "%")
        Send($CurrCharacter)
    Next

    ; Set the "subtext" and "maintext" of the progress bar window.
    ProgressSet(100, "Done", "Complete")
    Sleep(1000)

    ; Close the progress window.
    ProgressOff()
EndFunc

; Good old fashioned loop
While 1
  Sleep(100)
WEnD

; Exit script
Func Terminate()
  Exit 0
EndFunc