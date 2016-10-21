<%@ Page Language="C#" AutoEventWireup="true" CodeFile="java.aspx.cs" Inherits="Code_Examples_java" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <link rel="stylesheet" href="../css/foundation.css">
    <script src="../js/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <br />
    <br />
    <div style="text-align:center;">
    <h2>Astroid Invaders</h2>
    <p style="font-size: medium; text-align: center; width:75%; margin:auto;">
        I helped develop a game in Java using Java Swing for a class in College. 
        <a href="https://github.com/tlutz24/Asteroid-Invaders">Astroid Invaders</a>
        This game allows the user to move in all directions until they hit the invisible wall. 
        Before the invisible there are anchored walls that can be used by the player to hid from 
        the astroids that fall from the sky. However, these walls degrade and disappear.
        The astroid generation increases as the game progresses. There are three different sizes of 
        astroids in the game, as you destroy the bigger astroids they break in to multiple smaller astroids.
    </p>
    <br />
    <br />
    <img src="../Pictures/Loading_Screen.PNG" style="width:45%; margin:auto; float:left;" /> <img src="../Pictures/Game.PNG" style="width:45%; margin:auto; float:right;"/>
</div>
    <br />
    <br />
    <br />
    <br />
</asp:Content>
