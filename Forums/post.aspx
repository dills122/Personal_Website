<%@ Page Language="C#" AutoEventWireup="true" CodeFile="post.aspx.cs" Inherits="Forums_post" %>





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
                        <asp:Panel class="well" id="Login" runat="server">
                            <asp:Label Text="UserName:" runat="server"></asp:Label>&nbsp;&nbsp;
                            <asp:TextBox ID="UserNametxt" runat="server" Width="100%" ></asp:TextBox>
                            <br />
                            <br />
                            <asp:Label Text="Password: " runat="server"></asp:Label>&nbsp;&nbsp;
                            <asp:TextBox ID="Passwordtxt" runat="server" TextMode="Password" Width="100%"></asp:TextBox>
                            <br />
                            <asp:LinkButton ID="ForgotPasslb" runat="server" Text="Forgot Password?" CssClass="forgotPass" OnClick="ForgotPasslb_Click"></asp:LinkButton>
                            <br />
                            <br />
                            <asp:Button Text="Logon" runat="server" ID="Loginbtn" OnClick="Loginbtn_Click"/>
                        </asp:Panel>
                        <br />
                        <asp:Panel class="well" id="Posts" runat="server">
                            
                        
                        </asp:Panel>
                        <!--/.well -->
                    </div>
                    <!--/sidebar-nav-fixed -->
                </div>
                <!--/span-->
                <asp:Panel class="col-md-8 col-lg-8 col-sm-8 col-xs-12 span-8" id="Content" runat="server">
                    

                </asp:Panel>
                <!--/span-->
                <div class="col-md-2 col-lg-2 col-sm-2 col-xs-12 span-2" id="RightSide">
                    <br />
                    <br />
                    <div class="sidebar-nav-fixed">
                        <div id="Ad">
                        </div>
                        <br />
                        <div class="well" >
                            
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
    <!--/.fluid-container-->
</body>
</html>
