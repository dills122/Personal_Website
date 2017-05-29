﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/home.css" rel="stylesheet" />
    <link href="./css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/atom-one-dark.css" rel="stylesheet" />
    <script src="js/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <link href="css/home.css" rel="stylesheet" />
    <title>Dylan Steele</title>
</head>
<body>
    <asp:Panel class="container-fluID super-container" ID="superContainer" runat="server">
        <div class="header-row row" id="header-row">
        </div>
        <asp:Panel class="row main-row col-sm-12 col-md-12 col-lg-12 col-xs-12" ID="contentRow" runat="server">
            <asp:Panel class="left-bar col-lg-2 col-md-2 col-sm-12 col-xs-12" ID="leftBar" runat="server">
                <div class="link-well well center-text">
                    <form id="form1" runat="server">
                        <span >Login</span><br />
                        <asp:TextBox ID="UserNametxt" runat="server" placeholder="Username:"></asp:TextBox>
                        <asp:TextBox ID="Passwordtxt" runat="server" placeholder="Password:" TextMode="Password"></asp:TextBox>
                        <asp:Label ID="Errorlb" runat="server" Text="Login Error" Visible="false" ForeColor="Red"></asp:Label>
                        <asp:Button ID="Submitbtn" runat="server" Text="Login" OnClick="Submitbtn_Click" />
                    </form>
                    <form id="form2" runat="server" visible="false">
                        <span>Login</span><br />
                        <asp:Label ID="Usernamelb" runat="server" /><br />
                        <asp:Label ID="Loginlb" runat="server" /><br /><br />
                        <asp:HyperLink ID="Adminhl" runat="server" NavigateUrl="~/Admin/admin.aspx" Text="Admin Management"></asp:HyperLink><br />
                        <asp:Button ID="Logoffbtn" runat="server" Text="Logoff" OnClick="Logoffbtn_Click" />
                    </form>
                </div>
                <div class="link-well well" runat="server" id="topLinks">
                </div>
                <div class="ad-well well">
                </div>
            </asp:Panel>
            <asp:Panel class="content-area col-lg-8 col-sm-12 col-md-8 col-xs-12" ID="contentArea" runat="server">
            </asp:Panel>
            <asp:Panel class="right-bar col-lg-2 col-md-2 col-sm-12 col-xs-12" ID="rightBar" runat="server">
                <div class="link-well well" runat="server" id="languageIDdiv">

                </div>
                <div class="link-well well">
                    <span>Useful Links</span><br />
                    <a href="#">Link 1</a><br />
                    <a href="#">Link 2</a><br />
                    <a href="#">Link 3</a><br />
                    <a href="#">Link 4</a><br />
                </div>
                <div class="ad-well well">
                </div>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
</body>
</html>
