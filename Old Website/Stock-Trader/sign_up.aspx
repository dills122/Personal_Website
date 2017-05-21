<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sign_up.aspx.cs" Inherits="Stock_Trader_sign_up" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <script src="../js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript">
        function checkPasswordMatch() {
            var password = $("#Passwordtb").val();
            var confirmPassword = $("#VPasswordtb").val();
            var lb = document.getElementById("Passmessage");
            if (password != confirmPassword) {
                $("#Passmessage").html("Passwords do not match!");
                lb.style.color = "#ff0000";
            }

            else {
                $("#Passmessage").html("Passwords match.");
                lb.style.color = "#00e600";
            }
        }


        $(document).ready(function () {
            $("#VPasswordtb").keyup(checkPasswordMatch);
        });

        $(document).ready(function () {
            $("#Passwordtb").keyup(function () {
                var lb = document.getElementById("MetRequirements");
                var btn = document.getElementById("Submitbtn");
                if (/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#Passwordtb").val()) == true) {
                    lb.innerHTML = "Requirements Met";
                    lb.style.color = "#00e600";
                    btn.disabled = false;
                }
                else {
                    lb.innerHTML = "Requirements Not Met";
                    lb.style.color = "#ff0000";
                    btn.disabled = true;
                }
            });
        });

        //Add in code to validate emails 
    </script>
    <form runat="server">
        <link href="../css/Stock.css" rel="stylesheet" />
        <div class="padding">
            <div class="stock-container padding">
                <div class="float-left">
                    <asp:Label runat="server" Text="First Name: "></asp:Label>
                </div>
                <div class="float-right">
                    <asp:TextBox ID="Fnametb" runat="server" ClientIDMode="Static"></asp:TextBox>
                </div>
                <div class="clear"></div>
            </div>
            <div class="stock-container padding">
                <div class="float-left">
                    <asp:Label runat="server" Text="Last Name: "></asp:Label>
                </div>
                <div class="float-right">
                    <asp:TextBox ID="Lnametb" runat="server" ClientIDMode="Static"></asp:TextBox>
                </div>
                <div class="clear"></div>
            </div>
            <div class="stock-container padding">
                <div class="float-left">
                    <asp:Label runat="server" Text="Username: "></asp:Label>
                </div>
                <div class="float-right">
                    <asp:TextBox ID="Usernametb" runat="server" ClientIDMode="Static"></asp:TextBox>
                </div>
                <div class="clear"></div>
            </div>
            <div class="stock-container padding">
                <div class="float-left">
                    <asp:Label runat="server" Text="Password: "></asp:Label>
                </div>
                <div class="float-right">
                    <asp:TextBox ID="Passwordtb" runat="server" ClientIDMode="Static" TextMode="Password"></asp:TextBox>
                </div>
                <div class="clear"></div>
            </div>
            <div class="stock-container padding">
                <div class="float-left">
                    <asp:Label runat="server" Text="Verify Password: "></asp:Label>
                </div>
                <div class="float-right">
                    <asp:TextBox ID="VPasswordtb" runat="server" ClientIDMode="Static" TextMode="Password"></asp:TextBox>
                </div>
                <div class="clear"></div>
            </div>
            <div class="stock-container center">
                <asp:Label ID="Passmessage" runat="server" ClientIDMode="Static"></asp:Label>
                <br />
                <asp:Label id="MetRequirements" style="text-align: center" runat="server" ClientIDMode="Static"></asp:Label>
            </div>
            <div class="center padding">
                <asp:Button ID="Submitbtn" runat="server" Text="Signup" OnClick="Submitbtn_Click" ClientIDMode="Static" />
                <br />
                <asp:Label ID="Resultlb" runat="server"></asp:Label>
            </div>
        </div>
    </form>
</asp:Content>
