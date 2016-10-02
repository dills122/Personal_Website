<%@ Page Language="C#" AutoEventWireup="true" CodeFile="contact-me.aspx.cs" Inherits="contact_me" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <style>
        table {
            border-collapse: separate; 
            border-spacing: 15px;
            width: 80%;
            margin-left: 10%;
            margin-right: 10%;
        }
    </style>
    <form runat="server">
        <br />
        <br />
        <table>
            <tr>
                <td><asp:Literal Text="<b>Enter your name: " runat="server"></asp:Literal></td>
                <td><asp:TextBox ID="Nametb" runat="server" Width="80%"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Literal Text="<b>Enter Subject: " runat="server" ></asp:Literal></td>
                <td><asp:TextBox ID="Subjecttb" runat="server" Width="80%"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Literal Text="<b>Enter Body:  " runat="server"></asp:Literal></td>
                <td><asp:TextBox ID="Bodytb" runat="server" Width="80%" Height="200px"></asp:TextBox></td>
            </tr>
        </table>
        <br />
        <br />
        <div style="text-align:center">
            <asp:Button CssClass="nav-pills" runat="server" Text="Submit" OnClick="Unnamed_Click" />
        </div>
        <br />
        <br />
    </form>
</asp:Content>
