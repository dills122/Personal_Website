<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vb-net.aspx.cs" Inherits="Code_Examples_vb_net" MasterPageFile="~/MasterPage.master" %>


<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <link rel="stylesheet" href="../css/foundation.css">
    <script src="../js/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <div class="container-fluid">
        <div style="text-align: center">
            <h2>Auto Complete Function</h2>
            <p style="font-size: medium; text-align: center">
                This function is used on the COPOS websystem that I help to develop and maintain at my internship currently.
                Its resonsible for totaling cells on the systems various report pages and displaying the totaled value in 
                another cell on the page. It uses rules that are created by system administrators. For Auto Completed cells
                the totaled value is displayed in a disabled cell, so users cannot try to change the value.
            </p>

        </div>
        <div class="row">

            <div class="col-xs-6 col-lg-6 col-md-6" style="text-align: left; width: 50%">
                <div>
                    <h3>Before Rewrite</h3>
                    <br />
                    <h4>Description: </h4>
                    <p style="margin-right: 2cm; font-size: medium">
                    </p>
                </div>
                <pre class="pre-scrollable, vbnet" style="max-height: 800px"><code>
 'Method to perform system-calculations; called by Page_Load, btnSubmit_Click, and btnCompleteSection_Click
    Sub AutoComplete()
        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString)
        Dim sql As String = ""
        conn.Open()

        'select all validators related to the section displayed
        sql = "Select Operator, Left_Group, Right_Group From AUTO_COMPLETE INNER JOIN [GROUP] ON Left_Group=GroupID Where SectionID=" & Request.QueryString("SectionID") & " order by GroupType, COrder"
        Dim da As New SqlDataAdapter(sql, conn), ds As New DataSet, datarow As DataRow
        da.Fill(ds, "AC")
        For Each datarow In ds.Tables("AC").Rows
            Dim LeftGroupHeadings As New ArrayList, RightGroupHeadings As New ArrayList
            Dim LeftGroupQuestions As New ArrayList
            Dim RightGroupQuestions As New ArrayList, LeftGroupArithmetic As String = "" 
            Dim RightGroupArithmetic As String = ""
            Dim LeftGroupAHeadings As New ArrayList, RightGroupAHeadings As New ArrayList 
            Dim LeftGroupAQuestions As New ArrayList, RightGroupAQuestions As New ArrayList
            Dim LeftGroupAArithmetic As String = "", RightGroupAArithmetic As String = ""
            Dim dr As SqlDataReader

            'THIS LOGIC IS FOR THE NEW GROUP TYPE 3 LOGIC
            sql = "Select HeadingID, QuestionID, [Operator] From GROUP_ITEMS2 as G2, [GROUP] AS G, ARITHMETIC_OPERATORS AS A WHERE G.GroupType=3 AND G2.GroupID=G.GroupID AND G.ArithmeticOperator=A.ArithmeticID AND G2.GroupID=@GroupID"
            Dim cmd As New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@GroupID", datarow(1)))
            dr = cmd.ExecuteReader()
            While dr.Read()
                LeftGroupAHeadings.Add(dr("HeadingID"))
                LeftGroupAQuestions.Add(dr("QuestionID"))
                LeftGroupAArithmetic = dr("Operator")
            End While
            dr.Close()
            sql = "Select HeadingID, QuestionID, [Operator] From GROUP_ITEMS2 as G2, [GROUP] AS G, ARITHMETIC_OPERATORS AS A WHERE G.GroupType=3 AND G2.GroupID=G.GroupID AND G.ArithmeticOperator=A.ArithmeticID AND G2.GroupID=@GroupID"
            cmd = New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@GroupID", datarow(2)))
            dr = cmd.ExecuteReader()
            While dr.Read()
                RightGroupAHeadings.Add(dr("HeadingID"))
                RightGroupAQuestions.Add(dr("QuestionID"))
                RightGroupAArithmetic = dr("Operator")
            End While
            dr.Close()

            '-------------------------------------------------------------------------------------

            'selects left and right items in the rule
            sql = "Select HeadingID, [Operator] From GROUP_ITEMS2 as G2, [GROUP] AS G, ARITHMETIC_OPERATORS AS A WHERE G.GroupType=2 AND G2.GroupID=G.GroupID AND G.ArithmeticOperator=A.ArithmeticID AND G2.GroupID=@GroupID"
            cmd = New SqlCommand(sql, conn)

            cmd.Parameters.Add(New SqlParameter("@GroupID", datarow(1)))
            dr = cmd.ExecuteReader()
            While dr.Read()
                LeftGroupHeadings.Add(dr("HeadingID"))
                LeftGroupArithmetic = dr("Operator")
            End While
            dr.Close()
            sql = "Select HeadingID, [Operator] From GROUP_ITEMS2 as G2, [GROUP] AS G, ARITHMETIC_OPERATORS AS A WHERE G.GroupType=2 AND G2.GroupID=G.GroupID AND G.ArithmeticOperator=A.ArithmeticID AND G2.GroupID=@GroupID"
            cmd = New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@GroupID", datarow(2)))
            dr = cmd.ExecuteReader()
            While dr.Read()
                RightGroupHeadings.Add(dr("HeadingID"))
                RightGroupArithmetic = dr("Operator")
            End While
            dr.Close()
            sql = "Select QuestionID, [Operator] From GROUP_ITEMS2 as G2, [GROUP] AS G, ARITHMETIC_OPERATORS AS A WHERE G.GroupType=1 AND G2.GroupID=G.GroupID AND G.ArithmeticOperator=A.ArithmeticID AND G2.GroupID=@GroupID"
            cmd = New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@GroupID", datarow(1)))
            dr = cmd.ExecuteReader()
            While dr.Read()
                LeftGroupQuestions.Add(dr("QuestionID"))
                LeftGroupArithmetic = dr("Operator")
            End While
            dr.Close()

            sql = "Select QuestionID, [Operator] From GROUP_ITEMS2 as G2, [GROUP] AS G, ARITHMETIC_OPERATORS AS A WHERE G.GroupType=1 AND G2.GroupID=G.GroupID AND G.ArithmeticOperator=A.ArithmeticID AND G2.GroupID=@GroupID"
            cmd = New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@GroupID", datarow(2)))
            dr = cmd.ExecuteReader()
            While dr.Read()
                RightGroupQuestions.Add(dr("QuestionID"))
                RightGroupArithmetic = dr("Operator")
            End While
            dr.Close()

            Dim matrixTable As Table
            Dim rows As Integer
            Dim columns As Integer
            Dim opr As Integer = datarow(0)
            Dim LeftTextboxID As String = ""
            'Heading ACs
            If LeftGroupHeadings.Count <> 0 And RightGroupHeadings.Count <> 0 Then
                Dim control As Control

                matrixTable = ReportPanel.FindControl("matrixTable")
                rows = 0
                For Each row As TableRow In matrixTable.Rows
                    LeftTextboxID = ""
                    Dim LeftGroupText As New ArrayList, RightGroupText As New ArrayList, NoValidate As Boolean = True
                    Dim j As Integer = 0
                    While j < LeftGroupHeadings.Count
                        For Each cell As TableCell In row.Cells
                            For Each control In cell.Controls
                                If control.GetType().ToString() = "System.Web.UI.WebControls.TextBox" Then
                                    Dim txt As TextBox = control
                                    Dim strControlID = txt.ID
                                    Dim strArray As Array = Split(strControlID, "_")
                                    strArray = Split(strArray(1), "-")
                                    Dim strHeadingID As Integer = CInt(strArray(0))
                                    If strHeadingID = LeftGroupHeadings.Item(j) Then
                                        LeftTextboxID = txt.ID
                                        txt.ReadOnly = True
                                        txt.BackColor = Drawing.Color.DarkGray
                                        txt.Font.Bold = True
                                    End If
                                End If
                            Next
                        Next
                        j = j + 1
                    End While
                    j = 0
                    While j < RightGroupHeadings.Count
                        For Each cell As TableCell In row.Cells
                            For Each control In cell.Controls
                                If control.GetType().ToString() = "System.Web.UI.WebControls.TextBox" Then
                                    Dim txt As TextBox = control
                                    Dim strControlID = txt.ID
                                    Dim strArray As Array = Split(strControlID, "_")
                                    strArray = Split(strArray(1), "-")
                                    Dim strHeadingID As Integer = CInt(strArray(0))
                                    If strHeadingID = RightGroupHeadings.Item(j) Then
                                        If Global_Functions.GetAnswerType(CInt(strHeadingID)) = 1 Or Global_Functions.GetAnswerType(CInt(strHeadingID)) = 2 Then
                                            If txt.Text = "" Then
                                                RightGroupText.Add(0)
                                            Else
                                                RightGroupText.Add(CDbl(txt.Text))
                                            End If
                                        End If
                                    End If
                                End If
                            Next
                        Next
                        j = j + 1
                    End While

                    'total right group
                    Dim RightTotal As Double = TotalRightGroup(RightGroupText, RightGroupArithmetic)
                    TotalB(RightTotal, LeftTextboxID)
                    rows = rows + 1
                Next

                'Questions
            ElseIf LeftGroupQuestions.Count <> 0 And RightGroupQuestions.Count <> 0 Then
                Dim control As Control
                matrixTable = ReportPanel.FindControl("matrixTable")
                columns = 0
                Dim LeftItems As New ArrayList, RightItems As New ArrayList

                Dim j As Integer = 0
                While j < LeftGroupQuestions.Count
                    For Each row As TableRow In matrixTable.Rows
                        columns = 0
                        For Each cell As TableCell In row.Cells
                            For Each control In cell.Controls
                                If control.GetType().ToString() = "System.Web.UI.WebControls.TextBox" Then
                                    Dim txt As TextBox = control
                                    Dim strControlID = txt.ID
                                    Dim strArray As Array = Split(strControlID, "_")
                                    strArray = Split(strArray(1), "-")
                                    Dim QuestionID As Integer = CInt(strArray(1))
                                    If QuestionID = LeftGroupQuestions.Item(j) Then
                                        If Global_Functions.GetAnswerType(CInt(strArray(0))) = 1 Or Global_Functions.GetAnswerType(CInt(strArray(0))) = 2 Then
                                            Dim item As New ListItem
                                            item.Value = columns
                                            item.Text = txt.ID
                                            LeftItems.Add(item)
                                            txt.ReadOnly = True
                                            txt.BackColor = Drawing.Color.DarkGray
                                            txt.Font.Bold = True
                                        End If
                                    End If
                                End If
                            Next
                            columns = columns + 1
                        Next
                    Next
                    j = j + 1
                End While
                j = 0
                While j < RightGroupQuestions.Count
                    For Each row As TableRow In matrixTable.Rows
                        columns = 0
                        For Each cell As TableCell In row.Cells
                            For Each control In cell.Controls
                                If control.GetType().ToString() = "System.Web.UI.WebControls.TextBox" Then
                                    Dim txt As TextBox = control
                                    Dim strControlID = txt.ID
                                    Dim strArray As Array = Split(strControlID, "_")
                                    strArray = Split(strArray(1), "-")
                                    Dim QuestionID As Integer = CInt(strArray(1))
                                    If QuestionID = RightGroupQuestions.Item(j) Then
                                        If Global_Functions.GetAnswerType(CInt(strArray(0))) = 1 Or Global_Functions.GetAnswerType(CInt(strArray(0))) = 2 Then
                                            Dim item As New ListItem
                                            item.Value = columns
                                            item.Text = txt.Text
                                            RightItems.Add(item)
                                        End If
                                    End If
                                End If
                            Next
                            columns = columns + 1
                        Next
                    Next
                    j = j + 1
                End While

                Dim count As Integer = 1
                While count <= columns
                    Dim TextboxID As String = ""
                    Dim LeftGroupText As New ArrayList, RightGroupText As New ArrayList, NoValidate As Boolean = True
                    For Each item As ListItem In LeftItems
                        If item.Value = count Then
                            TextboxID = item.Text
                        End If
                    Next

                    For Each item As ListItem In RightItems
                        If item.Value = count Then
                            If item.Text = "" Then
                                RightGroupText.Add(0)
                            Else
                                RightGroupText.Add(CDbl(item.Text))
                            End If
                        End If
                    Next

                    Dim RightTotal As Double = TotalRightGroup(RightGroupText, RightGroupArithmetic)
                    TotalB(RightTotal, TextboxID)
                    count = count + 1
                End While
            ElseIf LeftGroupAHeadings.Count <> 0 And RightGroupAHeadings.Count <> 0 And LeftGroupAQuestions.Count <> 0 And RightGroupAQuestions.Count <> 0 Then
                Dim RightTotal As Double = TotalAdvancedRightGroup(RightGroupAHeadings, RightGroupAQuestions, RightGroupAArithmetic)
                Dim i As Integer = 0
                While i < LeftGroupAHeadings.Count
                    matrixTable = ReportPanel.FindControl("matrixTable")
                    Dim txt As TextBox = matrixTable.FindControl("txt_" & LeftGroupAHeadings(i) & "-" & LeftGroupAQuestions(i))
                    txt.ReadOnly = True
                    txt.BackColor = Drawing.Color.DarkGray
                    txt.Font.Bold = True
                    If Global_Functions.GetAnswerType(LeftGroupAHeadings(i)) = 1 Then 'decimal
                        'Null Case
                        If RightTotal.Equals(-1) Then
                            txt.Text = -1
                        Else
                            txt.Text = RightTotal.ToString(".00")
                        End If
                    Else
                        txt.Text = RightTotal
                    End If
                    If isPercentBlock(txt) Then
                        RightTotal = RightTotal * 100
                        txt.Text = RightTotal.ToString(".00") & "%"
                    End If
                    i = i + 1
                End While
            End If
        Next

        'Logic to disable TextBoxes if populated via AutoFill utility
        sql = "SELECT ToHeadingID, ToQuestionID FROM AUTO_FILL AS AF WHERE ToSectionID=@ToSectionID"
        Dim cmdAutoFill As SqlCommand = New SqlCommand(sql, conn)
        cmdAutoFill.Parameters.Add(New SqlParameter("@ToSectionID", Request.QueryString("SectionID")))
        Dim drAutoFill As SqlDataReader = cmdAutoFill.ExecuteReader
        Dim matrixTable2 As Table = ReportPanel.FindControl("matrixTable")
        Dim txtAutoFill As TextBox
        While drAutoFill.Read()
            txtAutoFill = matrixTable2.FindControl("txt_" & drAutoFill(0) & "-" & drAutoFill(1))
            If Not txtAutoFill Is Nothing Then
                txtAutoFill.ReadOnly = True
                txtAutoFill.BackColor = Drawing.Color.DarkGray
                txtAutoFill.Font.Bold = True
            End If
        End While
        drAutoFill.Close()
        Global_Functions.CloseDB(conn)
    End Sub
    '*******************************************************************************************************
    '********************************Functions/Subs used by Autocomplete************************************
    '*******************************************************************************************************

    'Method to calculate a value as specified by an Advanced Autocomplete Rule; called by AutoComplete
    Function TotalAdvancedRightGroup(ByRef RightGroupAHeadings As ArrayList, ByRef RightGroupAQuestions As ArrayList, ByRef RightGroupAArithmetic As String) As Double
        Dim total As Double = 0
        Dim i As Integer = 0
        Dim matrixTable As Table = ReportPanel.FindControl("matrixTable")
        Dim temp As Double = 0
        While (i < RightGroupAHeadings.Count)
            Dim txt As TextBox = matrixTable.FindControl("txt_" & RightGroupAHeadings(i) & "-" & RightGroupAQuestions(i))
            If Not ((Global_Functions.GetAnswerType(RightGroupAHeadings(i)) = 1 Or Global_Functions.GetAnswerType(RightGroupAHeadings(i)) = 2) And Not (txt.Text.Equals(-1) Or txt.Text Is Nothing Or txt.Text = "")) Then
                temp = 0
            Else
                temp = Convert.ToDouble(txt.Text)
            End If
            If RightGroupAArithmetic = "+" Then
                total = total + temp
            ElseIf RightGroupAArithmetic = "/" Then
                If i = 0 Then
                    total = Convert.ToDouble(txt.Text)
                    If total = 0 Then
                        Return 0
                    End If
                Else
                    If temp = 0 Then
                        Return -1
                    Else
                        total = total / temp
                    End If
                End If
            ElseIf RightGroupAArithmetic = "-" Then
                If i = 0 Then
                    total = Convert.ToDouble(txt.Text)
                Else
                    total = total - temp
                End If
            ElseIf RightGroupAArithmetic = "*" Then
                If i = 0 Then
                    total = Convert.ToDouble(txt.Text)
                    If total = 0 Then
                        Return 0
                    End If
                Else
                    total = total * temp
                    If total = 0 Then
                        Return 0
                    End If
                End If
            Else 'None
                total = temp
            End If
            i = i + 1
        End While
        Return total
    End Function

    'Method to calculate a value as specified by a Heading/Question Autocomplete Rule; Called by AutoComplete
    Sub TotalB(ByVal RightGroupTotal As Double, ByVal TextboxID As String)
        Dim matrixTable As Table = ReportPanel.FindControl("matrixTable")
        Dim currentReport As Integer = Global_Functions.getCurrentReportNum(Session("AgencyID"), Session("ReportingPeriod"), Session("Quarterly"), Session("TargetLockDate"), Session("Quarter1LockDate"), Session("Quarter2LockDate"), Session("Quarter3LockDate"), Session("Quarter4LockDate"))
        For Each row As TableRow In matrixTable.Rows
            For Each td As TableCell In row.Cells
                For Each Control As Control In td.Controls
                    If Control.GetType().ToString() = "System.Web.UI.WebControls.TextBox" Then
                        Dim txt As TextBox = CType(Control, TextBox)
                        If txt.ID = TextboxID Then
                            Dim strControlID = txt.ID
                            Dim strArray As Array = Split(strControlID, "_")
                            strArray = Split(strArray(1), "-")
                            Dim strHeadingID As Integer = CInt(strArray(0))
                            If Global_Functions.GetAnswerType(strHeadingID) = 1 Then 'decimal
                                'Null Case
                                If RightGroupTotal.Equals(-1) Then
                                    txt.Text = -1
                                Else
                                    txt.Text = RightGroupTotal.ToString(".00")
                                End If
                            Else
                                txt.Text = RightGroupTotal
                            End If
                            If isPercentBlock(txt) Then
                                RightGroupTotal = RightGroupTotal * 100
                                txt.Text = RightGroupTotal.ToString(".00") & "%"
                            End If

                            Session("ControlID") = txt.ID
                            Exit Sub
                        End If
                    End If
                Next
            Next
        Next
    End Sub

    'Method to aggregate a RightTotal if the validation rule involves aggregateion; Called by AutoCOmplete
    Function TotalRightGroup(ByRef RightGroupText As ArrayList, ByVal RightGroupArithmetic As String) As Double
        Dim RightTotal As Double = 0, i As Integer = 0
        While i < RightGroupText.Count
            If RightGroupArithmetic = "+" Then
                RightTotal = RightTotal + RightGroupText.Item(i)
            ElseIf RightGroupArithmetic = "-" Then
                If i = 0 Then
                    RightTotal = RightGroupText.Item(i)
                Else
                    If RightTotal <> 0 Then
                        RightTotal = RightTotal - RightGroupText.Item(i)
                    End If
                End If
            ElseIf RightGroupArithmetic = "/" Then
                If i = 0 Then
                    If RightGroupText.Item(i) = 0 Then
                        RightTotal = 0.0
                        Return RightTotal
                    Else
                        'If RightGroupText.Item(i) <> 0 Then
                        RightTotal = RightGroupText.Item(i)
                        'End If
                    End If
                Else
                    If i <> 0 Then
                        If RightGroupText.Item(i) <> 0 Then
                            RightTotal = RightTotal / RightGroupText.Item(i)
                        Else
                            'If RightGroupText.Item(i) = 0 Then
                            RightTotal = -1.0
                            Return RightTotal
                            'End If
                        End If
                    End If
                End If
            ElseIf RightGroupArithmetic = "*" Then
                If i = 0 Then
                    If RightGroupText.Item(i) = 0 Then
                        RightTotal = 0.0
                        Return RightTotal
                    Else
                        'If RightGroupText.Item(i) <> 0 Then
                        RightTotal = RightGroupText.Item(i)
                        'End If
                    End If
                Else
                    If i <> 0 Then
                        If RightGroupText.Item(i) <> 0 Then
                            RightTotal = RightTotal * RightGroupText.Item(i)
                        Else
                            'If RightGroupText.Item(i) = 0 Then
                            RightTotal = 0.0
                            Return RightTotal
                            'End If
                        End If
                    End If
                End If
            Else 'NONE
                If Not RightGroupText.Item(i).Equals(DBNull.Value) Then
                    RightTotal = RightGroupText.Item(i)
                End If
            End If
            i = i + 1
        End While
        Return RightTotal
    End Function

    'Method to determine if a given TextBox contains a percent; Called by AutoComplete and TotalB
    Function isPercentBlock(ByVal txt As TextBox) As Boolean
        Dim strArray As Array = Split(txt.ID, "_")
        strArray = Split(strArray(1), "-")
        Dim heID = strArray(0)
        Dim quID = strArray(1)
        If Global_Functions.GetAnswerType(heID) = 1 And Session("Quarterly") = True Then
            Return True
        Else
            Return False
        End If
    End Function            
                        </code></pre>
            </div>
            <div class="col-xs-6 col-lg-6 col-md-6" style="text-align: left; width: 50%">

                <div>
                    <h3>After Rewrite</h3>
                    <br />
                    <h4>Description: </h4>
                    <p style="margin-right: 2cm; font-size: medium">
                    </p>
                </div>

                <pre class="pre-scrollable, vbnet" style="max-height: 800px"><code class=""> 
    ''' <summary>
    ''' Auto Complete Function that uses Auto Complete Rules to total values in cells and disable them
    ''' Only is usable with Advanced Auto Complete, Migrating all other rules to this type
    ''' </summary>
    ''' <remarks>Created By Dylan Steele
    ''' 8/19/2016</remarks>
    Public Sub NewAutoComplete(ByVal SectionID As Integer)
        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString)
            Dim sql As String = ""
            conn.Open()
            'Selects all of the AutoComplete Rules for the current Section and Orders them by 
            Group Type
            sql = "select G.ArithmeticOperator, Left_Group, Right_Group, G.GroupType 
                   FROM AUTO_COMPLETE as AC inner join [GROUP] as G on 
                   G.GroupID=Right_Group where AC.SectionID=@SectionID 
                   Order by G.GroupType"
            Dim cmd As New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@SectionID", SectionID))
            Dim daACRules As New SqlDataAdapter(cmd), dsRules As New DataSet, datarow As DataRow
            daACRules.Fill(dsRules, "AC")
            For Each datarow In dsRules.Tables("AC").Rows
                Dim LeftHeadingID = 0, LeftQuestionID = 0
                Dim RightHeadingGroup As New ArrayList
                Dim RightQuestionGroup As New ArrayList


                If datarow("GroupType") = 3 Then
                    sql = "select QuestionID, HeadingID from [GROUP] as G inner join GROUP_ITEMS2 
                    as GI2 on GI2.GroupID=G.GroupID where G.GroupID=@GroupID"
                    cmd = New SqlCommand(sql, conn)
                    cmd.Parameters.Add(New SqlParameter("@GroupID", datarow("Left_Group")))
                    Dim DrLeft As SqlDataReader = cmd.ExecuteReader()
                    While DrLeft.Read()
                        LeftHeadingID = DrLeft("HeadingID")
                        LeftQuestionID = DrLeft("QuestionID")
                    End While
                    DrLeft.Close()

                    'Fills the ArrayLists for the Right Group with Question and Heading IDs
                    sql = "select QuestionID, HeadingID from [GROUP] as G 
                    inner join GROUP_ITEMS2 as GI2 on GI2.GroupID=G.GroupID 
                    where G.GroupID=@GroupID"
                    cmd = New SqlCommand(sql, conn)
                    cmd.Parameters.Add(New SqlParameter("@GroupID", datarow("Right_Group")))
                    Dim DrRight As SqlDataReader = cmd.ExecuteReader()
                    While DrRight.Read()
                        RightHeadingGroup.Add(DrRight("HeadingID"))
                        RightQuestionGroup.Add(DrRight("QuestionID"))
                    End While
                    DrRight.Close()

                    'Checks to make sure the Right Groups items each have a Question and Heading ID 
                    Dim HeadingCount As Integer = RightHeadingGroup.Count()
                    Dim QuestionCount As Integer = RightQuestionGroup.Count()
                    If HeadingCount = QuestionCount Then
                        'Finds the Table all of the controls are stored in
                        Dim matrixTable As Table = ReportTable
                        Dim TextBoxValues As New ArrayList
                        Dim txt As TextBox

                        'Loops through each item in the Array Lists of Heading and QuestionIDs 
                        to find a specific Textbox 
                        For index As Integer = 0 To (HeadingCount - 1)
                            txt = matrixTable.FindControl("txt_" & RightHeadingGroup(index) 
                                & "-" & RightQuestionGroup(index))

                            TextBoxValues.Add(txt.Text)
                        Next
                        'Calculates the Total from the ArrayList of Textbox values 
                        Dim Total As Double = CalcValues(TextBoxValues, datarow("ArithmeticOperator"))

                        'Finds the TextBox that the AutoComplete Function will Fill with Data
                        Dim DisabledTextBoxID As String = "txt_" & LeftHeadingID & "-" & LeftQuestionID
                        txt = matrixTable.FindControl(DisabledTextBoxID)
                        If Double.IsNaN(Total) Then
                            Total = 0
                        End If
                        'Checks the Answer Type to see what type of String Formating is 
                        needed for the Textbox answers
                        Dim AnswerType As Integer = 0
                        sql = "Select AnswerType FROM HEADING as H where H.HeadingID=@HeadingID"
                        cmd = New SqlCommand(sql, conn)
                        cmd.Parameters.Add(New SqlParameter("@HeadingID", LeftHeadingID))
                        Dim dr3 As SqlDataReader = cmd.ExecuteReader()
                        While dr3.Read()
                            AnswerType = dr3("AnswerType")
                        End While
                        dr3.Close()
                        'Type Percent
                        If AnswerType = 1 Then
                            txt.Text = Total.ToString("N")
                            'Type Integer
                        ElseIf AnswerType = 2 Then
                            txt.Text = Total.ToString("N0")
                        End If
                        DisableTextBox(DisabledTextBoxID)
                    Else
                        'Maybe Create Something that will hold all errors encountered 
                        'A New DB Table or a txt file that will be stored somewhere 
                        for Sys Admin Reference
                    End If
                End If
            Next
            Global_Functions.CloseDB(conn)
        End Using
    End Sub
	
	'--------------------------------------------------------------------------------------------------------------------------------------------
	'--------------------------------------------------------------------------------------------------------------------------------------------
	'--------------------------------------------------------------------------------------------------------------------------------------------
	'--------------------------------------------------------------------------------------------------------------------------------------------
	''' <summary>
    ''' Totals numbers in a list given the operater type identifer
    ''' </summary>
    ''' <param name="IntList"></param>
    ''' <param name="OperatorStr"></param>
    ''' <returns>Totaled Values of a list of Numbers </returns>
    ''' <remarks>Created By Dylan Steele
    ''' 8/19/2016</remarks>
    Public Shared Function CalcValues(ByVal IntList As ArrayList, ByVal OperatorStr As Integer) As Double
        Dim Amt As Integer = IntList.Count()
        Dim Total As Double = 0

        'Switch statment to select correct operation 
        Select Case OperatorStr
            'Not sure how to handle this Operator 
            Case 1
                For index As Integer = 0 To (Amt - 1)
                    Return -1
                Next
            Case 2
                For index As Integer = 0 To (Amt - 1)
                    Total = Total + IntList(index)
                Next
            Case 3
                For index As Integer = 0 To (Amt - 1)
                    If index = 0 Then
                        Total = IntList(index)
                    Else
                        Total = Total - IntList(index)
                    End If
                Next
            Case 4
                For index As Integer = 0 To (Amt - 1)
                    If index = 0 Then
                        Total = IntList(index)
                    Else
                        Total = Total / IntList(index)
                    End If
                Next
            Case 5
                For index As Integer = 0 To (Amt - 1)
                    If index = 0 Then
                        Total = IntList(index)
                    Else
                        Total = Total * IntList(index)
                    End If
                Next
                'if an illigal character is passed in the operator string
            Case Else
                Return -1
        End Select
        Return Total
    End Function
	
	 ''' <summary>
    ''' Disable textbox for AutoComplete
    ''' </summary>
    ''' <param name="TxtBoxID"></param>
    ''' <remarks>Created By Dylan Steele
    ''' 8/24/2016</remarks>
    Protected Sub DisableTextBox(ByVal TxtBoxID As String)
        Dim matrixTable As Table = ReportTable
        Dim txt As TextBox = matrixTable.FindControl(TxtBoxID)

        txt.BackColor = Drawing.Color.DarkGray
        txt.ForeColor = Drawing.Color.Black
        txt.ReadOnly = True
        txt.Font.Bold = True

    End Sub
	



                        </code></pre>
            </div>
        </div>
        <br />
        <br />
        <br />
        <br />
        <div style="text-align: center">
            <h2>Validate Answers Function</h2>
            <p style="font-size: medium; text-align: center">
                
            </p>
        <div class="row">
            <div class="col-xs-6 col-lg-6 col-md-6" style="text-align: left; width: 50%">
                <div>
                    <h3>Before Rewrite</h3>
                    <br />
                    <h4>Description: </h4>
                    <p style="margin-right: 2cm; font-size: medium">
                    </p>
                </div>
                <pre class="pre-scrollable, vbnet" style="max-height: 800px"><code>
'Method to check if report data violates any validation rules; called by Page_Load, btnSubmit_Click, and btnCompleteSection_Click
    Function ValidateAnswers(ByVal SectionID As Integer) As Boolean
        'This type of validation only needs to be performed on matrix sections
        If Global_Functions.GetSectionType(SectionID) <> 1 Then 'not a matrix section
            Return True
        End If
        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString), sql As String = ""
        conn.Open()
        Dim matrixTable As Table = ReportPanel.FindControl("matrixTable")
        Dim currentReportNum As Integer = Global_Functions.getCurrentReportNum(Session("AgencyID"), Session("ReportingPeriod"), Session("Quarterly"), Session("TargetLockDate"), Session("Quarter1LockDate"), Session("Quarter2LockDate"), Session("Quarter3LockDate"), Session("Quarter4LockDate"))

        'Reset formatting
        If Session("Quarterly") Then
            For Each row As TableRow In matrixTable.Rows
                For Each cell As TableCell In row.Cells
                    For Each control In cell.Controls
                        If control.GetType().ToString() = "System.Web.UI.WebControls.TextBox" Or control.GetType().ToString() = "System.Web.UI.WebControls.DropDownList" Then
                            'Reset background color of TextBoxes and DropDownLists to white
                            Global_Functions.ApplyControlFormatting(control, SectionID, Session("AgencyID"), False, False, Session("ReportingPeriod"), currentReportNum)
                            If control.GetType().ToString() = "System.Web.UI.WebControls.TextBox" Then
                                Dim txt As TextBox = control
                                If (Not txt.ReadOnly And txt.Text = "") Then
                                    Dim strControlID = txt.ID
                                    Dim strArray As Array = Split(strControlID, "_")
                                    strArray = Split(strArray(1), "-")
                                    Dim heID = strArray(0)
                                    Dim quID = strArray(1)
                                    If Global_Functions.GetAnswerType(heID) = 1 Or Global_Functions.GetAnswerType(heID) = 2 Then
                                        txt.Text = "0"
                                    End If
                                End If
                            End If
                        End If
                    Next
                Next
            Next
        End If

        Dim invalidIDs As String = ""
        Dim valid As Boolean

        'Select all validation rules from the database for the current section
        sql = "Select Operator, Left_Group, Right_Group, ErrorMessage, ValidatorID From VALIDATOR Where SectionID=@SectionID"
        Dim cmd As SqlCommand = New SqlCommand(sql, conn)
        cmd.Parameters.Add(New SqlParameter("@SectionID", SectionID))
        Dim daV As New SqlDataAdapter(cmd), dsV As New DataSet
        daV.Fill(dsV, "Validators")
        For Each datarowV As DataRow In dsV.Tables("Validators").Rows
            Dim opr As Integer = datarowV(0)
            Dim LeftGroupID As Integer = datarowV(1)
            Dim RightGroupID As Integer = datarowV(2)
            Dim ErrorMessage As String = datarowV(3).ToString()
            Dim validatorID As Integer = CInt(datarowV(4))
            Dim noValidate As Boolean = False

            sql = "SELECT ID, GroupType, QuestionID, HeadingID FROM [GROUP] AS G INNER JOIN GROUP_ITEMS2 AS GI2 ON " & _
            "G.GroupID=GI2.GroupID WHERE G.GroupID=@GroupID"
            cmd = New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@GroupID", LeftGroupID))
            Dim daG As New SqlDataAdapter(cmd), dsG As New DataSet
            daG.Fill(dsG, "Group")
            For Each datarowG As DataRow In dsG.Tables("Group").Rows
                Dim groupType As Integer = datarowG(1)
                If groupType = 1 Then           'Questions
                    Dim leftQuestionID As Integer = datarowG(2)
                    Dim leftHeadingID As Integer
                    sql = "SELECT TOP 1 HeadingID FROM ANSWER WHERE QuestionID=@QuestionID"
                    cmd = New SqlCommand(sql, conn)
                    cmd.Parameters.Add(New SqlParameter("@QuestionID", leftQuestionID))
                    Dim drLeft As SqlDataReader = cmd.ExecuteReader()
                    While drLeft.Read()
                        leftHeadingID = drLeft("HeadingID")
                    End While
                    drLeft.Close()
                    If Global_Functions.getQuestionType(leftHeadingID) = currentReportNum Then
                        Dim txtLeftValue As TextBox = matrixTable.FindControl("txt_" & leftHeadingID & "-" & leftQuestionID)
                        Dim LeftValue As Integer
                        If txtLeftValue.Text = "" Then
                            LeftValue = 0
                        Else
                            LeftValue = CInt(txtLeftValue.Text)
                        End If
                        sql = "SELECT DISTINCT A.QuestionID, A.HeadingID, ArithmeticOperator FROM [GROUP] AS G INNER JOIN GROUP_ITEMS2 AS GI2 ON " & _
                        "G.GroupID=GI2.GroupID INNER JOIN ANSWER AS A ON GI2.QuestionID=A.QuestionID WHERE G.GroupID=@GroupID"
                        cmd = New SqlCommand(sql, conn)
                        cmd.Parameters.Add(New SqlParameter("@GroupID", RightGroupID))
                        Dim daH As New SqlDataAdapter(cmd), dsH As New DataSet
                        daH.Fill(dsH, "Heading")
                        Dim RightTotal As Integer = 0
                        Dim txtRightValue As New TextBox
                        For Each datarowH As DataRow In dsH.Tables("Heading").Rows
                            Dim rightQuestionID As Integer = datarowH(0)
                            Dim rightHeadingID As Integer = datarowH(1)
                            Dim arithmeticOperator As Integer = datarowH(2)
                            Dim RightValue As Integer
                            Try
                                txtRightValue = matrixTable.FindControl("txt_" & rightHeadingID & "-" & rightQuestionID)
                                RightValue = CInt(txtRightValue.Text)
                            Catch ex As Exception
                                RightValue = CInt(GetAnswerFromDB(rightHeadingID, rightQuestionID))
                            End Try
                            If arithmeticOperator = 1 Then
                                RightTotal = RightValue
                            ElseIf arithmeticOperator = 2 Then
                                RightTotal = RightTotal + RightValue
                            ElseIf arithmeticOperator = 3 Then
                                'NO CASES CURRENTLY - LOGIC MAY NEED ADDED LATER
                            ElseIf arithmeticOperator = 4 Then
                                'NO CASES CURRENTLY - LOGIC MAY NEED ADDED LATER
                            ElseIf arithmeticOperator = 5 Then
                                'NO CASES CURRENTLY - LOGIC MAY NEED ADDED LATER
                            End If
                        Next
                        valid = CompareValues(LeftValue, RightTotal, opr)
                        If Not valid And Session("FirstView") = False Then
                            invalidIDs &= validatorID.ToString() & ","
                            txtLeftValue.BackColor = Drawing.Color.Red
                            txtLeftValue.ForeColor = Drawing.Color.White
                            txtLeftValue.Font.Bold = True
                            If Not txtRightValue Is Nothing AndAlso txtRightValue.Text <> "" Then
                                txtRightValue.BackColor = Drawing.Color.Red
                                txtRightValue.ForeColor = Drawing.Color.White
                                txtRightValue.Font.Bold = True
                            End If
                        End If
                    End If
                ElseIf groupType = 2 Then       'Headings
                    Dim leftHeadingID As Integer = datarowG(3)
                    If Global_Functions.getQuestionType(leftHeadingID) = currentReportNum Then
                        sql = "SELECT HeadingID FROM GROUP_ITEMS2 WHERE GroupID=@GroupID"
                        cmd = New SqlCommand(sql, conn)
                        cmd.Parameters.Add(New SqlParameter("@GroupID", RightGroupID))
                        Dim rightHeadingID As Integer
                        Dim drRight As SqlDataReader = cmd.ExecuteReader
                        While drRight.Read()
                            rightHeadingID = drRight("HeadingID")
                        End While
                        drRight.Close()

                        sql = "SELECT QuestionID FROM QUESTION WHERE SectionID=@SectionID"
                        cmd = New SqlCommand(sql, conn)
                        cmd.Parameters.Add(New SqlParameter("@SectionID", SectionID))
                        'cmd.Parameters.Add(New SqlParameter("@AgencyID", Session("AgencyID")))
                        Dim daQ As New SqlDataAdapter(cmd), dsQ As New DataSet
                        daQ.Fill(dsQ, "Question")
                        For Each datarowQ As DataRow In dsQ.Tables("Question").Rows
                            Dim questionID As Integer = datarowQ(0)
                            If Not Global_Functions.CheckQuestionDisabled(SectionID, questionID) Then
                                Dim txtLeftValue As TextBox = matrixTable.FindControl("txt_" & leftHeadingID & "-" & questionID)
                                If Not txtLeftValue Is Nothing Then
                                    Dim txtRightValue As New TextBox
                                    Dim LeftValue As Integer
                                    If txtLeftValue.Text = "" Then
                                        LeftValue = 0
                                    Else
                                        LeftValue = CInt(txtLeftValue.Text)
                                    End If

                                    Dim RightValue As Integer
                                    Try
                                        txtRightValue = matrixTable.FindControl("txt_" & rightHeadingID & "-" & questionID)
                                        RightValue = CInt(txtRightValue.Text)
                                    Catch ex As Exception
                                        RightValue = CInt(GetAnswerFromDB(rightHeadingID, questionID))
                                    End Try
                                    valid = CompareValues(LeftValue, RightValue, opr)

                                    If Not valid And Session("FirstView") = False Then
                                        invalidIDs &= validatorID.ToString() & ","
                                        txtLeftValue.BackColor = Drawing.Color.Red
                                        txtLeftValue.ForeColor = Drawing.Color.White
                                        txtLeftValue.Font.Bold = True
                                        If txtRightValue.Text <> "" Then
                                            txtRightValue.BackColor = Drawing.Color.Red
                                            txtRightValue.ForeColor = Drawing.Color.White
                                            txtRightValue.Font.Bold = True
                                        End If
                                    End If
                                End If
                            End If
                        Next
                    End If
                ElseIf groupType = 3 Then           'Advanced
                    Dim leftQuestionID As Integer = datarowG(2)
                    Dim leftHeadingID As Integer = datarowG(3)
                    If Global_Functions.getQuestionType(leftHeadingID) = currentReportNum Then
                        Dim txtLeftValue As TextBox = matrixTable.FindControl("txt_" & leftHeadingID & "-" & leftQuestionID)
                        Dim LeftValue = CInt(txtLeftValue.Text)
                        sql = "SELECT HeadingID, QuestionID, ArithmeticOperator FROM GROUP_ITEMS2 AS GI INNER JOIN [GROUP] AS G ON G.GroupID=GI.GroupID WHERE G.GroupID=@GroupID"
                        cmd = New SqlCommand(sql, conn)
                        cmd.Parameters.Add(New SqlParameter("@GroupID", RightGroupID))
                        Dim rightHeadingID As Integer
                        Dim rightQuestionID As Integer
                        Dim drRight As SqlDataReader = cmd.ExecuteReader
                        Dim RightTotal As Integer
                        While drRight.Read()
                            rightHeadingID = drRight("HeadingID")
                            rightQuestionID = drRight("QuestionID")
                            Dim arithmeticOperator As Integer = drRight("ArithmeticOperator")
                            Dim RightValue As Integer
                            Try
                                Dim txtRightValue As TextBox = matrixTable.FindControl("txt_" & rightHeadingID & "-" & rightQuestionID)
                                RightValue = CInt(txtRightValue.Text)
                            Catch ex As Exception
                                RightValue = CInt(GetAnswerFromDB(rightHeadingID, rightQuestionID))
                            End Try
                            If arithmeticOperator = 1 Then
                                RightTotal = RightValue
                            ElseIf arithmeticOperator = 2 Then
                                RightTotal = RightTotal + RightValue
                            ElseIf arithmeticOperator = 3 Then
                                'NO CASES CURRENTLY - LOGIC MAY NEED ADDED LATER
                            ElseIf arithmeticOperator = 4 Then
                                'NO CASES CURRENTLY - LOGIC MAY NEED ADDED LATER
                            ElseIf arithmeticOperator = 5 Then
                                'NO CASES CURRENTLY - LOGIC MAY NEED ADDED LATER
                            End If
                        End While
                        drRight.Close()
                        valid = CompareValues(LeftValue, RightTotal, opr)
                        If Not valid And Session("FirstView") = False Then
                            invalidIDs &= validatorID.ToString() & ","
                            txtLeftValue.BackColor = Drawing.Color.Red
                            txtLeftValue.ForeColor = Drawing.Color.White
                            txtLeftValue.Font.Bold = True
                        End If
                    End If
                End If
            Next
        Next


        '********************This logic needs reviewed: KWM 4/3/2015**************************************************
        'Logic for validation of fields that use CFDA#'s
        'Rows with CFDA #'s must be totally filled out or totally empty
        'This logic will only apply to section F of the report this section also
        'Contains the logic to validate AI fields.
        'Array used for temporarly storing control IDs to be passed to the red block function
        Dim ControlArray As New ArrayList
        Dim qNos As New ArrayList()
        Dim headings As New ArrayList()
        Dim ht As New Hashtable()
        'Array used for storing all previously encountered CFDA#s. This is for insuring CFDA#s are used only once
        Dim usedCFDA As New ArrayList
        'Arrays used for storing values needed to validate an AI when text is present in the description.
        Dim blankAIDesc As New ArrayList
        Dim blankAIDescID As New ArrayList
        'Counters for validation messages
        Dim qs As Integer = 1
        Dim cc As Integer = 0
        For Each row As TableRow In matrixTable.Rows
            For Each cell As TableCell In row.Cells
                For Each control In cell.Controls
                    If control.GetType().ToString() = "System.Web.UI.WebControls.TextBox" Or control.GetType().ToString() = "System.Web.UI.WebControls.DropDownList" Then
                        Dim txt As New TextBox
                        If control.GetType().ToString() = "System.Web.UI.WebControls.DropDownList" Then
                            Dim ddl As DropDownList = control
                            txt.Text = ddl.SelectedValue
                            txt.ID = ddl.ID
                            txt.ReadOnly = Not ddl.Enabled
                        Else
                            txt = control
                        End If
                        Dim strControlID = txt.ID
                        Dim strArray As Array = Split(strControlID, "_")
                        strArray = Split(strArray(1), "-")
                        Dim QuestionID As Integer = CInt(strArray(1))
                        If qNos.Contains("n" + strArray(1)) Then
                            If Not headings.Contains(strArray(0)) Then
                                If (Not txt.Text = "") AndAlso (Not Convert.ToDecimal(txt.Text.Replace("%", "")) = 0) Then
                                    'Final check for validation if it makes it here then it has nothing in cfda and something in value text box
                                    valid = False
                                    'Validation message for CFDA# field with no CFDA#
                                    AddCFDAError("Cannot report CFDA# values without a description", valid, strArray(1))
                                    ControlArray.Add(txt.ID)
                                    invalidIDs = invalidIDs & "CFDA1,"
                                    Global_Functions.AddRedBlockWarning("Cannot report CFDA# values without a description", ControlArray, ReportPanel)
                                    ControlArray.Clear()
                                End If
                            End If
                        ElseIf qNos.Contains("t" + strArray(1)) Then
                            If Not headings.Contains(strArray(0)) Then
                                If txt.Text = "" OrElse Convert.ToDecimal(txt.Text.Replace("%", "")) = 0 Then
                                    'Final check for validation if it makes it here then it has nothing in cfda and something in value text box
                                    valid = False
                                    'Validation message for CFDA# field with no value
                                    AddCFDAError("Cannot report a CFDA# description without values", valid, strArray(1))
                                    ControlArray.Add(txt.ID)
                                    invalidIDs = invalidIDs & "CFDA2,"
                                    Global_Functions.AddRedBlockWarning("Cannot report a CFDA# description without values", ControlArray, ReportPanel)
                                    ControlArray.Clear()
                                End If
                            End If
                        ElseIf qNos.Contains("5" + strArray(1)) And (Not Global_Functions.CheckDisabled(strArray(0), strArray(1))) Then
                            If (Not txt.Text = "") AndAlso (Not Convert.ToDecimal(txt.Text.Replace("%", "")) = 0) Then
                                qNos.Remove("5" + strArray(1))
                                valid = False
                                AddErrorAI("Cannot report Additional Indicator values without a description", valid, cc)
                                invalidIDs = invalidIDs & "AI,"
                                ControlArray.Add(txt.ID)
                                Global_Functions.AddRedBlockWarning("Cannot report Additional Indicator values without a description", ControlArray, ReportPanel)
                                ControlArray.Clear()
                            End If
                        ElseIf qNos.Contains("1" + strArray(1)) And (Not Global_Functions.CheckDisabled(strArray(0), strArray(1))) Then
                            'If an AI has a description, the for the first text box found with the same question id and a non-0 value
                            'change that hashtable bool value to true
                            If (Not txt.Text = "") AndAlso (Not Convert.ToDecimal(txt.Text.Replace("%", "")) = 0) Then
                                qNos.Remove("1" + strArray(1))
                                'ht(strArray(1) & "-" & qs) = True
                                Dim intIndex As Integer = blankAIDesc.IndexOf(strArray(1))
                                blankAIDesc.RemoveAt(intIndex)
                                blankAIDescID.RemoveAt(intIndex)
                            End If
                        End If
                        'CFDA# Fields
                        If Global_Functions.CheckCFDABalloon(strArray(0)) Then
                            If txt.Text = "" Then
                                'If the text field has no text append n
                                qNos.Add("n" + strArray(1))
                                headings.Add(strArray(0))
                            Else
                                'If the text field has text
                                If usedCFDA.Contains(txt.Text) Then
                                    valid = False
                                    'Validation message for CFDA# that has been used more than once
                                    AddCFDAError("Cannot report a CFDA# description more than once", valid, strArray(1))
                                    ControlArray.Add(txt.ID)
                                    invalidIDs = invalidIDs & "CFDA,"
                                    Global_Functions.AddRedBlockWarning("Cannot report a CFDA# description more than once", ControlArray, ReportPanel)
                                    ControlArray.Clear()
                                Else
                                    qNos.Add("t" + strArray(1))
                                    headings.Add(strArray(0))
                                    usedCFDA.Add(txt.Text)
                                End If
                            End If
                        Else
                            sql = "SELECT QuestionType, AnswerType from HEADING WHERE HeadingID=@HeadingID"
                            Dim cmd2 As SqlCommand = New SqlCommand(sql, conn)
                            cmd2.Parameters.Add(New SqlParameter("@HeadingID", strArray(0)))
                            Dim dr2 As SqlDataReader = cmd2.ExecuteReader
                            Dim qtype As Integer = 0
                            Dim atype As Integer = 0
                            While (dr2.Read)
                                qtype = dr2("QuestionType")
                                atype = dr2("AnswerType")
                            End While
                            'AI fields and Other State Resouces
                            If qtype = 5 Then
                                If txt.Text = "" Then
                                    'if the text field has no text append 5
                                    qNos.Add("5" + strArray(1))
                                    headings.Add(strArray(0))
                                Else
                                    'if the text field has text append 1
                                    'Added each AI question number that has text in the description to a hash table with a bool
                                    'the bool is the current validation status of the AI row. this value is changed later to be true if
                                    'the AI field has any non-0 values. Also the qs is included in the key value to be used with the error message
                                    'ht.Add(strArray(1) & "-" & qs, False)
                                    blankAIDesc.Add(strArray(1))
                                    blankAIDescID.Add(strControlID & "*" & qs)
                                    qNos.Add("1" + strArray(1))
                                    headings.Add(strArray(0))
                                End If
                                qs = qs + 1
                                If atype = 3 Then
                                    cc = cc + 1
                                End If
                            End If
                            dr2.Close()
                        End If
                    End If
                Next
            Next
        Next
        If blankAIDesc.Count > 0 Then
            For i As Integer = 0 To blankAIDesc.Count - 1 Step 1
                valid = False
                invalidIDs = invalidIDs & "AI,"
                AddErrorAI("Cannot report an Additional Indicator description without values", valid, Convert.ToInt32(blankAIDescID(i).ToString().Substring(blankAIDescID(i).ToString().IndexOf("*") + 1)))
                If i < blankAIDescID.Count Then
                    ControlArray.Add(blankAIDescID(i).ToString().Substring(0, blankAIDescID(i).ToString().IndexOf("*")))
                    Global_Functions.AddRedBlockWarning("Cannot report an Additional Indicator description without values", ControlArray, ReportPanel)
                    ControlArray.Clear()
                End If
            Next
        End If

        Dim ltr As New Literal
        ltr.Text = "<br/><br/>"
        pnlValidation.Controls.Add(ltr)

        Dim invalid As Boolean = False
        If invalidIDs <> "" And Session("FirstView") = False Then
            Dim subStr = invalidIDs.Substring(0, invalidIDs.Length - 1)
            txtInvalidID.Text = invalidIDs
            Dim pnlInner As Panel = OuterPanel.FindControl("ShowMessagePopupPanel")
            Dim lblMessage As Label = pnlInner.FindControl("lblPopup")
            lblMessage.Text = invalidIDs
            Dim IDs As String() = invalidIDs.Split(New String() {","}, StringSplitOptions.None)
            Dim AIMessage As Boolean = False
            Dim CFDAMessage As Boolean = False
            Dim CFDA1Message As Boolean = False
            Dim CFDA2Message As Boolean = False
            Dim amt As Integer = 0
            Dim temp As Integer = 0
            Dim chkID As String = ""
            For Each ID As String In IDs
                If ID = "AI" Then
                    If Not AIMessage Then
                        Dim lblAI As New Label()
                        lblAI.Text = "Additional Indicators must include both a description and values."
                        pnlBottom2.Controls.Add(lblAI)
                        pnlBottom2.Controls.Add(New LiteralControl("<hr/>"))
                        AIMessage = True
                    End If
                ElseIf ID = "CFDA" Then
                    If Not CFDAMessage Then
                        Dim lblCFDA As New Label()
                        lblCFDA.Text = "Cannot report a CFDA# description more than once."
                        pnlBottom2.Controls.Add(lblCFDA)
                        pnlBottom2.Controls.Add(New LiteralControl("<hr/>"))
                        CFDAMessage = True
                    End If
                ElseIf ID = "CFDA1" Then
                    If Not CFDA1Message Then
                        Dim lblCFDA1 As New Label()
                        lblCFDA1.Text = "CFDA fields must include both a CFDA number and dollar amount."
                        pnlBottom2.Controls.Add(lblCFDA1)
                        pnlBottom2.Controls.Add(New LiteralControl("<hr/>"))
                        CFDA1Message = True
                    End If
                ElseIf ID = "CFDA2" Then
                    If Not CFDA2Message Then
                        Dim lblCFDA2 As New Label()
                        lblCFDA2.Text = "CFDA fields must include both a CFDA number and dollar amount."
                        pnlBottom2.Controls.Add(lblCFDA2)
                        pnlBottom2.Controls.Add(New LiteralControl("<hr/>"))
                        CFDA2Message = True
                    End If
                ElseIf Not (chkID.Contains(ID & ",") Or ID = "") Then
                    chkID &= ID & ","
                    sql = "SELECT Left_Group, Right_Group, Operator, ErrorMessage FROM VALIDATOR WHERE ValidatorID=@ValidatorID"
                    cmd = New SqlCommand(sql, conn)
                    cmd.Parameters.Add(New SqlParameter("@ValidatorID", CInt(ID)))
                    Dim da As New SqlDataAdapter(cmd), ds As New DataSet, datarow As DataRow
                    da.Fill(ds, "Validators")
                    For Each datarow In ds.Tables("Validators").Rows
                        Dim lblError As New Label()
                        lblError.Text = datarow("ErrorMessage")
                        pnlBottom2.Controls.Add(lblError)
                        pnlBottom2.Controls.Add(New LiteralControl("<hr/>"))
                    Next
                End If
            Next
            Dim lblBottom As New Label()
            If Session("TargetYellowBlockErrors") > 0 Or Session("YearToYearYellowBlockErrors") > 0 Or Session("OtherResoucesErrors") > 0 Then
                pnlBottom2.Controls.Add(New LiteralControl("<font color=""red"">Red ""Notes"" or ""YTY Notes"" links require an explanation.</font><hr/>"))
            End If
            lblBottom.Text = "<html><div align='left' Style='font-size:12pt'>" + "Your changes have been saved, but the report cannot be submitted with invalid data.<br/>Fields with a red background indicate invalid data." + "</div></html>"
            lblBottom.ForeColor = Drawing.Color.Red
            pnlBottom2.Controls.Add(lblBottom)
            sql = "SELECT Sname from SECTION where SectionID=@SectionID"
            cmd = New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@SectionID", Request.QueryString("SectionID")))
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                Dim Name As String = dr("SName").ToString()
                Title2.Text = Name
            End While
            dr.Close()
            mpeShowMessage.Show()
            invalid = True
        End If
        Global_Functions.CloseDB(conn)
        Return Not invalid
    End Function

'*******************************************************************************************************
'******************************Functions/Subs used by Validate Answers**********************************
'*******************************************************************************************************

    'Method to compare two values using an arithmetic operator; called by ValidateAnswers
    Function CompareValues(ByVal LeftValue As Integer, ByVal RightValue As Integer, ByVal opr As Integer) As Boolean
        Dim valid As Boolean = True
        If opr = 1 Then '<
            If LeftValue >= RightValue Then
                valid = False
            End If
        ElseIf opr = 2 Then '>
            If LeftValue <= RightValue Then
                valid = False
            End If
        ElseIf opr = 3 Then '=
            If LeftValue <> RightValue Then
                valid = False
            End If
        ElseIf opr = 4 Then '<=
            If LeftValue > RightValue Then
                valid = False
            End If
        ElseIf opr = 5 Then '>=
            If LeftValue < RightValue Then
                valid = False
            End If
        End If
        Return valid
    End Function

    'This method is used to look up values from other Sections during validation; called by ValidateAnswers
    Function GetAnswerFromDB(ByVal HeadingID As String, QuestionID As String) As String
        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString), sql As String = ""
        conn.Open()
        Dim cmd As SqlCommand
        sql = "SELECT TypeDec, TypeInt, TypeVarChar FROM ANSWER WHERE HeadingID=@HeadingID AND QuestionID=@QuestionID AND AgencyID=@AgencyID AND ReportID=@ReportID"
        cmd = New SqlCommand(sql, conn)
        cmd.Parameters.Add(New SqlParameter("@HeadingID", HeadingID))
        cmd.Parameters.Add(New SqlParameter("@QuestionID", QuestionID))
        cmd.Parameters.Add(New SqlParameter("@AgencyID", Session("AgencyID")))
        cmd.Parameters.Add(New SqlParameter("@ReportID", Session("ReportingPeriod")))
        Dim dr As SqlDataReader = cmd.ExecuteReader
        Dim aType As Integer = Global_Functions.GetAnswerType(HeadingID)
        If dr.Read() Then
            Dim ans As String
            If aType = 3 Then
                ans = dr(2).ToString()
                Global_Functions.CloseDB(conn)
                Return ans
            Else
                If dr(0).Equals(DBNull.Value) Then
                    ans = dr(1).ToString()
                    Global_Functions.CloseDB(conn)
                    Return ans
                Else
                    ans = dr(0).ToString()
                    Global_Functions.CloseDB(conn)
                    Return ans
                End If
            End If
        Else
            If aType = 3 Then
                Global_Functions.CloseDB(conn)
                Return ""
            Else
                Global_Functions.CloseDB(conn)
                Return "0"
            End If
        End If
    End Function

    'Method to handle CFDA# Error messages; called by ValidateAnswers
    Sub AddCFDAError(ByVal ErrorMessage As String, ByRef valid As Boolean, ByVal QuestionID As Integer)
        Dim ltr As New Literal
        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString)
        conn.Open()
        Dim sql As String = "SELECT QText FROM QUESTION WHERE QuestionID=@QuestionID"
        Dim cmd As New SqlCommand(sql, conn)
        cmd.Parameters.Add(New SqlParameter("@QuestionID", QuestionID))
        Dim dr As SqlDataReader = cmd.ExecuteReader
        While (dr.Read)
            ltr.Text = ErrorMessage & " -- Error: " & Global_Functions.stripHTML(dr("QText")) & "<br/>"
        End While
        dr.Close()
        pnlValidation.Controls.Add(ltr)
        pnlValidation.Visible = True
        lblSaved.Visible = True
        lblSaved.ForeColor = Drawing.Color.Red

        valid = False
        Global_Functions.CloseDB(conn)
    End Sub

    'Method to handle Additional Indicator error messages; called ValidateAnswers
    Sub AddErrorAI(ByVal ErrorMessage As String, ByRef valid As Boolean, ByVal counter As Integer)
        Dim ltr As New Literal
        ltr.Text = ErrorMessage & " -- Error: Additional Indicator " & counter & "<br/>"
        pnlValidation.Controls.Add(ltr)
        pnlValidation.Visible = True
        'lblSaved.Visible = True
        'lblSaved.Text = "Your changes have NOT been saved."
        'lblSaved.ForeColor = Drawing.Color.Red

        valid = False
    End Sub
                    </code></pre>
                </div>

            <div class="col-xs-6 col-lg-6 col-md-6" style="text-align: left; width: 50%">
                <div>
                    <h3>After Rewrite</h3>
                    <br />
                    <h4>Description: </h4>
                    <p style="margin-right: 2cm; font-size: medium">
                    </p>
                </div>
                <pre class="pre-scrollable, vbnet" style="max-height: 800px"><code>
''' <summary>
    ''' Validates The Entire Section using the Validation Rules in the DataBase
    ''' Currently works with Heading and Advanced Rules
    ''' Additional Indicator can not be used in the rules
    ''' </summary>
    ''' <param name="SectionID"></param>
    ''' <remarks>Created By Dylan Steele
    ''' 8/25/2016</remarks>
    Public Function NewValidateAnswers(ByVal SectionID As Integer) As Boolean
        Dim ReturnVal As Boolean = True
        Dim TextBoxID As String, TextBoxIDRight As String, TextBoxIDLeft As String
        Dim RightTextBoxID As New ArrayList
        Dim ErrorList As New ArrayList
        'Checks if the Sections is a Matrix Table or Not
        If Global_Functions.GetSectionType(SectionID) <> 1 Then

        Else
            Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString)
                Dim sql As String = ""
                conn.Open()

                Dim matrixTable As Table = ReportTable

                'Gets the dataTable of NON-Disabled cells 
                Dim Questions As New DataTable
                Questions = SQL_Functions.GetNonDisabledCells(SectionID, False)
                'Resets all of the Textboxes formatting 
                'For Each row As DataRow In Questions.Rows
                '    TextBoxID = "txt_" & row("HeadingID") & "-" & row("QuestionID")
                '    Try
                '        ResetTextBox(TextBoxID)
                '    Catch ex As Exception

                '    End Try
                'Next

                'Selects all of the validation rules from the Database
                sql = "select V.Operator, G.ArithmeticOperator, Left_Group, Right_Group, ErrorMessage, GroupType FROM VALIDATOR as V inner join [GROUP] as G on G.GroupID=Right_Group where SectionID=@SectionID Order by G.GroupType"
                Dim cmd As SqlCommand = New SqlCommand(sql, conn)
                cmd.Parameters.Add(New SqlParameter("@SectionID", SectionID))
                Dim daV As New SqlDataAdapter(cmd), dsV As New DataSet
                daV.Fill(dsV, "Validators")

                'Loops through each validation rule for the Section
                For Each row As DataRow In dsV.Tables("Validators").Rows
                    'Questions

                    Dim RightGroupOperatorVal As Integer = row("ArithmeticOperator")
                    Dim CompareOperator As Integer = row("Operator")
                    Dim ErrorString As String = row("ErrorMessage")

                    'Left should only have 1 Row since it is the Totaled Side
                    Dim Leftds As DataSet = getGroup(row("Left_Group"))
                    'Right can have more than 1 Row since it is the to be totaled side
                    Dim Rightds As DataSet = getGroup(row("Right_Group"))

                    If row("GroupType") = 1 Then
                        '------------------------------------------------------------------------------------------------------------------
                        '--------------------------------------------Question--------------------------------------------------------------
                        '------------------------------------------------------------------------------------------------------------------

                    ElseIf row("GroupType") = 2 Then
                        '------------------------------------------------------------------------------------------------------------------
                        '--------------------------------------------Heading---------------------------------------------------------------
                        '------------------------------------------------------------------------------------------------------------------
                        'Loop For Questions
                        For Each Drow As DataRow In Questions.Rows()
                            'Gets TextBoxID for the Left TextBox
                            TextBoxIDLeft = "txt_" & Leftds.Tables("Group").Rows(0).Item("HeadingID") & "-" & Drow("QuestionID")
                            Dim RightValueArray As New ArrayList

                            'Loop for Right Group Totaling if needed
                            For Each DataRow As DataRow In Rightds.Tables("Group").Rows
                                TextBoxIDRight = "txt_" & DataRow("HeadingID") & "-" & Drow("QuestionID")
                                'Creates ArrayList of TextBox Values and adds them to the ArrayList
                                If GetTextBoxInfo(TextBoxIDRight) = -1 Then
                                    'For error Checking if needed 
                                    ErrorList.Add(TextBoxIDRight)
                                Else
                                    RightValueArray.Add(GetTextBoxInfo(TextBoxIDRight))
                                End If
                            Next
                            'Gets Totals and Compares them 
                            Dim RightTotal As Double = CalcValues(RightValueArray, RightGroupOperatorVal)
                            Dim LeftTotal As Double = GetTextBoxInfo(TextBoxIDLeft)
                            Dim Compare As Boolean = CheckComparison(LeftTotal, RightTotal, CompareOperator)
                            If Compare = False Then
                                'Sets the TextBox to Invalid 
                                'Try Is here for Heading Rules incase it encourters a disabled cell
                                Try
                                    InvalidAnswer(ErrorString, TextBoxIDLeft)
                                    ReturnVal = False
                                Catch ex As Exception
                                End Try

                            End If
                        Next
                    ElseIf row("GroupType") = 3 Then
                        '------------------------------------------------------------------------------------------------------------------
                        '--------------------------------------------Andvanced-------------------------------------------------------------
                        '------------------------------------------------------------------------------------------------------------------
                        TextBoxIDLeft = "txt_" & Leftds.Tables("Group").Rows(0).Item("HeadingID") & "-" & Leftds.Tables("Group").Rows(0).Item("QuestionID")
                        Dim RightTotalArray As New ArrayList
                        'Gets all of the Values from the Right Group Textboxes and puts them into an ArrayList
                        For Each Datarow As DataRow In Rightds.Tables("Group").Rows
                            TextBoxIDRight = "txt_" & Datarow("HeadingID") & "-" & Datarow("QuestionID")

                            RightTotalArray.Add(GetTextBoxInfo(TextBoxIDRight))
                        Next
                        'Totals all the values and compares them to each other
                        Dim RightTotal As Double = CalcValues(RightTotalArray, RightGroupOperatorVal)
                        Dim LeftTotal As Double = GetTextBoxInfo(TextBoxIDLeft)
                        Dim compare As Boolean = CheckComparison(LeftTotal, RightTotal, CompareOperator)
                        If compare = False Then
                            'Sets the TextBox to Invalid 
                            InvalidAnswer(ErrorString, TextBoxIDLeft)
                            ReturnVal = False
                        End If
                    End If
                Next
                Dim test As String = ""
                If CFDAValidator(SectionID) = False Then
                    ReturnVal = False
                End If
                Global_Functions.CloseDB(conn)
            End Using
        End If
        Return ReturnVal
    End Function
    ''' <summary>
    ''' Does Validation Checks for Additional Indicators and CFDA Cells
    ''' This Method is called by NewValidateAnswers 
    ''' </summary>
    ''' <param name="SectionID"></param>
    ''' <remarks>Created By Dylan Steele
    ''' 8/25/2016</remarks>
    Protected Function CFDAValidator(ByVal SectionID As Integer) As Boolean
        '------------------------------------------------------------------------------------------------------------------
        '------------------------------------------CFDA Cells--------------------------------------------------------------
        '------------------------------------------------------------------------------------------------------------------
        'Gets all questions even disabled ones
        Dim ReturnVal As Boolean = True
        Dim Questions As ArrayList = SQL_Functions.GetQuestions(SectionID)
        Dim CFDACells As New ArrayList
        Dim BadCells As New ArrayList
        Dim CFDAHeadingID As Integer = SQL_Functions.GetCFDAHeading(SectionID)
        Dim TxtBoxID As String = ""
        Dim matrixTable As Table = ReportTable
        If CFDAHeadingID <> 0 Then


            'Loop through to check CFDA numbers 
            For index As Integer = 0 To (Questions.Count() - 1) Step 1
                TxtBoxID = "txt_" & CFDAHeadingID & "-" & Questions(index)
                'checks to see if the control exists and if so then add it to the ArrayList 

                Dim txt As DropDownList = matrixTable.FindControl(TxtBoxID)


                ''Adds all bad cells to this ArrayList
                'BadCells.Add(TxtBoxID)

                'if the TextBox Exists then it will add the ID to the ArrayList
                If Not (txt Is Nothing) Then
                    CFDACells.Add(TxtBoxID)
                End If
            Next
            Dim ValueHeadingID As Integer = 0
            Dim SelectedValues As New ArrayList
            Dim QID As String()
            'Gets the HeadingID corresponding to the Values TextBoxes
            Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString)
                Dim sql As String = ""
                conn.Open()
                sql = "select HeadingID from Heading as H where AnswerType=2 and SectionID=@SectionID"
                Dim cmd As SqlCommand = New SqlCommand(sql, conn)
                cmd.Parameters.Add(New SqlParameter("@SectionID", SectionID))
                ValueHeadingID = cmd.ExecuteScalar()
                SQL_Functions.CloseDB(conn)
            End Using

            'Loops through all of the CFDACells
            For i As Integer = 0 To (CFDACells.Count() - 1) Step 1
                Dim ddl As DropDownList = matrixTable.FindControl(CFDACells(i))
                'Checks if the SelectedText is NULL 
                If String.IsNullOrEmpty(ddl.SelectedItem.Text.ToString()) = True Then
                    QID = Split(CFDACells(i), "-")
                    TxtBoxID = "txt_" & ValueHeadingID & "-" & QID(1)
                    'If it is NULL then checks to see if the value in the textbox next to it is not 0
                    If GetTextBoxInfo(TxtBoxID) <> 0 Then
                        InvalidAnswer("Cannot have a value if you have not seleted a item", TxtBoxID)
                        ReturnVal = False
                    End If
                Else
                    'Adds the Selected Text to an ArrayList 

                    QID = Split(CFDACells(i), "-")
                    TxtBoxID = "txt_" & ValueHeadingID & "-" & QID(1)
                    'Checks if the value is = 0 
                    If GetTextBoxInfo(TxtBoxID) = 0 Then
                        InvalidAnswer("Cannot select an item without entering a value", TxtBoxID)
                        ReturnVal = False
                    End If
                End If
                If i <> 0 Then
                    'Loops through all of the Selected Texts an compares it aganist the currently CFDA Cells selected Text
                    Dim CurrSelected As String = ddl.SelectedItem.Text
                    For index As Integer = 0 To (SelectedValues.Count() - 1) Step 1
                        If CurrSelected <> SelectedValues(index) = 0 Then
                            TxtBoxID = "txt_" & CFDAHeadingID & "-" & QID(1)
                            InvalidAnswerDDL("Cannont have multiple of the same items selected", TxtBoxID)
                            ReturnVal = False
                        End If
                    Next
                End If
                If String.IsNullOrEmpty(ddl.SelectedItem.Text) = False Then
                    SelectedValues.Add(ddl.SelectedItem.Text)

                End If
            Next
        End If
        '------------------------------------------------------------------------------------------------------------------
        '--------------------------------------For Additional Indicators---------------------------------------------------
        '------------------------------------------------------------------------------------------------------------------
        Dim NonDisabledCells As DataTable = SQL_Functions.GetNonDisabledCells(SectionID)

        Dim TextHeadingID As Integer = 0
        Dim FirstCellID As String = 0
        Dim Description As New ArrayList
        Dim Values As New List(Of Double)
        Dim CurrentQs As Integer = 0
        Dim IsEmptyBool As Boolean = True
        'Gets the HeadingID Associated with the Additional Indicator Name 
        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString)
            Dim sql As String = ""
            conn.Open()
            sql = "select HeadingID from Heading as H where H.QuestionType=5 and AnswerType=3 and SectionID=@SectionID"
            Dim cmd As SqlCommand = New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@SectionID", SectionID))
            TextHeadingID = cmd.ExecuteScalar()
            SQL_Functions.CloseDB(conn)
        End Using

        For i As Integer = 0 To (NonDisabledCells.Rows.Count() - 1) Step 1
            'Sets the current Question ID on intial start
            If i = 0 Then
                CurrentQs = NonDisabledCells.Rows(i).Item("QuestionID")
            End If

            'If the Textbox isn't the description, it will get the value from it and  check it aganist the other values
            If Convert.ToInt16(NonDisabledCells.Rows(i).Item("HeadingID")) <> TextHeadingID Then
                TxtBoxID = "txt_" & NonDisabledCells.Rows(i).Item("HeadingID") & "-" & CurrentQs
                Dim Temp As Double = GetTextBoxInfo(TxtBoxID)
                If Temp <> -1 Then
                    If Temp > 0 Then
                        For j As Integer = 0 To (Values.Count() - 1) Step 1
                            If Values(j) = 0 Then
                                InvalidAnswer("Need to enter data into every cell for correct submission", TxtBoxID)
                                ReturnVal = False
                            End If
                        Next
                    End If
                    'For some reason a negative number is appearing the TextBox data
                    If Temp < 0 Then
                        Temp = Temp * -1
                    End If
                    If Values.Count() = 0 Then
                        FirstCellID = TxtBoxID
                    End If
                    Values.Add(Temp)
                End If
            End If

            'Checks if we moved to a new question or not
            If NonDisabledCells.Rows(i).Item("QuestionID") <> CurrentQs Or i = (NonDisabledCells.Rows.Count() - 1) Then
                'Checks if the questions values and descriptions are correctly formatted before proceeding
                TxtBoxID = "txt_" & TextHeadingID & "-" & CurrentQs
                Dim temp As String = GetTextBoxInfoString(TxtBoxID)
                Dim Sum As Double = Values.Sum()
                'Checks if the Current description is Null or empty
                If String.IsNullOrEmpty(temp) = False Then
                    IsEmptyBool = False
                    If (Sum / (Values.Count() - 1)) = 0 Then
                        InvalidAnswer("Cannot have a description without values", TxtBoxID)
                        ReturnVal = False
                    End If
                Else
                    IsEmptyBool = True
                    If (Sum / (Values.Count() - 1)) <> 0 Then
                        InvalidAnswer("Cannot have values without a description", TxtBoxID)
                        ReturnVal = False
                    End If
                End If
                'Checks the Current Description Aganist Previous ones to see if any are the same
                For index As Integer = 0 To (Description.Count() - 1) Step 1
                    If temp = Description(index).ToString() Then
                        'Checks if the 
                        InvalidAnswer("Additional Indicator Text Already Taken", TxtBoxID)
                        ReturnVal = False
                    End If
                Next
                'Adds the Description to the ArrayList
                If String.IsNullOrEmpty(temp) = False Then
                    Description.Add(temp)
                End If
                CurrentQs = NonDisabledCells.Rows(i).Item("QuestionID")
                If ReturnVal = False Then
                    If Values(0) > 0 Then
                        InvalidAnswer("Need to enter data into every cell for correct submission", TxtBoxID)
                    End If
                End If
                Values.Clear()
                ReturnVal = True
            End If
        Next
        Return ReturnVal
    End Function
	
	'--------------------------------------------------------------------------------------------------------------------------------------------
	'--------------------------------------------------------------------------------------------------------------------------------------------
	'--------------------------------------------------------------------------------------------------------------------------------------------
	'--------------------------------------------------------------------------------------------------------------------------------------------
	
	''' <summary>
    ''' Sets the textbox back to the orginal formatting 
    ''' </summary>
    ''' <param name="TxtBoxID"></param>
    ''' <remarks>Created By Dylan Steele
    ''' 8/24/2016</remarks>
    Protected Sub ResetTextBox(ByVal TxtBoxID As String)
        Dim matrixTable As Table = ReportTable
        Dim txt As TextBox = matrixTable.FindControl(TxtBoxID)

        txt.BackColor = Drawing.Color.White
        txt.ReadOnly = False
        txt.Font.Bold = False
    End Sub
    ''' <summary>
    ''' Used to get TextBox info that are Doubles
    ''' </summary>
    ''' <param name="TxtBoxID"></param>
    ''' <returns></returns>
    ''' <remarks>Created By Dylan Steele
    ''' 8/24/2016</remarks>
    Protected Function GetTextBoxInfo(ByVal TxtBoxID As String) As Double
        Dim matrixTable As Table = ReportTable
        Dim ReturnVal = 0.0
        Try
            Dim txt As TextBox = matrixTable.FindControl(TxtBoxID)
            ReturnVal = Convert.ToDouble(txt.Text)
            ReturnVal = Convert.ToDouble(ReturnVal)
        Catch ex As Exception
            Return -1
        End Try
        Return ReturnVal
    End Function
    ''' <summary>
    ''' Used to get TextBox info that are strings
    ''' </summary>
    ''' <param name="TxtBoxID"></param>
    ''' <returns></returns>
    ''' <remarks>Created By Dylan Steele
    ''' 8/24/2016</remarks>
    Protected Function GetTextBoxInfoString(ByVal TxtBoxID As String) As String
        Dim matrixTable As Table = ReportTable
        Dim ReturnVal As String = ""
        Try
            Dim txt As TextBox = matrixTable.FindControl(TxtBoxID)
            ReturnVal = txt.Text
        Catch ex As Exception
            Return -1
        End Try
        Return ReturnVal
    End Function
	
	 ''' <summary>
    ''' Given a GroupID it will return QuestionIDs, HeadingIDs in a Dataset
    ''' </summary>
    ''' <param name="GroupID"></param>
    ''' <returns></returns>
    ''' <remarks>Created by Dylan Steele
    ''' 8/24/2016</remarks>
    Protected Function getGroup(ByVal GroupID As Integer) As DataSet
        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("FACS").ToString)
            Dim sql As String = ""
            conn.Open()
            sql = "select QuestionID, HeadingID from GROUP_ITEMS2 as GI2 where GI2.GroupID=@GroupID"
            Dim cmd As New SqlCommand(sql, conn)
            cmd.Parameters.Add(New SqlParameter("@GroupID", GroupID))
            Dim GroupDA As New SqlDataAdapter(cmd), dsGroup As New DataSet
            GroupDA.Fill(dsGroup, "Group")
            Return dsGroup
            Global_Functions.CloseDB(conn)
        End Using
    End Function
    ''' <summary>
    ''' Sets the Error Message and Cell formatting for invalid cells
    ''' </summary>
    ''' <param name="ErrorMessage"></param>
    ''' <param name="TextboxID"></param>
    ''' <remarks>Created By Dylan Steele
    ''' 8/23/2016</remarks>
    Protected Sub InvalidAnswer(ByVal ErrorMessage As String, ByVal TextboxID As String)
        Dim matrixTable As Table = ReportTable
        Dim Txt As TextBox = matrixTable.FindControl(TextboxID)

        Txt.ToolTip = Global_Functions.stripHTML(ErrorMessage)
        Txt.BackColor = Drawing.Color.Red
        Txt.ForeColor = Drawing.Color.White
        Txt.Font.Bold = True
        'Adds the Error to the List of Errors
        AddError(ErrorMessage, TextboxID)

    End Sub
    ''' <summary>
    ''' Sets the Error Message and Cell formatting for invalid cells
    ''' </summary>
    ''' <param name="ErrorMessage"></param>
    ''' <param name="TextboxID"></param>
    ''' <remarks>Created By Dylan Steele
    ''' 8/23/2016</remarks>
    Protected Sub InvalidAnswerDDL(ByVal ErrorMessage As String, ByVal TextboxID As String)
        Dim matrixTable As Table = ReportTable
        Dim Txt As DropDownList = matrixTable.FindControl(TextboxID)

        Txt.ToolTip = Global_Functions.stripHTML(ErrorMessage)
        Txt.BackColor = Drawing.Color.Red
        Txt.ForeColor = Drawing.Color.White
        Txt.Font.Bold = True
        'Adds the Error to the list of Errors
        AddError(ErrorMessage, TextboxID)

    End Sub
    ''' <summary>
    ''' Comparision Checker Functions used by the Validator
    ''' </summary>
    ''' <param name="ValueLeft"></param>
    ''' <param name="ValueRight"></param>
    ''' <param name="OperatorVal"></param>
    ''' <returns></returns>
    ''' <remarks>Created By Dylan Steele
    ''' 9/1/2016</remarks>
    Protected Function CheckComparison(ByVal ValueLeft As Double, ByVal ValueRight As Double, ByVal OperatorVal As Integer) As Boolean
        Select Case OperatorVal
            '<
            Case 1
                If (ValueLeft < ValueRight) = True Then
                    Return True
                Else
                    Return False
                End If
                '>
            Case 2
                If (ValueLeft > ValueRight) = True Then
                    Return True
                Else
                    Return False
                End If
                '=
            Case 3
                If (ValueLeft = ValueRight) = True Then
                    Return True
                Else
                    Return False
                End If
                '<=
            Case 4
                If (ValueLeft <= ValueRight) = True Then
                    Return True
                Else
                    Return False
                End If
                '>=
            Case 5
                If (ValueLeft >= ValueRight) = True Then
                    Return True
                Else
                    Return False
                End If
                '+
            Case 6
                Return False
                '-
            Case 7
                Return False
            Case Else
                Return False
        End Select
    End Function
    ''' <summary>
    ''' Totals numbers in a list given the operater type identifer
    ''' </summary>
    ''' <param name="IntList"></param>
    ''' <param name="OperatorStr"></param>
    ''' <returns>Totaled Values of a list of Numbers </returns>
    ''' <remarks>Created By Dylan Steele
    ''' 8/19/2016</remarks>
    Public Shared Function CalcValues(ByVal IntList As ArrayList, ByVal OperatorStr As Integer) As Double
        Dim Amt As Integer = IntList.Count()
        Dim Total As Double = 0

        'Switch statment to select correct operation 
        Select Case OperatorStr
            'Not sure how to handle this Operator 
            Case 1
                For index As Integer = 0 To (Amt - 1)
                    Return -1
                Next
            Case 2
                For index As Integer = 0 To (Amt - 1)
                    Total = Total + IntList(index)
                Next
            Case 3
                For index As Integer = 0 To (Amt - 1)
                    If index = 0 Then
                        Total = IntList(index)
                    Else
                        Total = Total - IntList(index)
                    End If
                Next
            Case 4
                For index As Integer = 0 To (Amt - 1)
                    If index = 0 Then
                        Total = IntList(index)
                    Else
                        Total = Total / IntList(index)
                    End If
                Next
            Case 5
                For index As Integer = 0 To (Amt - 1)
                    If index = 0 Then
                        Total = IntList(index)
                    Else
                        Total = Total * IntList(index)
                    End If
                Next
                'if an illigal character is passed in the operator string
            Case Else
                Return -1
        End Select
        Return Total
    End Function
    ''' <summary>
    ''' Add Errors to the Error List that are generated by the Validator
    ''' </summary>
    ''' <param name="ErrorString"></param>
    ''' <param name="Cell"></param>
    ''' <remarks>Created by Dylan Steele
    ''' 9/2/2016</remarks>
    Public Sub AddError(ByVal ErrorString As String, ByVal Cell As String)
        Dim FormattedStr As String = Cell & "*" & ErrorString
        If ErrorList.Contains(FormattedStr) = False Then
            ErrorList.Add(FormattedStr)
        End If
    End Sub
                    </code></pre>
                </div>
        </div>
    </div>

</asp:Content>
