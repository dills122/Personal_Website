<%@ Page Language="C#" AutoEventWireup="true" CodeFile="feed.aspx.cs" Inherits="feed" MasterPageFile="~/Master_Pages/main.master" %>

<asp:Content ContentPlaceHolderID="HeaderAreacp" runat="server">
    <link href="https://fonts.googleapis.com/css?family=El+Messiri" rel="stylesheet">
    <style>
        .feed-container {
            display: block;
            width: 100%;
            height: auto;
            text-align: left;
            margin-top: 3em;
            margin-bottom: 3em;
            font-family: 'El Messiri', sans-serif;
        }

        .feed-header {
            font-size: 1.5em;
            margin-left:5em;
        }

        .post-date {
            font-size: .8em;
            margin-left:7em;
        }

        .hr-div {
            width: 80%;
            margin: 0 auto;
            height: .175em;
            background-color:#f5f5f5;
            border-radius: 10px;

        }

        .feed-description {
            font-size:1.25em;
            margin-left:6em;
            padding-top:.5em;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContentcp" runat="server">
    <asp:Panel ID="FeedContentpnl" runat="server"></asp:Panel>
</asp:Content>
