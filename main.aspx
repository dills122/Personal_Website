<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="main" MasterPageFile="~/MasterPage.master" %>



<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <asp:Panel ID="Mainpnl" runat="server" HorizontalAlign="Center">
        <div style="text-align: left">
            <h2><b>Welcome to my site</b></h2>
        </div>
        <br />
        <div style="text-align: left">
            <p style="font-family: Verdana; font-size: large;">
                My name is Dylan Steele, I am currently a Computer Science Student at Indiana University of Pennsylvania.
                <br />
                I also attended Pennsylvania State University at the DuBois and University Park Campuses. 
            </p>
            <br />
            <br />
        </div>
        <div style="width: auto; text-align: center; border-top: solid 2px; border-top-color: black;"></div>

        <br />
        <br />
        <div class="container">
            <div class="row">
                <div class="col-xs-6" style="text-align: left;" >
                    <h2 style="font-family: Verdana; font-size: x-large;"><b>Know languages:</b> </h2>
                    <p style="font-family: Verdana; font-size: larger">
                        <br />
                        Proficient:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Java, VB.NET, C++, C#, SQL, HTML\CSS, and ASP.NET
                    </p>
                    <p style="font-family: Verdana; font-size: larger">
                        Familiar with:&nbsp;&nbsp;C, Python, and JavaScript
                    </p>
                </div>
                <div class="col-xs-6" style="text-align: left;">
                    <h2 style="font-family: Verdana; font-size: x-large;"><b>Other Skills:</b> </h2>
                     <p style="font-family: Verdana; font-size: larger">
                        IDEs, Environments, etc: &nbsp;&nbsp;Visual Studios, SQL Manegment Studios, Viso, Eclipse, and bash/terminal
                    </p>
                    <p style="font-family: Verdana; font-size: larger">
                        <br />
                        Operating Systems:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Windows(XP and newer), macOS, and Linux (Ubuntu and Debian)
                    </p>
                   
                </div>
            </div>
        </div>
        <div style="height: 40px"></div>
    </asp:Panel>


</asp:Content>

