<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vb-net.aspx.cs" Inherits="Code_Examples_vb_net" MasterPageFile="~/MasterPage.master" %>


<asp:Content ContentPlaceHolderID="Content1" runat="server">

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
                <pre class="pre-scrollable" style="max-height: 800px"><code>

                   
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

                <pre class="pre-scrollable" style="max-height: 800px"><code> 
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
    </div>

</asp:Content>
