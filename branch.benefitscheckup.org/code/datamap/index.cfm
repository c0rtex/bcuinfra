<cfparam name="session.mState" default="">
<cfparam name="session.mCounty" default="">
<cfparam name="session.mZip" default="">
<cfparam name="session.mData" default="">
<cfparam name="url.resetMippa" default="">
<cfset mippaContent = "main.cfm">

<cfif url.resetMippa is 1>
	<cfset session.mZip = "">
	<cfset session.mState = "">
    <cfset session.mCounty = "">
    <cfset session.mdata = "">
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Benefits Enrollment Data Mapping Tool</title>


<script src="../js/AC_RunActiveContent.js" type="text/javascript"></script>
<script src="swfobject.js" type="text/javascript"></script>
<script src="jquery/jquery-1.4.4.min.js" type="text/javascript"></script>
<script src="jquery.ui-1.5.2/ui/ui.core.js" type="text/javascript"></script>
<script src="jquery.ui-1.5.2/ui/ui.tabs.js" type="text/javascript"></script>

<script src="mippaClass.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(document).ready(function(){
		mippa = new mippaTool();
		mippa.init();
		$("DIV#aboutText a").click(function() {
  			mippa.showDesc();
			mippa.showDesc();
		});
	});
</script>

<link rel="stylesheet" href="mippatool.css" type="text/css" media="screen" />
<link href="jquery.ui-1.5.2/themes/flora/flora_tabs.css" rel="stylesheet" type="text/css" media="screen" />
<!--[if IE 7]> 
    <style type="text/css">
        h1{font-size:24px;}
        #zipSubmit{position:relative;top:2px;}
    </style>
<![endif]-->
<!--[if IE ]> 
    <style type="text/css">
        #bcuStack{width:162px;}
    </style>
<![endif]-->
<style type="text/css">
@media print  { 
	.noprintLong  { display: none; } 
	.longWider{width:770px !important;}
	.noprintRank{ display:none;}
}
@media screen { .noscreen { display: none; } }
</style>
</head>

<body class="mippatool">
<div id="container">
	<div id="header">
    	<div class="logo">
        	<a href="http://www.centerforbenefits.org" target="_blank"><img src="../img/partners/mippa/logo.gif" alt="National Center for Benefits Outreach and Enrollment" title="National Center for Benefits Outreach and Enrollment" border="0" /></a>
        </div>
    	<div class="title">
        	<!--- <cf_displayText code="site_mapping_home_title" group="site"> ---><img src="bedm_header.gif" alt="Benefits Enrollment Data Map" title="Benefits Enrollment Data Map" border="0" style="float:right;" />
        </div>
        <div class="clearBoth"></div>
	</div>
	<div id="mainContent">
    	<cfinclude template="#mippaContent#">
	</div>
	<div id="footer">
		<p>Copyright <cfoutput>#dateFormat(now(),'yyyy')#</cfoutput> / National Council on Aging / 1901 L Street, NW, 4th Floor Washington, D.C. 20036 / <a href="mailto:nca.support@ncoa.org" style="color:#fff; text-decoration:none;">Contact Us</a></p>
	</div>
</div>
<script type="text/javascript">
	jQuery("#jQueryUITabs1 > ul").tabs({ event: "click" }); 
	jQuery("#jQueryUITabs1 > ul").tabs("disable",  1);
	jQuery("#jQueryUITabs1 > ul").tabs("disable",  2);
	jQuery("#jQueryUITabs1 > ul").tabs("disable",  3);
</script>
</body>
</html>
