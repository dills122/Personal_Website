<%@ Page Language="C#" AutoEventWireup="true" CodeFile="user.aspx.cs" Inherits="Forums_user" %>

<!DOCTYPE html>
<script src="../js/jquery-3.1.1.min.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .alignleft {
            float: left;
        }

        .alignright {
            float: right;
        }

        span {
            font-weight: 500;
            font-family: Arial;
            font-size: medium;
        }

        .alignCenter {
            text-align: center;
        }

        .Incorrect {
            border: solid #cc0000;
        }

        #passstrength {
            color: red;
            font-family: verdana;
            font-size: 10px;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        function checkPasswordMatch() {
            var password = $("#Pass").val();
            var confirmPassword = $("#ConfirmPass").val();
            var lb = document.getElementById("PassMessage");
            if (password != confirmPassword) {
                $("#PassMessage").html("Passwords do not match!");
                lb.style.color = "#ff0000";
            }

            else {
                $("#PassMessage").html("Passwords match.");
                lb.style.color = "#00e600";
            }
        }


        $(document).ready(function () {
            $("#ConfirmPass").keyup(checkPasswordMatch);
        });

        $(document).ready(function () {
            $("#Pass").keyup(function () {
                var lb = document.getElementById("MetRequirements");
                if (/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#Pass").val()) == true) {
                    lb.innerHTML = "Requirements Met";
                    lb.style.color = "#00e600";
                    $("#Validationlb").text("true");
                }
                else {
                    lb.innerHTML = "Requirements Not Met";
                    lb.style.color = "#ff0000";
                    $("#Validationlb").text("false");
                }
            });
        });

        //Add in code to validate emails 
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="NewUser">
            <div style="text-align: center">
                <h2>New User</h2>
            </div>
            <div style="width: 30%; margin: auto">

                <div>
                    <span class="alignleft">First Name: </span>
                    <input type="text" id="FName" class="alignright" runat="server" />

                </div>
                <div style="clear: both;"></div>
                <br />
                <div>
                    <span class="alignleft">Last Name: </span>
                    <input type="text" id="LName" class="alignright" runat="server" />

                </div>
                <div style="clear: both;"></div>
                <br />
                <div>
                    <span class="alignleft">UserID: </span>
                    <input type="text" id="UserID" class="alignright" runat="server" />

                </div>
                <div style="clear: both;"></div>
                <br />
                <div>
                    <span class="alignleft">Password: </span>
                    <input type="password" id="Pass" name="Pass" class="alignright" runat="server" />

                </div>
                <div style="clear: both;"></div>
                <br />
                <div>
                    <span class="alignleft">Confirm Password: </span>
                    <input type="password" id="ConfirmPass" class="alignright" runat="server" />

                </div>
                <div style="clear: both;"></div>
                <div style="text-align: center">
                    <br />
                    <span id="PassMessage" style="text-align: center;"></span>&nbsp;&nbsp;&nbsp;&nbsp;
                    <span id="MetRequirements" style="text-align: center"></span>
                </div>
                <br />
                <div>
                    <span class="alignleft">Email: </span>
                    <input type="text" id="Email" class="alignright" runat="server" />

                </div>
                <div style="clear: both;"></div>
                <br />
                <div>
                    <span class="alignleft">Confirm Email: </span>
                    <input type="text" id="ConfirmEmail" class="alignright" runat="server" />

                </div>
                <div style="clear: both;"></div>
                <br />
                <br />
                <div align="center">
                    <asp:Button ID="SubNewUserbtn" Text="Submit" runat="server" OnClick="SubNewUserbtn_Click" CssClass="alignCenter" ClientIDMode="Static" />
                    <asp:Label style="display: none" id="Validationlb" runat="server"></asp:Label>
                </div>
            </div>

        </div>
        <div id="ForgotPass">
        </div>
        <br />
        <div style="text-align: center; margin: auto">
            <asp:Label ID="Errorlb" Visible="false" Text="Complete every field" runat="server" Font-Bold="true" ForeColor="Red" Style="text-align: center"></asp:Label>
            <br />
        <asp:Label ID="Requirementlb" Visible="false" Text="Password Requirement Not Meet" runat="server" Font-Bold="true" ForeColor="Red" Style="text-align: center"></asp:Label>
        </div>
    </form>
</body>
</html>
