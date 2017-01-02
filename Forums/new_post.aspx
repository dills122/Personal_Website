<%@ Page Language="C#" AutoEventWireup="true" CodeFile="new_post.aspx.cs" Inherits="Forums_new_post" ValidateRequest="false" %>

<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/Post.css" rel="stylesheet" />
    <form runat="server" id="form1">
        <asp:UpdatePanel ID="uptpnl" runat="server">
            <ContentTemplate>

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <div class="container-fluid" id="container">
                    <div class="row-fluid">
                        <div class="col-md-2 col-lg-2 col-sm-2 col-xs-12 span-2">
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
                                <br />
                                <asp:Panel class="well" ID="Posts" runat="server">
                                </asp:Panel>
                                <!--/.well -->
                            </div>
                            <!--/sidebar-nav-fixed -->
                        </div>
                        <!--/span-->
                        <asp:Panel class="col-md-8 col-lg-8 col-sm-8 col-xs-12 span-8" ID="NewPostContent" runat="server">
                            <h2 class="page-header">Create New Post</h2>
                            <asp:Panel ID="InnerContent" runat="server">

                                <br />
                                <asp:Label Text="<b>Enter Post Title: </b>" runat="server" CssClass="Labels"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="PostTitle" runat="server" Width="30%"></asp:TextBox>
                                <br />
                                <br />
                                <div style="width: 50%; margin: auto;">
                                    <FTB:FreeTextBox ID="ContentBodytb" runat="Server" />
                                </div>
                                <br />
                                <asp:Button ID="Previewbtn" Text="Preview" runat="server" OnClick="Previewbtn_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="PostUpload" runat="server" Text="Post" OnClick="PostUpload_Click" />
                                <br />
                                <br />
                                <br />
                                <asp:Literal ID="Previewtxt" Text="<h2>Preview Panel</h2>" runat="server" Visible="false"></asp:Literal>
                                <asp:Panel ID="Previewpnl" runat="server" Visible="false" CssClass="well">
                                    <br />
                                </asp:Panel>
                            </asp:Panel>
                        </asp:Panel>
                        <!--/span-->
                        <div class="col-md-2 col-lg-2 col-sm-2 col-xs-12 span-2" id="RightSide">
                            <br />
                            <br />
                            <div class="sidebar-nav-fixed">
                                <div id="Ad">
                                </div>
                                <br />
                                <div class="well" id="NotSure">
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
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->

                </div>

            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
