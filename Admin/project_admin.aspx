<%@ Page Language="C#" AutoEventWireup="true" CodeFile="project_admin.aspx.cs" Inherits="Admin_project_admin" MasterPageFile="~/Master_Pages/Admin.master" %>


<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .padding {
            padding: .5em;
        }

        .dynamic-container {
            width: 100%;
            height: 100%;
            display: block;
        }

        .row {
            display: flex;
            justify-content: space-between;
            padding: .5em;
        }
    </style>
    <script type="text/javascript">
        $(window).ready(function () {
            $('#submit').click(function () {
                var row = CreateRow();
                row.appendChild(CreateCell("input"));
                row.appendChild(CreateCell("input"));
                row.appendChild(CreateCell("input"));
                row.appendChild(CreateCell("select"));
                var dynCon = document.getElementById("dynamic-container");
                dynCon.appendChild(row);
            });
        });

        function CreateRow() {
            var rowDiv = document.createElement("div");
            rowDiv.className += "row";
            return rowDiv;
        }
        function CreateCell(InputCntrl) {
            var divCell = document.createElement("div");
            var inputC = document.createElement(InputCntrl);
            if (InputCntrl == "select") {
                var opt = document.createElement("option");
                opt.innerText = 0;
                inputC.appendChild(opt);

                opt = document.createElement("option");
                opt.innerText = 1;
                inputC.appendChild(opt);
            }
            divCell.appendChild(inputC);
            return divCell;
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <asp:Panel ID="Mainpnl" runat="server">
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
                <asp:DropDownList ID="Languageddl" runat="server" DataSourceID="Langsrc" DataTextField="language_text" DataValueField="ID"></asp:DropDownList>
            </div>
            <div class="padding">
                <label>Project Examples</label>
                <div class="dynamic-container" id="ExampleCode">

                </div>
            </div>
        </asp:Panel>
        <asp:SqlDataSource ID="Langsrc" runat="server" ConnectionString="<%$ ConnectionStrings:DB %>"
            SelectCommand="SELECT ID, language_text FROM LANGUAGE_CODE"></asp:SqlDataSource>
    </form>
</asp:Content>
