<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" MasterPageFile="~/Master_Pages/main.master" %>

<asp:Content ContentPlaceHolderID="HeaderAreacp" runat="server">
    <style>
        .bottom-padding {
            padding-bottom: 10em;
        }

        .large-header {
            text-align: center;
            font-family: 'Space Mono', monospace;
            font-size: 3.5em;
            padding-top:1.25em;
        }

        .smaller-header {
            text-align: center;
            font-family: 'Space Mono', monospace;
            font-size: 2.5em;
        }

        .four-img {
            display:block;
            text-align: center;
            margin: auto;
            width: auto;
            height: auto;
            padding-left:5em;
        }
        .four-img img {
            display:block;
            margin: auto;
            width:auto;
            height:auto;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContentcp" runat="server">
    <asp:Panel ID="contentpnl" runat="server">
        <div class="large-header"><span>Woop! 404</span></div>
        <div class="four-img">
            <img src="Images/zoidberg.png" />
        </div>
        <br />

        <div class="smaller-header"><span>Project Not Found</span></div>
    </asp:Panel>
    <div class="bottom-padding">
    </div>
</asp:Content>
