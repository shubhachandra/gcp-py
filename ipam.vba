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
    Dim octets() As String
    Dim i As Integer
    octets = Split(ip, ".")
    If UBound(octets) <> 3 Then
        IsValidIP = False
        Exit Function
    End If
    For i = 0 To 3
        If Not IsNumeric(octets(i)) Then
            IsValidIP = False
            Exit Function
        End If
        If CInt(octets(i)) < 0 Or CInt(octets(i)) > 255 Then
            IsValidIP = False
            Exit Function
        End If
    Next i
    IsValidIP = True
End Function

Function IsValidCIDR(cidr As String) As Boolean
    Dim parts() As String
    Dim prefix As Integer
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

Sub CheckSubnetStatus()
    Dim wsDB As Worksheet, wsUI As Worksheet
    Dim inputSubnet As String
    Dim found As Range

    Set wsDB = Sheets("Sheet1")
    Set wsUI = Sheets("Sheet2")

    inputSubnet = Trim(wsUI.Range("D5").Value)
    If inputSubnet = "" Then
        wsUI.Range("D7").Value = "?? Please enter a subnet."
        Exit Sub
    End If

    Set found = wsDB.Range("B:B").Find(What:=inputSubnet, LookIn:=xlValues, LookAt:=xlWhole)
    If Not found Is Nothing Then
        wsUI.Range("D7").Value = "? Status: " & found.Offset(0, 1).Value
    Else
        wsUI.Range("D7").Value = "? Subnet not found in database."
    End If
End Sub

Sub ReserveSubnet()
    Dim wsDB As Worksheet, wsUI As Worksheet
    Dim inputSubnet As String
    Dim found As Range, i As Long
    Dim desc As String, appID As String
    Dim netStart As Double, netEnd As Double
    Dim rangeArr As Variant, rowLast As Long
    Dim parentPrefix As Integer

    Set wsDB = Sheets("Sheet1")
    Set wsUI = Sheets("Sheet2")

    inputSubnet = Trim(wsUI.Range("D5").Value)
    If inputSubnet = "" Then
        wsUI.Range("D7").Value = "? Please enter a subnet in D5."
        Exit Sub
    End If

    If Not IsValidCIDR(inputSubnet) Then
        wsUI.Range("D7").Value = "? Invalid CIDR format. Use IP/Prefix (e.g., 192.168.1.0/24)."
        Exit Sub
    End If

    Set found = wsDB.Range("B:B").Find(What:=inputSubnet, LookIn:=xlValues, LookAt:=xlWhole)
    If found Is Nothing Then
        wsUI.Range("D7").Value = "? Subnet not found in database."
        Exit Sub
    End If

    If UCase(Trim(found.Offset(0, 1).Value)) <> "AVAILABLE" Then
        wsUI.Range("D7").Value = "?? Subnet is not available."
        Exit Sub
    End If

    desc = InputBox("Enter subnet description:", "Subnet Description")
    If Trim(desc) = "" Then
        wsUI.Range("D7").Value = "? Reservation cancelled. Description is required."
        Exit Sub
    End If

    appID = InputBox("Enter App ID for this reservation:", "App ID")
    If Trim(appID) = "" Then
        wsUI.Range("D7").Value = "? Reservation cancelled. App ID is required."
        Exit Sub
    End If

    ' Mark selected subnet as Reserved
    found.Offset(0, 1).Value = "Reserved"
    found.Offset(0, 2).Value = desc
    found.Offset(0, 3).Value = appID

    parentPrefix = CInt(Split(inputSubnet, "/")(1))
    rangeArr = CIDRToRange(inputSubnet)
    If rangeArr(0) = -1 Then
        wsUI.Range("D7").Value = "? Invalid subnet range."
        Exit Sub
    End If

    netStart = rangeArr(0)
    netEnd = rangeArr(1)

    rowLast = wsDB.Cells(wsDB.Rows.Count, "B").End(xlUp).Row

    For i = 2 To rowLast
        Dim cidr As String
        Dim thisPrefix As Integer
        Dim thisRange As Variant
        Dim thisStart As Double, thisEnd As Double

        cidr = Trim(wsDB.Cells(i, 2).Value)
        If cidr = "" Then GoTo ContinueNext

        On Error Resume Next
        thisPrefix = CInt(Split(cidr, "/")(1))
        thisRange = CIDRToRange(cidr)
        On Error GoTo 0

        If IsEmpty(thisRange) Then GoTo ContinueNext

        thisStart = thisRange(0)
        thisEnd = thisRange(1)

        If thisPrefix > parentPrefix Then
            If thisStart >= netStart And thisEnd <= netEnd Then
                wsDB.Cells(i, 3).Value = "Not Available"
                wsDB.Cells(i, 4).Value = "Supernetting"
                wsDB.Cells(i, 5).Value = "NULL"
            End If
        End If

        If thisPrefix < parentPrefix And thisPrefix >= 18 Then
            If thisStart <= netStart And thisEnd >= netEnd Then
                wsDB.Cells(i, 3).Value = "Not Available"
                wsDB.Cells(i, 4).Value = "Supernetting"
                wsDB.Cells(i, 5).Value = "NULL"
            End If
        End If

ContinueNext:
    Next i

    wsUI.Range("D7").Value = "? Subnet reserved. Parent/Child subnets updated."
End Sub

Sub CheckAllChildSubnetsAvailability()
    Dim wsDB As Worksheet, wsUI As Worksheet
    Dim inputSubnet As String
    Dim parentRange As Variant, rowLast As Long
    Dim i As Long, prefix As Integer
    Dim netStart As Double, netEnd As Double
    Dim childCIDR As String, childRange As Variant
    Dim childPrefix As Integer, childStatus As String
    Dim allAvailable As Boolean

    Set wsDB = Sheets("Sheet1")
    Set wsUI = Sheets("Sheet2")

    inputSubnet = Trim(wsUI.Range("D5").Value)
    If inputSubnet = "" Then
        wsUI.Range("D7").Value = "?? Please enter a subnet."
        Exit Sub
    End If

    If Not IsValidCIDR(inputSubnet) Then
        wsUI.Range("D7").Value = "? Invalid CIDR format."
        Exit Sub
    End If

    parentRange = CIDRToRange(inputSubnet)
    netStart = parentRange(0)
    netEnd = parentRange(1)

    rowLast = wsDB.Cells(wsDB.Rows.Count, "B").End(xlUp).Row
    allAvailable = True

    For i = 2 To rowLast
        childCIDR = Trim(wsDB.Cells(i, 2).Value)
        If childCIDR = "" Then GoTo ContinueNext

        On Error Resume Next
        childPrefix = CInt(Split(childCIDR, "/")(1))
        On Error GoTo 0

        If childPrefix <= CInt(Split(inputSubnet, "/")(1)) Or childPrefix > 29 Then GoTo ContinueNext

        childRange = CIDRToRange(childCIDR)
        If IsEmpty(childRange) Then GoTo ContinueNext

        If childRange(0) >= netStart And childRange(1) <= netEnd Then
            childStatus = UCase(Trim(wsDB.Cells(i, 3).Value))
            If childStatus <> "AVAILABLE" Then
                allAvailable = False
                Exit For
            End If
        End If
ContinueNext:
    Next i

    If allAvailable Then
        wsUI.Range("D7").Value = "? All child subnets are AVAILABLE."
    Else
        wsUI.Range("D7").Value = "? Some child subnets are NOT AVAILABLE."
    End If
End Sub

