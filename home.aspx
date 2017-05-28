<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="./css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <title>Dylan Steele</title>
    <style type="text/css">
        .super-container {
           /*background-color:#7f8c8d;*/
        }
        .header-row {
            height:5em;
        }
        .main-row {
            margin:0 auto;
            padding:0;
            width:100%;
            height:100%;
        }
        .left-bar {

        }
        .right-bar {

        }
        .content-area {

        }
        .link-well {
            display:block;
            width:96%;
            margin:0 auto;
            border-radius: 12px;
            text-align:center;
            margin-top:3.5em;
            
            background-color:#EFEFEF;
        }
    </style>
</head>
<body>
    <div class="container-fluid super-container" id="super-container">
        <div class="header-row row" id="header-row">

        </div>
        <div class="row main-row col-sm-12 col-md-12 col-lg-12 col-xs-12" id="content-row">
            <div class="left-bar col-lg-2 col-md-2 col-sm-12 col-xs-12" id="left-bar">
                <div  class="link-well well-lg">
                    <span>Useful Links</span><br />
                    <a href="#">Link 1</a><br />
                    <a href="#">Link 2</a><br />
                    <a href="#">Link 3</a><br />
                    <a href="#">Link 4</a><br />
                </div>
                <div  class="link-well well-lg">
                    <span>Useful Links</span><br />
                    <a href="#">Link 1</a><br />
                    <a href="#">Link 2</a><br />
                    <a href="#">Link 3</a><br />
                    <a href="#">Link 4</a><br />
                </div>
                <div class="ad-well well-lg">

                </div>
            </div>
            <div class="content-area col-lg-8 col-sm-12 col-md-8 col-xs-12" id="content-area">
                <!-- Content Area -->
            </div>
            <div class="right-bar col-lg-2 col-md-2 col-sm-12 col-xs-12" id="right-bar">
                <div  class="link-well well-lg">
                    <span>Useful Links</span><br />
                    <a href="#">Link 1</a><br />
                    <a href="#">Link 2</a><br />
                    <a href="#">Link 3</a><br />
                    <a href="#">Link 4</a><br />
                </div>
                <div  class="link-well well-lg">
                    <span>Useful Links</span><br />
                    <a href="#">Link 1</a><br />
                    <a href="#">Link 2</a><br />
                    <a href="#">Link 3</a><br />
                    <a href="#">Link 4</a><br />
                </div>
                <div class="ad-well well-lg">

                </div>
            </div>
        </div>



    </div>
</body>
</html>
