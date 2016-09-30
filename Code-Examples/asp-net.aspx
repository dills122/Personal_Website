<%@ Page Language="C#" AutoEventWireup="true" CodeFile="asp-net.aspx.cs" Inherits="Code_Examples_asp_net" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <style>

    </style>
    <div class="center-block">
        <img src="../Pictures/manage_yty_graphic.PNG" style="width: 75%; height: 75%" class="center-block"/>
        <p>
            This page generates tables for each section within a part of the COPOS report. The tables display year to year variances for each question
        on the page starting from the current report year all the way to the first report year. Each cell on the table is color coded based on its
        year to year variance value red for negative variance from the previous to the current year, green for positive variance N/A if there isn't an
        older report avaliable or if information wasn't reported, and light grey for no variance.
        </p>
        <br />
        <br />
        <img src="../Pictures/Manage%20Initiatives.PNG" style="width: 75%; height: 75%" class="center-block" />
        <p>
            This page was created to create new initiavies, which are a new type of report that is currently being investigated as a possible replacement
        for the current COPOS report. From this page you can create a new initative, add manage report years (when a new report is created it will 
        automatically add the current report year), add new strategies to the selected report year, and add new indicators to each strategies. This page
        creates a structure that the system then uses to generate an initiative report that looks like the image below.  
        </p>
        <br />
        <br />
        <img src="../Pictures/Initiative_Report_Page.PNG" style="width: 75%; height: 75%" class="center-block" />
        <p>
            This is an example of a generated initiative report page that was created from the rules defined by the management page above.
        </p>
    </div>
</asp:Content>
