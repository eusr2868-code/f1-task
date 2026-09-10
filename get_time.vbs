d = DateAdd("n", 3, Now)
WScript.Echo Year(d) & "/" & Right("0" & Month(d), 2) & "/" & Right("0" & Day(d), 2) & " " & Right("0" & Hour(d), 2) & ":" & Right("0" & Minute(d), 2)
