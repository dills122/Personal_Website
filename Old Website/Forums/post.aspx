﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="post.aspx.cs" Inherits="Forums_post" %>





<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/Post.css" rel="stylesheet" />
    <script src="../js/Post.js"></script>
    <form runat="server" id="form1">
        <div class="container-fluid" id="container">
            <div class="row-fluid">
                <asp:Panel class="col-md-2 col-lg-2 col-sm-2 col-xs-12 span-2" runat="server">
                    <br />
                    <br />
                    <div class="sidebar-nav-fixed" id="LeftSide">
                        <asp:Panel class="well" ID="Login" runat="server">
                            <asp:Panel ID="Loginpnl" runat="server">
                                <asp:Label Text="UserName:" runat="server"></asp:Label>&nbsp;&nbsp;
                           
                            <asp:TextBox ID="UserNametxt" runat="server" Width="100%"></asp:TextBox>
                                <br />
                                <br />
                                <asp:Label Text="Password: " runat="server"></asp:Label>&nbsp;&nbsp;
                           
                            <asp:TextBox ID="Passwordtxt" runat="server" TextMode="Password" Width="100%"></asp:TextBox>

                                <br />
                                <br />
                                <asp:Button Text="Logon" runat="server" ID="Loginbtn" OnClick="Loginbtn_Click" />
                                <br />
                                <br />
                                <a href="user.aspx?type=1">New User?</a>
                            </asp:Panel>
                            <asp:Panel ID="LoggedInpnl" runat="server" Visible="false"></asp:Panel>
                        </asp:Panel>
                        <br />
                        <asp:Panel class="well" ID="Posts" runat="server">
                        </asp:Panel>
                        <!--/.well -->
                    </div>
                    <!--/sidebar-nav-fixed -->
                </asp:Panel>
                <!--/span-->
                <asp:Panel class="col-md-8 col-lg-8 col-sm-8 col-xs-12 span-8" ID="Content" runat="server">
                    <asp:Panel ID="PostContent" runat="server"></asp:Panel>
                    <asp:Panel ID="CommentContent" runat="server"></asp:Panel>
                </asp:Panel>
                <!--/span-->
                <asp:Panel class="col-md-2 col-lg-2 col-sm-2 col-xs-12 span-2" ID="RightSide" runat="server">
                    <br />
                    <br />
                    <div class="sidebar-nav-fixed">
                        <div id="Ad" style="text-align: center">
                            <br />
                            <br />
                            <b>Ads</b>
                        </div>
                        <br />
                        <div class="well" id="NewPost">
                            <b>Useful Links</b>
                            <br />
                            <br />
                            <a href="new_post.aspx">Create a Post</a>
                            <br />
                            <a href="post.aspx">Home Page</a>
                            <br />
                            <a href="contact-me.aspx">Questions</a>
                            <br />
                            <a href="../main.aspx">Website Front Page</a>
                        </div>
                        <!--/.well -->
                    </div>
                    <!--/sidebar-nav-fixed -->
                </asp:Panel>
                <!--/span-->
            </div>
            <!--/row-->

        </div>
        <div id="AddEmbededComment" class="modalfooter">
            <span class="close">&times</span>
            <div class="well">
                <div class="InnerComment">
                    <h4>Enter New Reply: </h4>
                    <asp:Label ID="CommentID" runat="server" Visible="false"></asp:Label>
                    <input name="CommentBox" type="text" id="CommentBox" /><br />
                    <div style="padding-top: 5px;">
                        <small style="float: left;">Maximum character count is 500 </small>
                        <input type="submit" name="ctl09" value="Post" style="float: right; height: 25px;" /><br />
                        <br />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!--/.fluid-container-->
</body>
</html>
