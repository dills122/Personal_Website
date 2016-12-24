﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="user.aspx.cs" Inherits="Forums_user" %>

<!DOCTYPE html>

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
            font-weight:500;
            font-family:Arial;
            font-size:medium;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="NewUser">
        <div style="text-align: center">
            <h2>New User</h2>
        </div>
        <div style="width: 30%; margin: auto" >

            <div>
                <span class="alignleft">First Name: </span>
                <input type="text" id="FName" class="alignright" />

            </div>
            <div style="clear: both;"></div>
            <br />
            <div>
                <span class="alignleft">Last Name: </span>
                <input type="text" id="LName" class="alignright" />

            </div>
            <div style="clear: both;"></div>
            <br />
            <div>
                <span class="alignleft">UserID: </span>
                <input type="text" id="UserID" class="alignright" />

            </div>
            <div style="clear: both;"></div>
            <br />
            <div>
                <span class="alignleft">Password: </span>
                <input type="password" id="Pass" class="alignright" />

            </div>
            <div style="clear: both;"></div>
            <br />
            <div>
                <span class="alignleft">Confirm Password: </span>
                <input type="password" id="ConfirmPass" class="alignright" />

            </div>
            <div style="clear: both;"></div>
            <br />
            <div>
                <span class="alignleft">Email: </span>
                <input type="password" id="Email" class="alignright" />

            </div>
            <div style="clear: both;"></div>
            <br />
            <div>
                <span class="alignleft">Confirm Email: </span>
                <input type="password" id="ConfirmEmail" class="alignright" />

            </div>
            <div style="clear: both;"></div>
            <br />
            <br />
        </div>
            </div>
        <div id="ForgotPass">

        </div>
    </form>
</body>
</html>
