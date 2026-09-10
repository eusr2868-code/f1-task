' Press F1 once and append a log line. ASCII only.
On Error Resume Next
Set WshShell = CreateObject("WScript.Shell")
WshShell.SendKeys "{F1}"
errNo = Err.Number
Set fso = CreateObject("Scripting.FileSystemObject")
logPath = fso.GetParentFolderName(WScript.ScriptFullName) & "\f1_press_log.txt"
Set f = fso.OpenTextFile(logPath, 8, True)
f.WriteLine CStr(Now) & " F1 pressed (err=" & errNo & ")"
f.Close
