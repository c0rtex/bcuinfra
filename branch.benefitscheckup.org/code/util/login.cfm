<html>
<head>


	<title>Financial Interview Tool - Home</title>

    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>

    
    <link href="oe/img/favicon.ico" rel="SHORTCUT ICON"/>
    <meta name="keywords" content="BenefitsCheckUp,NCOA">
 <script language="JavaScript" src="https://oe4.benefitscheckup.org/oe/js/oe.js"></script>
	
    <meta name="description" content="BenefitsCheckUp screenings help seniors with limited income find programs to help pay for prescription drugs, energy assistance, food stamps, Alzheimer's care and more.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">
<!-- Style sheets start -->
<link rel=stylesheet href="css/pl.css" type="text/css" media="screen" />
<link rel=stylesheet href="css/plmenu.css" type="text/css" media="screen" />
<!--[if IE]>
<link rel=stylesheet href="css/plmenuie.css" type="text/css" media="screen" />
<![endif]-->
<!-- Style sheets end -->
<link rel=stylesheet href="css/print_pl.css" type="text/css" media="print">
<link href="oe/css/partner.css" type="text/css" rel="stylesheet"/>

<script language="JavaScript" src="ValidationFunctions.js"></script>
<script language="JavaScript">
	function highlight_off(item) {
	var tag = item + "h";
	if (document.getElementById(tag)) {
		var oetag = document.getElementById(tag);
		oetag.id = item;
		}
	}

	function highlight(item) {
	if (document.getElementById(item)) {
		var oetag = document.getElementById(item);
		oetag.id = item + "h";
		}
	}

	function fixpopups() {
		var tag = "privacy";
		if (document.getElementById(tag)) {
			var oetag = document.getElementById(tag);
			oetag.href = "javascript:help2('privacy.cfm')";
		}
		
		var tag2 = "terms";
		if (document.getElementById(tag2)) {
			var oetag2 = document.getElementById(tag2);
			oetag2.href = "javascript:help2('terms.cfm')";
		}
	}

	function confirmLogOut(s) {
	  if (typeof(dirtyForm)!="undefined" && !warnOnDirtyForm()) {
		return false;
	  }
	  if (! s) {
	  	return true;
	  }
	  var msg="\nIf you click OK, you will leave the Reports and Tools section of your site.\nAre you sure you want to logout?\n";
	  if (confirm(msg)) {
	    return true;
	  }
	  return false;
	}
</script>
<script>
dataLayer = [{
        'partner_id': '76',
        'partner_name': 'Financial Interview Tool',
        'subset_id': '0',
        'state': '',       
}];
</script>
</head>
<body >
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PHJ4LQ');</script>
<!-- End Google Tag Manager -->

<cfoutput>
	<cfif Not IsDefined("session.partner_id")>
		<cfif IsDefined("URL.partner_id")>
    		<cfset session.partner_id = #URL.partner_id#>
       	</cfif>
   	</cfif>
</cfoutput>
<a name="top"></a>
<div id="enclose">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000"></div> 
<div class="print">
<div class="container1">
<div class="topheader">
<div class="bculogo" style="margin-top:0px;padding:10px">
				
<a href="http://www.ncoa.org" target="_blank"><img src="/wp-content/uploads/2011/11/ncoa_footer_trans" alt="National Council on Aging" title="National Council on Aging"></a>
						
</div>

<div class="logo" style="margin-top: 0; margin-right: 0;">

<img src="img/partners/fit/logo2.gif" border="0" alt="HUD" title="HUD">

</div>
</div>
<div class="clear"></div>

<ul id="globalnav">
	
	
	
	
</ul>

<div class="clear"></div>	

<table cellpadding="0" cellspacing="0" width="770" border="0" id="top-table-layout">
<tr>
<td valign="top" class="contentcol2">

<div style="float:right" class="text1">

</div>


<table cellpadding="20" cellspacing="0" width="100%" border="0">
<tr>
<td>
<cfif IsDefined ("Invalid")>
        <cfif Invalid EQ "Yes">
        <h4 align="center"><font color="#FF0000"></font></h4>
        </cfif>    
 </cfif>




<h1 class="h1">Login</h1>
<p class=text1>Login to access your Reverse Mortgage Counseling Toolkit by entering your User ID and password below.</p>



<form name="loginForm" method="post" action="<cfoutput>#FormAction#</cfoutput>">
<table cellspacing="0" cellpadding="0" border="0">
<tr align="left" valign="top">
<td width="123" height="29" class="main_body_text"><b class="text1">&nbsp; <img src="img/partners/user.gif" width="16" height="16"> User ID:</b></td>
<td width=20><input type="text" name="UserLogin" size="16" tabindex="1" value="" id="userLogin"></td>
</tr>
<tr align="left" valign="top">
<td width="123" height="29" class="main_body_text"><b class="text1">&nbsp; <img src="img/partners/pass.gif" width="16" height="16"> Password:</b></td>

<td width=20><input type="password" name="Password" size="16" tabindex="2" value="" id="password">&nbsp;</td>
</tr>
<tr>
<td></td>
<td><input type="hidden" name="partner_id" value="76"><input type="submit" value="Login"></td>
</tr>
</table>
</form>
<script type="text/javascript" language="JavaScript">
  <!--
  var focusControl = document.forms["loginForm"].elements["userLogin"];

  if (focusControl.type != "hidden" && !focusControl.disabled) {
     focusControl.focus();
  }
  // -->
</script>

</td>
</tr>
<tr><td>
<p class="text1"><b>
The Reverse Mortgage Counseling Toolkit website is meant for HUD-certified
reverse mortgage counselors only. Counselors need to access the Toolkit through
their HUD-certified Client Management System (CMS).</b></p>
<p class="text1">
Note: You may have come to this screen because your session time on the Toolkit
website has expired. If so, you will need to login again through your CMS.</p>
</td></tr>
</table>











</td></tr></table>

<cfoutput><div class="footer"><div class="container2"><div class="footer1">&copy; #year(now())# <a href="http://www.ncoa.org" class="footerlink" target="ncoa">National Council on Aging.</a> All rights reserved</div></cfoutput>

<div class="footer2">
<!---a id="privacy" class="footerlink" href="privacy.cfm">Privacy Policy</a> / <a class="footerlink" id="terms" href="termsofuse.cfm">Terms of Use</a---> 
 
</div></div>
</div>
</div>
<script>
function linkToUs(u) {
	var h = open(u, 'LinkToUs', "width=600,height=200,status=yes,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
} 

fixpopups();</script>
</div>
</body>
</html>
