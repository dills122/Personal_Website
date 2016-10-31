<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Manage_Blog.aspx.cs" Inherits="Blog_Manage_Blog" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <form id="form1" runat="server">
        <script type="text/javascript">
            function OpenPreview() {
                SetSessionPreview();
                window.open("Blog_Preview.aspx", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=400,height=400");
            }
            function SetSessionPreview() {
                var txt = document.getElementById('<%=Bodytb.ClientID%>');
                var value = txt.value;
                '<%Session["PageContents"] = "' + value + '"; %>';
                '<%Session["Pass"] = " + Password + "; %>';

            }
        </script>
        <asp:Panel ID="Lockpnl" runat="server" HorizontalAlign="Center">
            <br />
            <br />
            <br />
            <br />
            <div style="width: 50%; margin: auto;">
                <asp:Label Text="Enter the passcode" Font-Size="XX-Large" Font-Bold="true" runat="server"></asp:Label>
                <br />
                <asp:TextBox ID="PassCode" runat="server" TextMode="Password" Width="25%"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="EnterCodebtn" runat="server" Text="Submit" OnClick="EnterCodebtn_Click" />
                <br />
                <asp:Label ID="Errorlb" Text="Incorrect" Font-Size="XX-Large" Font-Bold="true" runat="server" Visible="false"></asp:Label>

            </div>
        </asp:Panel>
        <asp:Panel ID="Managepnl" runat="server" HorizontalAlign="Center">
            <!-- Add Connected Gridview for managing comments -->
            <br />
            <br />
            <asp:Label Text="Create New Post" Font-Size="X-Large" runat="server"></asp:Label>&nbsp;&nbsp;
            <asp:Button Text="New" runat="server" ID="NewPost" OnClick="NewPost_Click" />
            <br />
            <br />
            <asp:Panel ID="Postpnl" runat="server" Visible="false">
                <asp:Label Text="PostName" runat="server"></asp:Label>&nbsp;&nbsp;
                <asp:TextBox ID="PostNametb" runat="server" Width="15%"></asp:TextBox>
                <br />
                <br />
                <asp:TextBox ID="Bodytb" TextMode="MultiLine" Columns="70" Rows="20" runat="server"></asp:TextBox>
                <br />
                <asp:Button Text="Submit" runat="server" OnClick="Unnamed_Click" ID="PostNewbtn" />&nbsp;&nbsp;
                <asp:Button Text="Preview" runat="server" OnClientClick="OpenPreview();" OnClick="Unnamed_Click1" />

            </asp:Panel>
            <br />
            <br />
            <asp:GridView ID="Postsgrd" runat="server" AllowSorting="true"></asp:GridView>
        </asp:Panel>
    </form>
</asp:Content>
