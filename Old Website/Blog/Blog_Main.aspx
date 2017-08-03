<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Blog_Main.aspx.cs" Inherits="Blog_Blog_Main" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <form runat="server" id="form1">
        <asp:Panel ID="Mainpnl" runat="server">
            <div id="header" style="text-align: center; width: 60%; margin: auto;">
                <h1>Dylan's Blog</h1>
                <br />
                <p style="font-size: large">
                    Welcome to my blog, where almost all posts will be based around STEM topics. 
            This posts will not follow any specific release schedule and will only be 
            occasionally updated. However, I still want the ability for communication to
            be shared, so I will add a small comment section below each article. These 
            comments will not appear until I have approved them. If you have any comments or 
            questions about anything discussed, see my contact information below.
                </p>
                <br />
                <br />
            </div>
            <asp:Panel ID="CurrentPostspnl" runat="server" HorizontalAlign="Center"></asp:Panel>
        </asp:Panel>
        <asp:Panel ID="Postpnl" runat="server" HorizontalAlign="Center">
            <asp:Panel ID="Informationpnl" runat="server" HorizontalAlign="Center"></asp:Panel>
            <br />
            <br />
            <br />
            <!-- New Comments Area -->
            <div>
                <h4 style="text-align: center; font-weight: 600">Enter New Comment Below</h4>
                <br />
                <div style="width:80%">
                    <asp:Label runat="server">Name (Optional):</asp:Label>&nbsp;&nbsp;
                <asp:TextBox ID="Nametb" runat="server" Width="15%"></asp:TextBox>
                </div>
                <br />
                <asp:TextBox ID="NewComment" Width="40%" TextMode="MultiLine" Columns="50" Rows="5" runat="server"></asp:TextBox>
                <br />
                <asp:Label Text="Please enter your comment above." runat="server"></asp:Label>&nbsp;&nbsp;
                <asp:Button ID="NewCommentbtn" runat="server" OnClick="NewCommentbtn_Click" Text="Submit" />
                <br />
                <br />
                <asp:Label Text="You need to enter a comment in before submitting" ForeColor="Red" Font-Bold="true" runat="server"></asp:Label>
                
            </div>
            <asp:Panel ID="Commentspnl" runat="server" HorizontalAlign="Center"></asp:Panel>
            <br />
            <br />
        </asp:Panel>
    </form>
</asp:Content>
