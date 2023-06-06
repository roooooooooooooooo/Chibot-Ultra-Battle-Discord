Attribute VB_Name = "APIStuff"
Option Explicit

Declare Function GetTopWindow Lib "user32" (ByVal hwnd As Long) As Long
Declare Function GetNextWindow Lib "user32" Alias "GetWindow" (ByVal hwnd As Long, ByVal wFlag As Long) As Long

Declare Function AOLGetList Lib "311.DLL" (ByVal index%, ByVal Buf$) As Integer
Declare Function AOLGetCombo Lib "311.DLL" (ByVal index%, ByVal Buf$) As Integer

Function AOLCheck() As Integer
Dim x As Integer
Dim NullStr As String
Dim AOL As Integer
Dim MDI As Integer
Dim child As Integer
Dim x2 As Integer
Dim Y As Integer
  If FindChatroom1() <> 0 Then
    AOLCheck = 444
    Exit Function
  End If
  AOL = FindWindow("AOL Frame25", 0&)       ' Find the AOL Frame25
  MDI = FindChildByClass(AOL, "MDIClient")    ' Find the MDI Client Chat Window
  child = FindChildByClass(MDI, "AOL Child")
  x = FindChildByClass(child, "_AOL_EDIT")    ' Finds the Chat Line
  Select Case x
    Case 0:
      x2 = FindChildByClass(child, "RICHCNTL")
      If x2 <> 0 Then
        AOLCheck = 444
      Else
        'AOL = FindWindow("mIRC32", 0&)
        'MDI = FindChildByClass(AOL, "MDIClient")
        'Child = FindChildByClass(MDI, "channel")
        'x = FindChildByClass(Child, "Edit")
        'If x = 0 Then
          AOLCheck = 0
        'Else
        '  AOLCheck = 32
        'End If
      End If
    Case Else:
      AOLCheck = 333
  End Select
End Function

Sub AOLTitle(ByVal S As String)
Dim x As Integer
  x = FindWindow("AOL Frame25", 0&)
  SetWindowText x, S
End Sub

Sub Click(P As Integer)
' Simulates a mouse click on the current highlighted button
Dim x As Long
  x = SendMessage(P, &H201, 0, 0)
  x = SendMessage(P, &H202, 0, 0)
End Sub

Function CountPeeps() As Integer
Dim Frame25 As Integer
Dim MDIClient As Integer
Dim AOLChild As Integer
Dim ListBox As Integer
  'Frame25 = FindWindow("AOL Frame25", 0&)
  'MDIClient = FindChildByClass(Frame25, "MDIClient")
  AOLChild = FindChatroom1()
  ListBox = FindChildByClass(AOLChild, "_AOL_Listbox")
  CountPeeps = SendMessage(ListBox, LB_GETCOUNT, 0, 0)
End Function

Sub Delay(S As Single)
' Will cause a delay for S seconds while calling DoEvents to prevent system
' from halting.
Dim x As Single
  x = Timer + S
  Do While x >= Timer
    DoEvents
  Loop
End Sub

Function FindChatroom1() As Integer
Dim AOL%
Dim B%, OldB%
Dim C%, D%, E%
Dim MDI%
Dim Ver%
Dim P$, x%, Y%
'Finds the handle of the AOL Chatroom by looking for a
'Window with a ListBox (Chat ScreenNames), Edit Box,
'(Where you type chat text), and an _AOL_VIEW.  If another
'AOL window is present that also has these 3 controls, it
'may find the wrong window.  I have never seen another AOL
'window with these 3 controls at once

AOL = FindWindow("AOL Frame25", vbNullString)
If AOL = 0 Then Exit Function
MDI% = FindChildByClass(AOL, "MDIClient")
If MDI = 0 Then Exit Function
B = FindChildByClass(MDI, "AOL Child")

Ver = 444
Start:
If Ver = 444 Then
  C = FindChildByClass(B, "RICHCNTL")
  If C = 0 Then GoTo NextWnd
Else
  C = FindChildByClass(B, "_AOL_VIEW")
  If C = 0 Then GoTo NextWnd
  D = FindChildByClass(B, "_AOL_EDIT")
  If D = 0 Then GoTo NextWnd
End If
E = FindChildByClass(B, "_AOL_LISTBOX")
If E = 0 Then GoTo NextWnd
'We've found it
P$ = GetCaption(B)
OldB = B
'If GodMode1 = False Then
'  If Left$(P$, 25) = "Arts and Entertainment - " Then B = 0
'  If Left$(P$, 14) = "Town Square - " Then B = 0
'  If Left$(P$, 10) = "Friends - " Then B = 0
'  If Left$(P$, 7) = "Life - " Then B = 0
'  If Left$(P$, 28) = "News, Sports, and Finance - " Then B = 0
'  If Left$(P$, 9) = "Places - " Then B = 0
'  If Left$(P$, 10) = "Romance - " Then B = 0
'  If Left$(P$, 20) = "Special Interests - " Then B = 0
'  If Left$(P$, 10) = "Germany - " Then B = 0
'  If Left$(P$, 20) = "The UK Experience - " Then B = 0
'  If Left$(P$, 9) = "France - " Then B = 0
'  If Left$(P$, 8) = "Japan - " Then B = 0
'  If Left$(P$, 9) = "Canada - " Then B = 0
'  If Left$(P$, 12) = "Australia - " Then B = 0
'  If P$ = "SM Battle" Then B = 0
'End If
FindChatroom1 = B
Exit Function

NextWnd:
B = GetNextWindow(B, 2)
If B = GetWindow(B, GW_HWNDLAST) Then Exit Function
GoTo Start


End Function

Function GetLineOfChat() As Variant
' Returns the bottom line of chat from the chat window
Dim S As String
Dim Frame25 As Integer
Dim MDIClient As Integer
Dim Parent As Integer
Dim View As Integer
Dim x1, x2 As Long

'    Debug.Print "ya"

'  If mIRCChannel <> "" Then
'    GetLineOfChat = mIRCGetChat
'  Else
    Parent = FindChatroom1()
    View = FindChildByClass(Parent, "RICHCNTL")
    x1 = SendMessage(View, 14, 0, 0)                   ' Prepares to get a line of chat
    S = Space$(x1)                             ' X1 is the length of the string
    x2 = SendMessageByString(View, 13, x1 + 1, S)                ' S now contains the line of chat
    GetLineOfChat = S 'is this actually supposed to be spaces? -Roo
    
    Dim xxx As Integer
    xxx = Int(Rnd * 2)
    If (xxx = 0) Then
    '    GetLineOfChat = "XxRooxX: .aeris"
    Else
    '    GetLineOfChat = "RoobyDooby: .beryl"
    End If
    
 ' End If
End Function
Function mIRCGetChat() As Variant
Dim mIRC%, MDI%, Channel%, Scroll%, x1%, Result%
Dim S$
Dim Total$
  'mIRC% = FindWindow("mIRC32", vbNullString)
  'If mIRC% = 0 Then Exit Function
  'MDI% = FindChildByClass(mIRC, "MDIClient")
  'Channel% = FindChildByTitle2(MDI%, mIRCChannel)
  'Scroll% = FindChildByClass(Channel%, "ScrollBar")
  'X1% = SendMessage(Scroll, 14, 0, 0)                   ' Prepares to get a line of chat
  'S = Space$(X1)                             ' X1 is the length of the string
  'Result% = SendMessageByString(Scroll, 13, X1 + 1, S)                ' S now contains the line of chat
  'mIRCGetChat = S
  'Stop
  On Error GoTo DontLoad
  Open "c:\windows\temp\chub.tmp" For Input As 1
  On Error GoTo 0
  Total = ""
  While Not EOF(1)
    Input #1, S$
    Total$ = Total$ + S$ + Chr$(13) + Chr$(10)
  Wend
  Close 1
  'Kill "c:\windows\temp\chub.tmp"
  mIRCGetChat = Total$
DontLoad:
End Function
Function InRoom(ByVal SN$) As Integer
Dim x%, Room%, List%, N$, Tv%
  Room = FindChatroom1()
  If Room = 0 Then Exit Function
  List = FindChildByClass(Room, "_AOL_LISTBOX")
  x = SendMessage(List, WM_SETFOCUS, 0, 0)
  N$ = Space$(10)
  For x = 0 To 23
    Tv% = AOLGetList(x, N$)
    If N$ = SN$ Then
      InRoom = True
      Exit Function
    End If
  Next x
  InRoom = False
End Function

Sub ScrollSend(ByVal S As String)
  'DoEvents
  If S = "" Then Exit Sub
  'If Len(Trim(StripHTML(S))) > 130 Then
  '  'ScrollSend ("<font color=#FF0000><b>WARNING: Next line too long, truncated")
  '  ScrollSend (Left$(S, 130))
  '  S = Right$(S, Len(S) - 130)
  '  ScrollSend (S)
  '  Exit Sub
  'End If
  If (OutPtr > outmax) Then OutPtr = outmax
  OutRay(OutPtr) = Trim(S)
  'If Left$(S, 1) = "/" Then Stop
  OutPtr = OutPtr + 1
  DoEvents
  If (OutPtr > outmax) Then
    OutPtr = 1
  End If
  'Delay (.25)
  'mIRCChatSend (S)
End Sub

Sub ScrollSend1(ByVal S As String)
Dim S1$
Dim S2$, Z%
  'If (FindChatroom1() = 0) And (AOLCheck() <> 32) Then
  '  S2 = StripHTML(S)
  '  If S2 = "" Or S2 = "0" Then Exit Sub
  '  'If LineCount(fOffline!tDebug) >= 28 Then fOffline!tDebug = ""
  '  Z = Len(fOffline!tDebug.Text)
  '  If Z > 15000 Then fOffline!tDebug.Text = Right$(fOffline!tDebug.Text, 10000)
  '  fOffline!tDebug.ForeColor = 0
  '  fOffline!tDebug = fOffline!tDebug + S2 + Chr$(13) + Chr$(10)
  '  fOffline!tDebug.SelStart = Len(fOffline!tDebug.Text)
  '  fOffline!tDebug.ForeColor = RGB(255, 255, 255)
  'Else
  '  'S1 = "<font face=""" + Trim(StripHiAscii(Config.FontName)) + """ color=""#" + Trim(StripHiAscii(Config.FontColor)) + """>" + S
  '  S1 = S
  If Left$(S, 1) = Chr$(10) Then
    'S1 = ccColor + "14" + Right$(S, Len(S) - 1) + ccColor
    S1 = Right$(S, Len(S) - 1)
  ElseIf Left$(S, 1) = "/" Then
    S1 = S
  Else
    'S1 = ccColor + "14" + S + ccColor
    S1 = S
  End If
  ChatSend2 (S1)
  'End If
End Sub

Sub Send(ByVal S As String)
  ScrollSend (S)
  DoEvents
  'If (Not DebugWindow) Then Delay (.75)
End Sub

Sub Send2(ByVal S As String, ByVal T As Single)
' Will delay T seconds after sending.
  ScrollSend (S)
  'If (Not DebugWindow) Then Delay (T)
End Sub

Sub Send5(ByVal S As String)
' Will delay .7 seconds after sending.
  ScrollSend (S)
  'If (Not DebugWindow) Then Delay (.7)
End Sub

Sub TestingKUB()
Dim Ds As Integer
  Ds = 0
  Stop
  Do
    ScrollSend "Ignore me, I'm just testing KUB."
    Delay (0.5)
  Loop Until (Ds = 1)
End Sub

