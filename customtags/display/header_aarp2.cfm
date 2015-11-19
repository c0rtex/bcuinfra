<HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
</cfif>
<script language="JavaScript" src="ValidationFunctions.js"></script>
<cfset title="">
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>
<cfif Find("index.cfm", BasePath) gt 0>
	<cfset title="Benefits QuickLINK - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelseif Find("before_you_start.cfm", BasePath) gt 0>
	<cfset title="Benefits QuickLINK">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title="Benefits QuickLINK">
	<cfset AddBanner="No">
</cfif>
<style type="text/css" media="all">
<!--//

div#aarpPartnerToolbar {
	margin: 0;
	padding: 0;
}

div#aarpPartnerToolbar {
	border-bottom:4px solid #6b6b6b;
	margin: 0;
	padding: 0;
	width: 770px;
	margin-bottom: 0;
	font: 76% Arial, Verdana, Helvetica, sans-serif;	
}
div#aarpPartnerToolbar div.clearer {
	clear: both;
	line-height: 0;
}
#aarpPartnerToolbar a:link {
	color: #009;
	padding: 2px;
}
#aarpPartnerToolbar a:visited {
	color: #909;
	padding: 2px;
}
#aarpPartnerToolbar a:hover {
	color: #FFF;
	padding: 2px;
	text-decoration: none;
	background: #009;
}
#aarpPartnerToolbar a:active {
	color: #FFF;
	padding: 2px;
	text-decoration: none;
	background: #909;
}
#aarpPartnerToolbar a.button:link, div#aarpPartnerToolbar a.button:hover, div#aarpPartnerToolbar a.button:active, div#aarpPartnerToolbar a.button:visited {
	padding: 0;
	text-decoration: none;
	background: transparent;
}

div#aarpPartnerToolbar * {
	font-family: Arial, Verdana, Helvetica, sans-serif;

}

div#aarpPartnerToolbar ol, ul, li {
	font-family: Arial, Verdana, Helvetica, sans-serif;
	margin-top: 0.2em;
	margin-bottom: 0.1em;
	text-align: left;
}

div#aarpPartnerToolbar li > p {
	margin-top: 0.2em;
}

#globalNav {
	color: #FFF;
	font-size: 0.99em;
	padding: 2px;
	background: #6B6B6B;

}
#globalNav a:link, #globalNav a:visited {
	color: #FFF;
	text-decoration: underline;
	font-weight: bold;
	padding: 2px;
}
#globalNav a:hover, #globalNav a:active {
	color: #6B6B6B;
	background: #FFF;
}
div#aarpPartnerToolbar #languageToggle {
	float: right;
}
#brandingSearch {
	border-top: dotted 2px #333;
	padding: 6px 4px;
	color: #424141;
	background: #FFF;
}
#brandingSearch a:link, #brandingSearch a:visited {
	padding: 2px;
	color: #424141;
}
#brandingSearch a:hover, #brandingSearch a:active {
	padding: 2px;
	color: #FFF;
	background: #424141;
}
div#aarpPartnerToolbar #logo {
	float: left;
}
#brandingSearch #search {
	margin-top: 20px;
	font-size: 1.0em;
	color: #000;
}
#brandingSearch #keywords {
	width: 205px;
	font-size: 11px;
	font-weight: normal;
}
#brandingSearch #go {
	vertical-align: top;
	width: 42px;
	height: 24px;
}
#topicNav {
	margin: 0;
	padding: 0;
	border: none;
}
ul#toolbar, ul#toolbar li {
	margin: 0;
	padding: 0;
	border: none;
}
ul#toolbar {
	list-style-type: none;
}
ul#toolbar li {
	float: left;
}
ul#toolbar li a {
	display: block;
	height: 50px;
}
ul#toolbar li a span {
	display: none;
}
ul#toolbar li#n-msd a {
	width: 121px;
	background: url(http://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif);
}
ul#toolbar li#n-msd a:hover, ul#toolbar li#n-msd a.active {
	background-position: 0 -50px;
}
ul#toolbar li#n-leg a {
	width: 90px;
	background: url(http://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -125px 0;
}
ul#toolbar li#n-leg a:hover, ul#toolbar li#n-leg a.active {
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -125px -50px;
}
ul#toolbar li#n-learntech a {
	width: 91px;
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -219px 0;
}
ul#toolbar li#n-learntech a:hover, ul#toolbar li#n-learntech a.active {
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -219px -50px;
}
ul#toolbar li#n-health a {
	width: 85px;
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -314px 0;
}
ul#toolbar li#n-health a:hover, ul#toolbar li#n-health a.active {
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -314px -50px;
}
ul#toolbar li#n-life a {
	width: 90px;
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -403px 0;
}
ul#toolbar li#n-life a:hover, ul#toolbar li#n-life a.active {
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -403px -50px;
}
ul#toolbar li#n-money a {
	width: 91px;
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -497px 0;
}
ul#toolbar li#n-money a:hover, ul#toolbar li#n-money a.active {
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -497px -50px;
}
ul#toolbar li#n-travel a {
	width: 85px;
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -592px 0;
}
ul#toolbar li#n-travel a:hover, ul#toolbar li#n-travel a.active {
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -592px -50px;
}
ul#toolbar li#n-leisure a {
	width: 84px;
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -681px 0;
}
ul#toolbar li#n-leisure a:hover, ul#toolbar li#n-leisure a.active {
	background: url(https://assets.aarp.org/www.aarp.org_/build/templates/style/toolbar.gif) -681px -50px;
}
div#aarpPartnerToolbar img {
	border: 0;
}
div#aarpPartnerToolbar ol, ul, li {
	font-size: 100%;
	line-height: 120%;
}
// -->
</style>

<cfoutput>
	<cfset bodyTagMore = ''>
<title>#title#</title>
<cfinclude template="google_data_tracking.cfm">	
</head>
<body #onLoadScript#>
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PHJ4LQ');</script>
<!-- End Google Tag Manager -->

<table align=center valign=top border="0"><tr><td>

<div id="aarpPartnerToolbar">
	<div id="globalNav">
		<a name="top"></a><a href="http://www.aarp.org/foundation/" target="_blank">AARP Foundation Home</a>
		|
		<a href="http://www.aarp.org" target="_blank">AARP Home</a>
	</div><!-- /globalNav -->
	<div id="brandingSearch">
<a class="button" href="http://www.aarp.org/foundation/" target="_blank"><img src="#application.transferType#://#application.serverPath#/aarp/images/aarpquicklink.jpg" alt="AARP Foundation - Benefits QuickLINK" width="770" height="77" align="left" border="0" vspace="0"/></a>

<!--- <table border="0" align="right"><tr><td align="left"><span style="font-family: Arial, Verdana, Helvetica, sans-serif; font-size: 12px; color: ##424141;"><br>Other AARP Foundation Programs That Can Help<br>
<a href=" http://www.aarpmmp.org/" target="_blank" style="padding: 0px;">Money Management</a> | <a href="http://www.aarp.org/money/careers/findingajob/jobseekers/finding_a_program.html" target="_blank" style="padding: 0px;">Senior Community Service Employment Program</a><br>
<a href="http://www.aarp.org/money/taxaide/" target="_blank" style="padding: 0px;">AARP Tax-Aide</a> | <a href="http://www.aarp.org/money/revmort/" target="_blank" style="padding: 0px;">Reverse Mortgage Education</a> | <a href="http://www.aarp.org/grandparents/" target="_blank" style="padding: 0px;">Grandparent Information Center</a></span></td></tr></table>  <form id="search" method="get" action="https://www.aarp.org/search_advanced/search_results.html" name="searchform" target="_blank"><input type="hidden" name="config" value="htdig_www_aarp_org_small"><div></div></form>---></div><div class="clearer" style="height:3px;"></div>
	
</div><!-- /header -->

</td></tr></table>		
	<cfset tablewidth="100%">
	<cfset cellpadding="0">
	<cfset session.cellpadding="0">
	<cfset session.cellspacing="0">
	<cfset session.innercellpadding="0">
	<cfset session.innercellspacing="0">
<table width="690" cellpadding="0" width="#tablewidth#" align="center" border="0">
  <tr>
  <td bgcolor="##FFFFFF">
		<table cellpadding="0" cellspacing="0" align="center" border="0">
			<tr>
				<td align="center" valign="top" colspan="3"><img src="aarp/images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>
				<td align="center" valign="top" colspan="3"><font face="Arial" size="4"><b></b></font></td>
			</tr>
			<tr>	
				<td align="left" valign="top"><!--img src="images/head-bcu.gif"  border="0" alt="BenefitsCheckUp" alt=""--></td>
			</tr>			
			<tr>
				<td align="center" valign="top" colspan="3"><img src="aarp/images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
		 </table>
<a name="skipnav"></a>
		 <table><tr><td align="center"><cfif maintMsg neq ''><img src="aarp/images/pixel.gif" width="1" height="5" border="0" alt=""><br><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b>#maintMsg#</b></font><br></cfif></td></tr></table>	 
		 <table><tr><td align="center" width="690">
</cfoutput>
