<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="main" MasterPageFile="~/MasterPage.master" %>



<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <script src="js/fusioncharts.js"></script>

    <script type="text/javascript">
  FusionCharts.ready(function(){
    var fusioncharts = new FusionCharts({
    type: 'bar2d',
    renderAt: 'chart-container',
    width: '500',
    height: '300',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "Programming Skills",
            "subCaption": "Most used",
            "yAxisName": "Proficiency",
            "paletteColors": "#0075c2",
            "bgColor": "#ffffff",
            "showBorder": "0",
            "showCanvasBorder": "0",
            "usePlotGradientColor": "0",
            "plotBorderAlpha": "10",
            "valueFontColor": "#ffffff",
            "showAxisLines": "1",
            "showYAxisValues":'0',
            "axisLineAlpha": "25",
            "divLineAlpha": "10",
            "alignCaptionWithCanvas": "0",
            "showAlternateVGridColor": "0",
            "captionFontSize": "14",
            "subcaptionFontSize": "14",
            "subcaptionFontBold": "0",
            "toolTipColor": "#ffffff",
            "toolTipBorderThickness": "0",
            "toolTipBgColor": "#000000",
            "toolTipBgAlpha": "80",
            "toolTipBorderRadius": "2",
            "toolTipPadding": "5"
        },

        "data": [{
            "label": "VB.NET",
            "value": "775",
            "showValue": "0"
        }, {
            "label": "Java",
            "value": "650"
        }, {
            "label": "ASP.NET",
            "value": "600"
        }, {
            "label": "HTML/CSS",
            "value": "600"
        }, {
            "label": "C++",
            "value": "600"
        }, {
            "label": "C#",
            "value": "550"
        }]
    }
}
);
    fusioncharts.render();
});
</script>

    <asp:Panel ID="Mainpnl" runat="server" HorizontalAlign="Center">
        <div style="margin-left: auto; margin-right: auto">
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
                    <div class="col-xs-6" style="text-align: left;">
                        <h2 style="font-family: Verdana; font-size: x-large;"><b>Know languages:</b> </h2>
                        <p style="font-family: Verdana; font-size: larger">
                            Proficient:
                        </p>
                        <ul style="font-size: medium">
                            <li>Java</li>
                            <li>VB.NET</li>
                            <li>C++</li>
                            <li>C#</li>
                            <li>SQL</li>
                            <li>HTML\CSS</li>
                            <li>ASP.NET</li>
                        </ul>
                        <p style="font-family: Verdana; font-size: larger">
                            Familiar with:
                        </p>
                        <ul style="font-size: medium">
                            <li>C</li>
                            <li>Python</li>
                            <li>JavaScript</li>
                        </ul>
                    </div>
                    <div class="col-xs-6" style="text-align: left;">
                        <h2 style="font-family: Verdana; font-size: x-large;"><b>Other Skills:</b> </h2>
                        <p style="font-family: Verdana; font-size: larger">
                            IDEs, Environments, etc:
                        </p>
                        <ul style="font-size: medium">
                            <li>Visual Studios</li>
                            <li>SQL Manegment Studio</li>
                            <li>Viso</li>
                            <li>Eclipse</li>
                            <li>bash/terminal</li>
                        </ul>
                        <p style="font-family: Verdana; font-size: larger">
                            <br />
                            Operating Systems:
                        </p>
                        <ul style="font-size: medium">
                            <li>Windows(XP and newer)</li>
                            <li>macOS</li>
                            <li>Linux (Ubuntu and Debian)</li>
                        </ul>
                    </div>
                </div>
                <div class=" row">
                    <div class="col-xs-12" style="text-align: left;">
                        <!-- <div id="chart-container">FusionCharts XT will load here!</div> -->


                        </div>
                </div>
            </div>
            <div style="height: 40px"></div>
        </div>
    </asp:Panel>


</asp:Content>

