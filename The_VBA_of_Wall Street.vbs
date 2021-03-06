Attribute VB_Name = "Module1"
Sub VBAOnMultipleSheets()
    Dim ws As Worksheet
    Application.ScreenUpdating = False
    For Each ws In Worksheets
        ws.Select
        Call RunCode
    Next
    Application.ScreenUpdating = True
End Sub
Sub RunCode()
Dim i As Long
Dim Ticker_Count As Long
Dim Ticker As String
Dim OPrice As Double
Dim CPrice As Double
Dim LastRow As Double
Dim Color_LastRow As Double
Dim CH_LastRow As Double
Dim Summary_Table_Row As Integer
Dim Yearly_Change As Double
Dim Total_Stock_Volume As Double
Dim GMin As String
Dim GMax As String
Dim GTVol As Double


 Range("J1:M1").Value = Array("Ticker", "Yearly Change", "Percent Change", "Total Stock Volume")
 Range("P1:Q1").Value = Array("Ticker", "Value")
 Range("O2").Value = "Greatest % Increase"
 Range("O3").Value = "Greatest % Decrease"
 Range("O4").Value = "Greatest Total Volume"

Summary_Table_Row = 2
Total_Stock_Volume = 0

LastRow = Worksheets("2016").Cells(Rows.Count, 1).End(xlUp).Row


Ticker_TotalCount = 1
Ticker_Count = 1
For i = 2 To LastRow

OPrice = Cells(i - (Ticker_Count - 1), 3).Value
Ticker = Cells(i, 1).Value
If Cells(i + 1, 1).Value = Cells(i, 1).Value Then
Ticker_Count = Ticker_Count + 1
Total_Stock_Volume = Total_Stock_Volume + Cells(i + 1, 7)

Else

CPrice = Cells(Ticker_TotalCount + 1, 6).Value

Range("J" & Summary_Table_Row).Value = Ticker
Yearly_Change = CPrice - OPrice
Range("K" & Summary_Table_Row).Value = Yearly_Change
If Yearly_Change < 0 Then
Range("K" & Summary_Table_Row).Interior.ColorIndex = 3
ElseIf Yearly_Change >= 0 Then
Range("K" & Summary_Table_Row).Interior.ColorIndex = 4

End If
If OPrice <> 0 Then
Range("L" & Summary_Table_Row).Value = FormatPercent(Yearly_Change / OPrice)
End If
Range("M" & Summary_Table_Row).Value = Total_Stock_Volume
Total_Stock_Volume = 0
Summary_Table_Row = Summary_Table_Row + 1

Ticker_Count = 1
End If
Ticker_TotalCount = Ticker_TotalCount + 1
Next i

CH_LastRow = Worksheets("2016").Cells(Rows.Count, 10).End(xlUp).Row


 GMin = Application.WorksheetFunction.Min(Columns("L"))
 GMax = Application.WorksheetFunction.Max(Columns("L"))
 GTVol = Application.WorksheetFunction.Max(Columns("M"))
 
 For m = 2 To CH_LastRow
 
If Cells(m, 12).Value = GMin Then
Cells(3, 16).Value = Cells(m, 10).Value
Cells(3, 17).Value = FormatPercent(GMin)

ElseIf Cells(m, 12).Value = GMax Then
Cells(2, 16).Value = Cells(m, 10).Value
Cells(2, 17).Value = FormatPercent(GMax)
ElseIf Cells(m, 13).Value = GTVol Then
Cells(4, 16).Value = Cells(m, 10).Value
Cells(4, 17).Value = GTVol


End If
Next m

 
End Sub




