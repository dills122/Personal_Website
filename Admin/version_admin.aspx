<%@ Page Language="C#" AutoEventWireup="true" CodeFile="version_admin.aspx.cs" Inherits="Admin_version_admin" MasterPageFile="~/Master_Pages/Admin.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script src="../Scripts/ckeditor/ckeditor.js"></script>
    <style>
        .cal-img {
            height: 2.75em;
            width: auto;
            margin-bottom: -1em;
        }

        .peterriver {
            margin-right: 10px;
            width: 100px;
            background: #3498db;
            border-bottom: #2980b9 3px solid;
            border-left: #2980b9 1px solid;
            border-right: #2980b9 1px solid;
            border-radius: 6px;
            text-align: center;
            color: white;
            padding: 10px;
            float: left;
            font-size: 12px;
            font-weight: 800;
        }

            .peterriver:hover {
                opacity: 0.8;
            }

            .peterriver:active {
                width: 100px;
                background: #2385C7;
                border-bottom: #2980b9 1px solid;
                border-left: #2980b9 1px solid;
                border-right: #2980b9 1px solid;
                border-radius: 6px;
                text-align: center;
                color: white;
                padding: 10px;
                margin-top: 3px;
                float: left;
            }

        .center {
            display: flex;
            justify-content: center;
            flex-direction: column;
            align-items: center;
        }

        .padding {
            padding: 1em;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent"  runat="server">
    <asp:Panel ID="Mainpnl" runat="server">
        <div><span>Feed Management</span></div>
        <br />
        <hr />

        <form runat="server">
            <asp:ScriptManager ID="MainScriptManager" runat="server" />
            <div class="padding">
                <span>Announcement/Change Log Title: </span>
                <asp:TextBox ID="Titletxt" runat="server" placeholder="Title.."></asp:TextBox>
            </div>
            <div class="padding">
                <span>Version: </span>
                <asp:TextBox ID="versiontxt" runat="server" placeholder="Version.."></asp:TextBox>
            </div>
            <br />
            <br />
            <div>
                <CKEditor:CKEditorControl ID="CKEditor1" BasePath="/ckeditor/" runat="server">
                </CKEditor:CKEditorControl>
            </div>
            <br />
            <br />
            <div class="center">
                <div class="padding">
                    <span>Post Date: </span>
                    <asp:TextBox ID="txtDate" runat="server" ReadOnly="true"></asp:TextBox>
                    <asp:ImageButton ID="imgPopup" ImageUrl="~/Images/calendar.png" CssClass="cal-img"
                        runat="server" />
                    <cc1:CalendarExtender ID="Calendar1" PopupButtonID="imgPopup" runat="server" TargetControlID="txtDate" 
                        Format="MM/dd/yyyy"></cc1:CalendarExtender>
                </div>
                <div class="padding">
                    <asp:Button ID="Postbtn" runat="server" CssClass="peterriver" Text="Post" CommandName="Insert" OnClick="Postbtn_Click" />
                    <asp:Label ID="Errorlb" runat="server"  Visible="false"></asp:Label>
                </div>
            </div>
        </form>
    </asp:Panel>
</asp:Content>