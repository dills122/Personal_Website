<%@ Page Language="C#" AutoEventWireup="true" CodeFile="title.aspx.cs" Inherits="title" %>

<!DOCTYPE html>
<html lang="en-us">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://fonts.googleapis.com/css?family=PT+Sans|Playfair+Display|Space+Mono" rel="stylesheet">
    <link href="css/ionicons.css" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" >
    <script src="js/jquery-3.1.1.min.js"></script>
	<script src="js/title.js"></script>
	<link rel="stylesheet" href="css/title.css">
</head>

<body>
	<div class="super-container" id="super-container">
		<div class="row-column" id="title-page">
			<div class="social-container">
				<a href="http://www.facebook.com" target="_blank"><i class="ion-social-facebook"></i></a>
				<a href="https://github.com/dills122" target="_blank"><i class="ion-social-github"></i></a>
				<a href="https://www.instagram.com/dills122/" target="_blank"><i class="ion-social-instagram-outline"></i></a>
				<a href="https://www.linkedin.com/in/dssteele122/" target="_blank"><i class="ion-social-linkedin"></i></a>
                <a href="https://stackoverflow.com/users/4962223/dylan-steele" target="_blank"><i class="fa fa-stack-overflow" ></i></a>
			</div>
			<div class="title-container">
				<span class="title-text">Dylan Steele</span><br/><br/>
				<span class="title-text">Bachelor of Computer Science</span><br/><br/>
				<span class="title-text">Indiana University of PA</span><br/><br/>
				<span class="title-text">Pennsylvania State University</span><br/><br/>
				<span class="title-text">IT Inern, Web Developer</span><br/><br/>
			</div>
		</div>
		<div class="row" id="about-page">
			<div class="column" id="description-col">
				<span class="body-title">Languages</span><br/><br/>
				<div class="text-area">
					<span>Proficient: C#,VB.NET, ASP.NET, HTML/CSS, SQL, Java, XML, JSON</span><br/><br/>
					<span>Familiar with: Javascript, JQuery, PHP, C, Python, C++, Shell Scripting, Bootstrap lib</span><br/><br/>
					<span>Currently learning: Go</span>
				</div>
				<br/><br/><br/><br/>
				<span class="body-title">Experience</span><br/><br/>
				<div class="text-area">
					<span>Community Action, Inc.</span><br/>
					<span>IT Intern -- June 2016 - Current</span><br/>
					<span>Languagues Used: ASP.NET, C#, VB.NET, JavaScript, JQuery, Ajax, SQL </span><br/><br/>
					<span>Responsibilities:</span><br/>
					<ul>
						<li>	
							Design, maintain, develop, and document for COPOS Websystem
						</li>
						<li>
							Assist employees with IT issues
						</li>
						<li>
							Create new internal features and systems as needed
						</li>

					</ul>
				</div>
			</div>
			<div class="column" id="accordian-col">
				<div class="accordion">
					<div class="accordion-section">
						<a class="accordion-section-title" href="#accordion-1">C#</a>
						<div id="accordion-1" class="accordion-section-content">
							<a href="https://github.com/dills122/Stock-Trader-Client">Stock Trader Simulator Client</a>
						</div><!--end .accordion-section-content-->
                        <div id="accordion-1" class="accordion-section-content">
							<a href="https://github.com/dills122/TraderEngine">Stock Trader Simulator Engine</a>
						</div><!--end .accordion-section-content-->
						<div id="accordion-1" class="accordion-section-content">
							<a href="home.aspx?XID=1">Hash Checker</a>
						</div><!--end .accordion-section-content-->
						<div id="accordion-1" class="accordion-section-content">
							<a href="https://github.com/dills122/COSC-319-Calculator">Scientific Calculator</a>
						</div><!--end .accordion-section-content-->
					</div><!--end .accordion-section-->

					<div class="accordion-section">
						<a class="accordion-section-title" href="#accordion-2">Java</a>
						<div id="accordion-2" class="accordion-section-content">
							<a href="https://github.com/tlutz24/Asteroid-Invaders">Astroid Invaders</a>
						</div><!--end .accordion-section-content-->
					</div><!--end .accordion-section-->

					<div class="accordion-section">
						<a class="accordion-section-title" href="#accordion-3">Python</a>
						<div id="accordion-3" class="accordion-section-content">
							<a href="https://github.com/dills122/Random-Dungeon-Creator">Random Dungeon Generator</a>
						</div><!--end .accordion-section-content-->
					</div><!--end .accordion-section-->
					<div class="accordion-section">
						<a class="accordion-section-title" href="#accordion-4">Websites/Websystems</a>
						<div id="accordion-4" class="accordion-section-content">
							<a href="home.aspx?XID=3">Task Scheduler</a>
						</div><!--end .accordion-section-content-->
						<div id="accordion-4" class="accordion-section-content">
							<a href="#">Amortization Table</a>
						</div><!--end .accordion-section-content-->
					</div><!--end .accordion-section-->
				</div><!--end .accordion-->
			</div>
		</div>
		<div class="half-row" id="footer-page">
			<div class="column-half" id="footer-col">
				<div class="thick-line"><span>Dylan Steele</span></div>
				<!-- Link Row Container -->
				<div class="link-container">
					<div class="link-cell">
						<span>Professional</span>
						<a href="http://www.psu.edu">Penn State University</a>
						<a href="http://www.iup.edu">Indiana University of Pennsylvania</a>
						<a href="http://www.jccap.org">Community Action, Inc.</a>
					</div>
					<div class="link-cell">
						<span>Social</span>
						<a href="https://stackoverflow.com/users/4962223/dylan-steele">Stack Overflow</a>
						<a href="https://github.com/dills122">Github</a>
						<a href="www.linkedin.com/in/dssteele122">Linkedin</a>
					</div>
					<div class="link-cell">
						<span>Nice Sites</span>
						<a href="http://codingheroes.io/resources/">Website Design Tools</a>
						<a href="https://www.codeproject.com/">Code Project</a>
						<a href="https://www.dotnetperls.com/">Dot Net Perls</a>
						<a href="https://www.codeschool.com/">Code School</a>
					</div>
				</div>
				<div style="width: 100%;height: .25em; background-color:#CAEBF2; margin-top: 1em; margin-bottom: 1em;"></div>
				<div class="link-container">
					<div class="link-cell">
						<span>Files</span>
						<a href="#">Resume</a>
						<a href="#">Code Example</a>
						<a href="home.aspx">Projects</a>
					</div>
				</div>
			</div>
			<div class="column-half" id="contact-col">
				<div class="form-style-5">
					<form runat="server" id="form1">
						<fieldset>
							<legend><span class="number">1</span> Contact Me</legend>
							<input type="text" name="field1" placeholder="Your Name *" runat="server" id="nametxt">
							<input type="email" name="field2" placeholder="Your Email *" runat="server" id="emailtxt">
							<textarea name="field3" placeholder="Body" runat="server" id="bodytxt"></textarea>
							<asp:Button  ID="Contactbtn" type="submit" Text="Apply" runat="server" OnClick="Contactbtn_Click" />
                            <div class="error-lb"><asp:Label ID="errorlb" runat="server" Visible="false" ></asp:Label></div>
						</form>
					</div>
				</div>
			</div>
		</div>
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-84828906-1', 'auto');
        ga('send', 'pageview');

    </script>
</body>
    
</html>
