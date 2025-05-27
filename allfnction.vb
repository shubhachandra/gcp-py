' ----------------------------
' --- IP & CIDR Utilities ---
' ----------------------------
Function IPToLong(ip As String) As Double
    Dim octets() As String
    On Error GoTo ErrHandler
    octets = Split(Trim(ip), ".")
    If UBound(octets) <> 3 Then
        IPToLong = -1
        Exit Function
    End If
    IPToLong = CLng(octets(0)) * 16777216# + CLng(octets(1)) * 65536# + CLng(octets(2)) * 256# + CLng(octets(3))
    Exit Function
ErrHandler:
    IPToLong = -1
End Function

Function LongToIP(lng As Double) As String
    LongToIP = Int(lng \ 16777216#) & "." & Int((lng Mod 16777216#) \ 65536#) & "." & Int((lng Mod 65536#) \ 256#) & "." & (lng Mod 256#)
End Function

Function CIDRToRange(cidr As String) As Variant
    Dim parts() As String, ip As String, prefix As Integer
    Dim base As Double, size As Double
    parts = Split(Trim(cidr), "/")
    If UBound(parts) <> 1 Then
        CIDRToRange = Array(-1, -1)
        Exit Function
    End If
    ip = parts(0)
    prefix = CInt(parts(1))
    base = IPToLong(ip)
    If base = -1 Then
        CIDRToRange = Array(-1, -1)
        Exit Function
    End If
    size = 2 ^ (32 - prefix)
    CIDRToRange = Array(base, base + size - 1)
End Function

Function IsValidIP(ip As String) As Boolean
    Dim octets() As String, i As Integer
    octets = Split(ip, ".")
    If UBound(octets) <> 3 Then IsValidIP = False: Exit Function
    For i = 0 To 3
        If Not IsNumeric(octets(i)) Or CInt(octets(i)) < 0 Or CInt(octets(i)) > 255 Then
            IsValidIP = False: Exit Function
        End If
    Next i
    IsValidIP = True
End Function

Function IsValidCIDR(cidr As String) As Boolean
    Dim parts() As String, prefix As Integer
    On Error GoTo Invalid
    parts = Split(cidr, "/")
    If UBound(parts) <> 1 Then GoTo Invalid
    If Not IsValidIP(parts(0)) Then GoTo Invalid
    If Not IsNumeric(parts(1)) Then GoTo Invalid
    prefix = CInt(parts(1))
    If prefix < 0 Or prefix > 32 Then GoTo Invalid
    IsValidCIDR = True
    Exit Function
Invalid:
    IsValidCIDR = False
End Function

' ----------------------------
' --- Unified Subnet Reservation ---
' ----------------------------
Sub ReserveAllSheetSubnets()
    Dim wsUI As Worksheet: Set wsUI = Sheets("UI")
    Dim inputRows As Variant: inputRows = Array(23, 25, 27, 29)
    Dim sheetNames As Variant: sheetNames = Array("primary_range", "nonroutable_range", "PUPI-ranges", "masterip")
    Dim i As Integer, inputSubnet As String, wsDB As Worksheet, found As Range
    Dim desc As String, appID As String

    For i = 0 To 3
        inputSubnet = Trim(wsUI.Cells(inputRows(i), 2).Value)
        If inputSubnet = "" Then GoTo ContinueNext

        If Not IsValidCIDR(inputSubnet) Then
            wsUI.Range("D7").Value = "? Invalid CIDR in row " & inputRows(i)
            Exit Sub
        End If

        Set wsDB = Sheets(sheetNames(i))
        Set found = wsDB.Range("B:B").Find(What:=inputSubnet, LookIn:=xlValues, LookAt:=xlWhole)
        If found Is Nothing Then GoTo ContinueNext

        If UCase(Trim(found.Offset(0, 1).Value)) <> "AVAILABLE" Then GoTo ContinueNext

        If desc = "" Then
            desc = InputBox("Enter Subnet Description (for all):", "Description")
            If desc = "" Then wsUI.Range("D7").Value = "? Reservation cancelled. Description is required.": Exit Sub
        End If
        If appID = "" Then
            appID = InputBox("Enter App ID (for all):", "App ID")
            If appID = "" Then wsUI.Range("D7").Value = "? Reservation cancelled. App ID is required.": Exit Sub
        End If

        found.Offset(0, 1).Value = "Reserved"
        found.Offset(0, 2).Value = desc
        found.Offset(0, 3).Value = appID

        Call MarkParentsAndChildren(wsDB, inputSubnet)

ContinueNext:
    Next i

    wsUI.Range("D7").Value = "? Reservation done for all selected rows."
End Sub

Sub MarkParentsAndChildren(wsDB As Worksheet, inputSubnet As String)
    Dim i As Long, rowLast As Long
    Dim parentRange As Variant, parentPrefix As Integer
    Dim childCIDR As String, childPrefix As Integer
    Dim childRange As Variant, childStart As Double, childEnd As Double
    Dim netStart As Double, netEnd As Double

    parentPrefix = CInt(Split(inputSubnet, "/")(1))
    parentRange = CIDRToRange(inputSubnet)
    If parentRange(0) = -1 Then Exit Sub

    netStart = parentRange(0): netEnd = parentRange(1)
    rowLast = wsDB.Cells(wsDB.Rows.Count, "B").End(xlUp).Row

    For i = 2 To rowLast
        childCIDR = Trim(wsDB.Cells(i, 2).Value)
        If childCIDR = "" Then GoTo Skip

        On Error Resume Next
        childPrefix = CInt(Split(childCIDR, "/")(1))
        childRange = CIDRToRange(childCIDR)
        On Error GoTo 0

        If IsEmpty(childRange) Then GoTo Skip
        childStart = childRange(0): childEnd = childRange(1)

        ' Mark child
        If childPrefix > parentPrefix Then
            If childStart >= netStart And childEnd <= netEnd Then
                wsDB.Cells(i, 3).Value = "Not Available"
                wsDB.Cells(i, 4).Value = "Supernetting"
                wsDB.Cells(i, 5).Value = "NULL"
            End If
        End If

        ' Mark parent
        If childPrefix < parentPrefix And childPrefix >= 18 Then
            If childStart <= netStart And childEnd >= netEnd Then
                wsDB.Cells(i, 3).Value = "Not Available"
                wsDB.Cells(i, 4).Value = "Supernetting"
                wsDB.Cells(i, 5).Value = "NULL"
            End If
        End If
Skip:
    Next i
End Sub
