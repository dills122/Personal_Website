<%@ Page Language="C#" AutoEventWireup="true" CodeFile="calculator.aspx.cs" Inherits="Other_Pages_calculator" MasterPageFile="~/MasterPage.master" %>


<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <div style="text-align:center">
    <h2>Calculator</h2>
    <p style="font-size: medium; text-align: center; width:75%; margin:auto;">
        A calculator I created for a class in college. This calculator uses the mXparser library for equation computing. 
        <a href="http://mathparser.org/">mXparser</a> This calculator can compute all types of reqular arithmetic expressions.
        It also has a small scientific panel that has trig functions, square roots, log, and modulus buttons. The differing factor
        of this calculator is that it has a pop out history panel for displaying the history of the calculator. On the history panel
        there is a button that allows the user to export their history to a text file that is placed on the desktop. 
    </p>
    <br />
    <br />
    <img src="../Pictures/Calculator.PNG" style="width: 50%; height: 50%" class="center-block" />

    <br />
    <br />
    <div style="text-align: center">
        <h4>The calculator can be downloaded here: </h4>
        <a href="../Documents/COSC-Calculator.exe">Calculator Ver 1.0</a>
        <br />
        <br />

    </div>
    </div>
</asp:Content>
