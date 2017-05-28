<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="./css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/atom-one-dark.css" rel="stylesheet" />
    <script src="js/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <title>Dylan Steele</title>
    <style type="text/css">
        .left-bar {
            margin-top: 2em;
        }
        .right-bar {
            margin-top:2em;
        }
        pre {
            margin-top:2em;
        }
        .code-header {
            font-size:1.5em;
            font-weight:500;

        }

        .code-container {
            padding-top:2em;
        }

        .example-header {
            font-size:1.25em;
            font-weight:500;
           text-decoration:underline;
        }

    </style>
</head>
<body>
    <asp:Panel class="container-fluID super-container" ID="superContainer" runat="server">
        <div class="header-row row" ID="header-row">

        </div>
        <asp:Panel class="row main-row col-sm-12 col-md-12 col-lg-12 col-xs-12" ID="contentRow" runat="server">
            <asp:Panel class="left-bar col-lg-2 col-md-2 col-sm-12 col-xs-12" ID="leftBar" runat="server">
                <div  class="link-well well">
                    <span>Useful Links</span><br />
                    <a href="#">Link 1</a><br />
                    <a href="#">Link 2</a><br />
                    <a href="#">Link 3</a><br />
                    <a href="#">Link 4</a><br />
                </div>
                <div  class="link-well well" runat="server" ID="topLinks">

                </div>
                <div class="ad-well well">

                </div>
            </asp:Panel>
            <asp:Panel class="content-area col-lg-8 col-sm-12 col-md-8 col-xs-12" ID="contentArea" runat="server">

            </asp:Panel>
            <asp:Panel class="right-bar col-lg-2 col-md-2 col-sm-12 col-xs-12" ID="rightBar" runat="server">
                <div  class="link-well well">
                    <span>Useful Links</span><br />
                    <a href="#">Link 1</a><br />
                    <a href="#">Link 2</a><br />
                    <a href="#">Link 3</a><br />
                    <a href="#">Link 4</a><br />
                </div>
                <div  class="link-well well">
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
