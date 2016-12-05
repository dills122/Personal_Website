<%@ Page Language="C#" AutoEventWireup="true" CodeFile="new_post.aspx.cs" Inherits="Forums_new_post" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/Post.css" rel="stylesheet" />
    <form runat="server" id="form1">
        <div class="container-fluid" id="container">
            <div class="row-fluid">
                <div class="col-md-2 col-lg-2 col-sm-2 col-xs-12 span-2">
                    <br />
                    <br />
                    <div class="sidebar-nav-fixed" id="LeftSide">
                        <asp:Panel class="well" ID="Login" runat="server">
                            <asp:Label Text="UserName:" runat="server"></asp:Label>&nbsp;&nbsp;
                            <asp:TextBox ID="UserNametxt" runat="server" Width="100%"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Label Text="Password: " runat="server"></asp:Label>&nbsp;&nbsp;
                            <asp:TextBox ID="Passwordtxt" runat="server" TextMode="Password" Width="100%"></asp:TextBox>
                            <br />
                            <asp:LinkButton ID="ForgotPasslb" runat="server" Text="Forgot Password?" CssClass="forgotPass" OnClick="ForgotPasslb_Click"></asp:LinkButton>
                            <br />
                            <br />
                            <asp:Button Text="Logon" runat="server" ID="Loginbtn" OnClick="Loginbtn_Click" />
                        </asp:Panel>
                        <br />
                        <asp:Panel class="well" ID="Posts" runat="server">
                        </asp:Panel>
                        <!--/.well -->
                    </div>
                    <!--/sidebar-nav-fixed -->
                </div>
                <!--/span-->
                <asp:Panel class="col-md-8 col-lg-8 col-sm-8 col-xs-12 span-8" ID="Content" runat="server">
                    <asp:Panel ID="InnerContent" runat="server">
                        <h2 class="page-header">Create New Post</h2>
                        <br />
                        <asp:Label Text="Enter Post Title" runat="server" CssClass="Labels"></asp:Label>
                        <br />
                        <asp:TextBox ID="PostTitle" runat="server" Width="50%" ></asp:TextBox>
                        <br />
                        <br />
                        <asp:TextBox ID="PostContent" runat="server" Width="80%" Rows="25"></asp:TextBox>
                        <br />
                        <asp:Button ID="PostUpload" runat="server" Text="Post" OnClick="PostUpload_Click" />
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
                        </div>
                        <!--/.well -->
                    </div>
                    <!--/sidebar-nav-fixed -->
                </div>
                <!--/span-->
            </div>
            <!--/row-->

        </div>
    </form>
</body>
</html>
