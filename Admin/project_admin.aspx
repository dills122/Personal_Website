<%@ Page Language="C#" AutoEventWireup="true" CodeFile="project_admin.aspx.cs" Inherits="Admin_project_admin" MasterPageFile="~/Master_Pages/Admin.master" ClientIDMode="Static" %>


<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .padding {
            padding: .5em;
            width: 100%;
        }

        .dynamic-container {
            width: 100%;
            height: 100%;
            display: block;
        }

        .dy-row {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            padding: .5em;
        }

        .content {
            display: flex;
            flex-wrap: nowrap;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 0 auto;
            width: 90%;
            height: 100%;
        }
    </style>
    <script type="text/javascript">

        var counter = 1;
        counter = counter;
        $(window).ready(function () {
            $('#addRow').click(function () {
                var row = CreateRow();
                row.appendChild(CreateCell("textarea", "Title"));
                row.appendChild(CreateCell("textarea", "Desc"));
                row.appendChild(CreateCell("textarea", "Body"));
                row.appendChild(CreateCell("select", "Active"));
                var dynCon = document.getElementById("ExampleCode");
                dynCon.appendChild(row);
                counter++;
            });
        });

        function CreateRow() {
            var rowDiv = document.createElement("div");
            rowDiv.className += "dy-row";
            return rowDiv;
        }
        function CreateCell(InputCntrl, idName) {
            var divCell = document.createElement("div");
            var inputC = document.createElement(InputCntrl);
            if (InputCntrl == "select") {
                var opt = document.createElement("option");
                opt.setAttribute("value", "1");
                opt.innerText = "True";
                inputC.appendChild(opt);

                opt = document.createElement("option");
                opt.setAttribute("value", "0");
                opt.innerText = "False";
                inputC.appendChild(opt);
            }
            inputC.setAttribute("runat", "server");
            inputC.setAttribute("id", "dy" + idName + counter);
            inputC.setAttribute("placeholder", idName + "..");
            inputC.setAttribute("type", "text");
            divCell.appendChild(inputC);
            return divCell;
        }
        $(window).ready(function () {
            $('#Submitbtn').click(function () {
                SavePersonRecord();
            });
        });

        function SavePersonRecord() {

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "DataInsertUseJQuery.aspx/InsertIntoDB",
                success: function (Record) {

                    $('#txtName').val();
                    $('#txtLastName').val();


                    if (Record.d == true) {

                        $('#Result').text("Your Record insert");
                    }
                    else {
                        $('#Result').text("Your Record Not Insert");
                    }

                },
                Error: function (textMsg) {

                    $('#Result').text("Error: " + Error);
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <asp:Panel ID="Mainpnl" runat="server" CssClass="content">
            <div class="padding">
                <label>Project Name:</label>
                <asp:TextBox ID="Nametxt" runat="server" placeholder="Project Name.."></asp:TextBox>
            </div>
            <div class="padding">
                <label>Project Description:</label><br />
                <asp:TextBox ID="Descrtxt" runat="server" placeholder="Project Description.." TextMode="MultiLine" Rows="10" Width="25em"></asp:TextBox>
            </div>
            <div class="padding">
                <label>Language Used:</label>
                <asp:DropDownList ID="Languageddl" runat="server" DataSourceID="Langsrc" DataTextField="language_text" DataValueField="ID">
                    <asp:ListItem Value="0">---Select---</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="padding">
                <label>Project Examples</label>
                <div class="dynamic-container" id="ExampleCode" runat="server">
                    <div class="dy-row">
                        <div>
                            <textarea type="text" id="dyTitle0" placeholder="Title.." runat="server" />
                        </div>
                        <div>
                            <textarea type="text" id="dyDesc0" runat="server" placeholder="Description.." />
                        </div>
                        <div>
                            <textarea type="text" id="dyBody0" runat="server" placeholder="Body.." />
                        </div>
                        <div>
                            <select id="dyActive0" runat="server" title="Active">
                                <option value="1">True</option>
                                <option value="0">False</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div>
                    <button id="addRow" onclick="return false">New Row</button>
                </div>
            </div>
            <div class="padding">
                <asp:FileUpload ID="Fileupload" runat="server" />
            </div>
            <div class="padding">
                <asp:Button ID="Submitbtn" runat="server" Text="Create Project"  />
            </div>
        </asp:Panel>
        <asp:Panel ID="Gridpnl" runat="server">
            <asp:GridView ID="projectgrd" runat="server" AutoGenerateColumns="false" AutoGenerateDeleteButton="true" AutoGenerateEditButton="true"
                 AutoGenerateSelectButton="true" DataKeyNames="ID" DataSourceID="projectsrc" >
                <Columns>
                    <asp:TemplateField HeaderText="ID" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="projIDlb" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Project Name">
                        <ItemTemplate>
                            <asp:Label ID="namelb" runat="server" Text='<%# Bind("project_name") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="nametxt" runat="server" Text='<%# Bind("project_name") %>' TextMode="MultiLine" Rows="15" ></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:Label ID="descrlb" runat="server" Text='<%# Bind("project_description") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="descrtxt" runat="server" Text='<%# Bind("project_description") %>' TextMode="MultiLine" Rows="15"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="File Name">
                        <ItemTemplate>
                            <asp:Label ID="bodylb" runat="server" Text='<%# Bind("file_name") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="bodylb" runat="server" Text='<%# Bind("file_name") %>'></asp:Label>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Language Used">
                        <ItemTemplate>
                            <asp:Label ID="langlb" runat="server" Text='<%# Bind("language_text") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="langddl" runat="server" DataSourceID="Langsrc" DataTextField="language_text" DataValueField="ID" Selected='<%# Eval("FID") %>'></asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
        <asp:SqlDataSource ID="Langsrc" runat="server" ConnectionString="<%$ ConnectionStrings:DB %>"
            SelectCommand="SELECT ID, language_text FROM LANGUAGE_CODE"></asp:SqlDataSource>
        <asp:SqlDataSource ID="projectsrc" runat="server" ConnectionString="<%$ ConnectionStrings:DB %>"
             SelectCommand="SELECT P.ID, project_name,project_description, PF.file_name, LC.language_text,PF.ID as FID FROM PROJECT AS P 
                        LEFT JOIN PROJECT_FILE AS PF ON PF.ID=P.file_id
                        INNER JOIN LANGUAGE_CODE AS LC ON LC.ID=P.language_id"></asp:SqlDataSource>
    </form>
</asp:Content>
