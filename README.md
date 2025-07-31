Option Explicit

Sub GenerateAllSubnetsFromBase()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("MasterDB")
    
    Dim baseIP As String: baseIP = "100.126.0.0"
    Dim basePrefix As Integer: basePrefix = 17
    Dim targetPrefix As Integer
    
    Dim rowIndex As Long: rowIndex = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row + 1
    
    For targetPrefix = basePrefix To 29
        Dim subnets As Collection
        Set subnets = GetSubnets(baseIP, basePrefix, targetPrefix)
        
        Dim s As Variant
        For Each s In subnets
            ws.Cells(rowIndex, 1).Value = "/" & targetPrefix                          ' Size
            ws.Cells(rowIndex, 2).Value = s                                           ' Subnet/Resource
            ws.Cells(rowIndex, 3).Value = ""                                          ' Code Range
            ws.Cells(rowIndex, 4).Value = 2 ^ (32 - targetPrefix)                     ' No of IPs
            ws.Cells(rowIndex, 5).Value = "us-central1"                               ' Region
            ws.Cells(rowIndex, 6).Value = ""                                          ' Description
            ws.Cells(rowIndex, 7).Value = "Available"                                 ' Status
            rowIndex = rowIndex + 1
        Next s
    Next targetPrefix

    MsgBox "Subnets from /17 to /29 generated under 100.126.0.0/17", vbInformation
End Sub

Function GetSubnets(baseIP As String, basePrefix As Integer, targetPrefix As Integer) As Collection
    Dim numSubnets As Long
    Dim baseIPLong As Double
    Dim increment As Double
    Dim i As Long
    Dim result As New Collection
    
    baseIPLong = IPToLong(baseIP)
    numSubnets = 2 ^ (targetPrefix - basePrefix)
    increment = 2 ^ (32 - targetPrefix)
    
    For i = 0 To numSubnets - 1
        result.Add LongToIP(baseIPLong + (i * increment)) & "/" & targetPrefix
    Next i
    
    Set GetSubnets = result
End Function

Function IPToLong(ip As String) As Double
    Dim parts() As String
    parts = Split(ip, ".")
    IPToLong = parts(0) * 16777216# + parts(1) * 65536# + parts(2) * 256# + parts(3)
End Function

Function LongToIP(ipLong As Double) As String
    LongToIP = Int(ipLong \ 16777216#) & "." & Int((ipLong Mod 16777216#) \ 65536#) & "." & Int((ipLong Mod 65536#) \ 256#) & "." & (ipLong Mod 256#)
End Function


To generate all subnets from 100.126.0.0/17 with sizes ranging from /17 to /29, you’ll be generating progressively smaller subnet blocks from the same base range.

🔧 What this VBA will do:
	•	Generate all subnets starting from /17 to /29 within the block 100.126.0.0/17
	•	Populate each generated subnet into the MasterDB sheet
	•	Set:
	•	Size = CIDR (e.g., /17, /18, …)
	•	Subnet/Resource = CIDR notation (e.g., 100.126.0.0/17)
	•	Code Range = (optional – you can fill later or adjust)
	•	Number of IPs = based on prefix
	•	Region = us-central1
	•	Description = (left blank)
	•	Status = Available

⸻

✅ VBA Code to Generate All /17 to /29 Subnets from 100.126.0.0/17

Paste this in a new module:

Option Explicit

Sub GenerateAllSubnetsFromBase()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("MasterDB")
    
    Dim baseIP As String: baseIP = "100.126.0.0"
    Dim basePrefix As Integer: basePrefix = 17
    Dim targetPrefix As Integer
    
    Dim rowIndex As Long: rowIndex = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row + 1
    
    For targetPrefix = basePrefix To 29
        Dim subnets As Collection
        Set subnets = GetSubnets(baseIP, basePrefix, targetPrefix)
        
        Dim s As Variant
        For Each s In subnets
            ws.Cells(rowIndex, 1).Value = "/" & targetPrefix                          ' Size
            ws.Cells(rowIndex, 2).Value = s                                           ' Subnet/Resource
            ws.Cells(rowIndex, 3).Value = ""                                          ' Code Range
            ws.Cells(rowIndex, 4).Value = 2 ^ (32 - targetPrefix)                     ' No of IPs
            ws.Cells(rowIndex, 5).Value = "us-central1"                               ' Region
            ws.Cells(rowIndex, 6).Value = ""                                          ' Description
            ws.Cells(rowIndex, 7).Value = "Available"                                 ' Status
            rowIndex = rowIndex + 1
        Next s
    Next targetPrefix

    MsgBox "Subnets from /17 to /29 generated under 100.126.0.0/17", vbInformation
End Sub

Function GetSubnets(baseIP As String, basePrefix As Integer, targetPrefix As Integer) As Collection
    Dim numSubnets As Long
    Dim baseIPLong As Double
    Dim increment As Double
    Dim i As Long
    Dim result As New Collection
    
    baseIPLong = IPToLong(baseIP)
    numSubnets = 2 ^ (targetPrefix - basePrefix)
    increment = 2 ^ (32 - targetPrefix)
    
    For i = 0 To numSubnets - 1
        result.Add LongToIP(baseIPLong + (i * increment)) & "/" & targetPrefix
    Next i
    
    Set GetSubnets = result
End Function

Function IPToLong(ip As String) As Double
    Dim parts() As String
    parts = Split(ip, ".")
    IPToLong = parts(0) * 16777216# + parts(1) * 65536# + parts(2) * 256# + parts(3)
End Function

Function LongToIP(ipLong As Double) As String
    LongToIP = Int(ipLong \ 16777216#) & "." & Int((ipLong Mod 16777216#) \ 65536#) & "." & Int((ipLong Mod 65536#) \ 256#) & "." & (ipLong Mod 256#)
End Function


⸻

📌 How to Run:
	1.	Go to Developer tab → Click Insert → Add a Button
	2.	Assign macro: GenerateAllSubnetsFromBase
	3.	Press the button and the script will generate subnets from /17 to /29 under 100.126.0.0/17.

⸻

Do you want me to also auto-fill the Code Range column (e.g., start-end IP)? I can add that too.
