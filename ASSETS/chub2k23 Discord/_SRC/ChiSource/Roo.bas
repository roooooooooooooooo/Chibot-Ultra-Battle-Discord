Attribute VB_Name = "aaaRoo"
Global Const stdout = "game.txt"
Global Const stdin = "input.txt"

Function FileOverwrite(strFile As String, Text As String) As String
    
    
    Dim FileNum
    FileNum = FreeFile
    
        Open stdin For Output As FileNum
        Print #FileNum, Text
        Close FileNum
    
    
    '    Dim FileNum
    '    FileNum = FreeFile()
    
     '   Open strFile For Output As #FileNum
     '   Print #FileNum, Text
      '  Close #FileNum
End Function



Function ReadInput() As String
    ifile = FreeFile
       
    Open stdin For Input As #ifile
        'ReadInput = StrConv(InputB(LOF(ifile), ifile), vbUnicode)
       ReadInput = Input$(LOF(ifile), #ifile)
       Close #ifile
       
       
       'testing
        'Dim FileNum
        'FileNum = FreeFile
    
        'Open "test2.txt" For Output As FileNum
        'Print #FileNum, ReadInput
        'Close FileNum
       
       
       
End Function

