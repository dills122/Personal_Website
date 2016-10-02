<%@ Page Language="C#" AutoEventWireup="true" CodeFile="asp-net.aspx.cs" Inherits="Code_Examples_asp_net" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <br />
    <br />
    <style>
        p {
            font-size: medium;
            text-align: center;
            margin: 2cm;
            font-weight:600;
        }
    </style>
    <div class="center-block">
        <img src="../Pictures/manage_yty_graphic.PNG" style="width: 75%; height: 75%" class="center-block" />
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
        <br />
        <br />
        <img src="../Pictures/download%20report%20content.PNG" style="width: 75%; height: 75%" class="center-block" />
        <p>
            This page is used to download all different types of the reports on the COPOS system. I added the functionality of being able to download 
            the reports from this page. Before the only method of reception was being emailed the PDFs. Since creating PDFs on our system takes time,
            the page opens another page that handles the download so that the user may navigate away from the page or download addition reports, while 
            they wait for the PDF to download.
        </p>
        <br />
        <br />
        <img src="../Pictures/Organizational%20Standards%20Summary.PNG" style="width: 75%; height: 75%" class="center-block" />
        <br />
        <img src="../Pictures/Summary%20Sorting.png" style="width: 25%; height: 25%" class="center-block" />
        <p>
            This page displays information for each Organziation whether they met, not met, or haven't started each section of the COPOS report. 
            I added the ability for this graphic to be sorted by all of the different methods in the picture above. 
        </p>
        <br />
        <br />
        <img src="../Pictures/Rule%20Creator.PNG" style="width: 75%; height: 75%" class="center-block"/>
        <br />
        <img src="../Pictures/Rule%20Creator%20Table.PNG" style="width: 75%; height: 75%" class="center-block"/>
        <p>
            This page is used to create rules for various functions on COPOS. Originally these rules were planned to be used for creating graphics, but
            they have been found to be useful in many other functions. However, they are mainly used for creating graphics, such as year highlights reports,
            pamphlets/handouts for conferences, and other reports. One of the functions we use them for specifically is Google Charts. 
        </p>
    </div>
    <br />
    <br />
</asp:Content>
