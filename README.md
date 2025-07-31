Option Explicit

' Utility function to get CIDR prefix from a subnet string like "100.124.0.0/24"
Function GetCIDRPrefix(subnet As String) As Integer
    On Error GoTo errHandler
    GetCIDRPrefix = CInt(Split(subnet, "/")(1))
    Exit Function
errHandler:
    GetCIDRPrefix = -1
End Function

Sub UpdateSubnetStatusFromUtilisation()
    Dim wsUtil As Worksheet, wsMaster As Worksheet
    Dim utilRow As Long, utilLastRow As Long
    Dim masterRow As Long, masterLastRow As Long
    Dim utilSubnet As String, masterSubnet As String
    Dim utilCIDR As Integer, masterCIDR As Integer
    
    Set wsUtil = ThisWorkbook.Sheets("Utilisation")
    Set wsMaster = ThisWorkbook.Sheets("MasterDB")
    
    utilLastRow = wsUtil.Cells(wsUtil.Rows.Count, "B").End(xlUp).Row
    masterLastRow = wsMaster.Cells(wsMaster.Rows.Count, "B").End(xlUp).Row
    
    For utilRow = 2 To utilLastRow ' Assuming headers in row 1
        utilSubnet = Trim(wsUtil.Cells(utilRow, 2).Value)
        utilCIDR = GetCIDRPrefix(utilSubnet)
        
        For masterRow = 2 To masterLastRow
            masterSubnet = Trim(wsMaster.Cells(masterRow, 2).Value)
            masterCIDR = GetCIDRPrefix(masterSubnet)
            
            If masterSubnet = utilSubnet Then
                wsMaster.Cells(masterRow, 7).Value = "Reserved"
            ElseIf IsSupernet(masterSubnet, utilSubnet) Or IsSubnet(masterSubnet, utilSubnet) Then
                wsMaster.Cells(masterRow, 7).Value = "Unavailable"
            End If
        Next masterRow
    Next utilRow
    
    MsgBox "Update completed."
End Sub

' Checks if masterSubnet is a supernet of utilSubnet
Function IsSupernet(masterSubnet As String, utilSubnet As String) As Boolean
    IsSupernet = CompareCIDR(masterSubnet, utilSubnet, "supernet")
End Function

' Checks if masterSubnet is a subnet of utilSubnet
Function IsSubnet(masterSubnet As String, utilSubnet As String) As Boolean
    IsSubnet = CompareCIDR(masterSubnet, utilSubnet, "subnet")
End Function

' Generic function to compare two CIDRs
Function CompareCIDR(cidr1 As String, cidr2 As String, mode As String) As Boolean
    Dim ip1 As String, ip2 As String
    Dim prefix1 As Integer, prefix2 As Integer
    
    ip1 = Split(cidr1, "/")(0)
    ip2 = Split(cidr2, "/")(0)
    prefix1 = CInt(Split(cidr1, "/")(1))
    prefix2 = CInt(Split(cidr2, "/")(1))
    
    If mode = "supernet" And prefix1 < prefix2 Then
        CompareCIDR = (IPInRange(ip2, cidr1))
    ElseIf mode = "subnet" And prefix1 > prefix2 Then
        CompareCIDR = (IPInRange(ip1, cidr2))
    Else
        CompareCIDR = False
    End If
End Function

' Checks if IP is within the CIDR range
Function IPInRange(ip As String, cidr As String) As Boolean
    Dim baseIP As String, prefix As Integer
    baseIP = Split(cidr, "/")(0)
    prefix = CInt(Split(cidr, "/")(1))
    
    Dim ipBin As String, baseIPBin As String
    ipBin = IPToBinary(ip)
    baseIPBin = IPToBinary(baseIP)
    
    IPInRange = (Left(ipBin, prefix) = Left(baseIPBin, prefix))
End Function

' Convert IP to 32-bit binary string
Function IPToBinary(ip As String) As String
    Dim parts() As String
    Dim result As String, i As Integer
    
    parts = Split(ip, ".")
    For i = 0 To 3
        result = result & Right("00000000" & WorksheetFunction.Dec2Bin(CInt(parts(i)), 8), 8)
    Next i
    
    IPToBinary = result
End Function
