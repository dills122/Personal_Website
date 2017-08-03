<%@ Page Language="C#" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="contact" MasterPageFile="~/Master_Pages/main.master" %>

<asp:Content ContentPlaceHolderID="HeaderAreacp" runat="server">

</asp:Content>

<asp:Content ContentPlaceHolderID="MainContentcp" runat="server">
    <asp:Panel ID="mainpnl" runat="server">
        
        <div  class="center-contact">
            <div><span>Contact Me</span></div>
            <div><asp:TextBox ID="Nametxt" runat="server" placeholder="Name:"></asp:TextBox></div>
            <div><asp:TextBox ID="Emailtxt" runat="server" placeholder="Email:"></asp:TextBox></div>
            <div><asp:TextBox ID="Bodytxt" runat="server" TextMode="MultiLine" Rows="15" placeholder="Body:" Width="100%"></asp:TextBox></div>
            <div><asp:Button ID="Submitbtn" runat="server" Text="Send" OnClick="Contactbtn_Click" /></div>
            <br /><br />
            <div><asp:Label ID="errorlb" runat="server" Visible="false"></asp:Label></div>
        </div>
        

    </asp:Panel>
</asp:Content>
