<!--- some legacy header code--->
<cfset session.cellpadding = 0>
<cfset session.cellspacing= 0>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Care.com | Senior Care Benefits</title>
<link rel="stylesheet" href="/care_mockup/css/reset.css" />
<link rel="stylesheet" href="/care_mockup/css/text.css" />
<link rel="stylesheet" href="/care_mockup/css/960.css" />
<link rel="stylesheet" href="/care_mockup/css/uncompressed/care.css" />
<link rel=stylesheet href="/css/print.css" type="text/css" media="print">

<!--[if IE 7]>
	<link rel="stylesheet" href="/care_mockup/css/uncompressed/ie.css" />
<![endif]-->
<!--[if IE 8]>
	<link rel="stylesheet" href="/care_mockup/css/uncompressed/ie8.css" />
<![endif]-->
<link rel="stylesheet" href="/care_mockup/css/ui-lightness/jquery-ui-1.8.6.custom.css" />
<script type="text/javascript" src="/care_mockup/js/jquery-1.4.3.min.js"></script>
<script type="text/javascript" src="/care_mockup/js/jquery-ui-1.8.6.custom.min.js"></script>
<script type="text/javascript" src="/ValidationFunctions.js"></script>
<script> 
 $(document).ready(function() {
   $('#alt_body').hide();
   $("TABLE TR TD IMG:first").css("padding", "25px 0px 0px 25px");
 });
 
 function leftTab() {
	$('#main_body').show();
	$('#alt_body').hide();
	
	$('li.right_tab').addClass('inactive');
	$('li.right_tab').addClass('active');
	$('li.left_tab').removeClass('inactive');
	$('li.left_tab').addClass('active'); 
 }
 
 function rightTab() {
	$('#alt_body').show();
	$('#main_body').hide();
	
	$('li.left_tab').addClass('inactive');
	$('li.left_tab').removeClass('active');
	$('li.right_tab').removeClass('inactive');
	$('li.right_tab').addClass('active'); 
 }
</script>
</head>
<body>
 
<div class="container_12">
 
	<div id="logo" class="grid_7">
			<a href="index.cfm?partner_id=80"><img src="/care_mockup/care_images/logo.gif" width="500" height="90" alt="Care.com and BenefitsCheckUp logos" title="Care.com and BenefitsCheckUp logos"></a>
	</div>
	<!-- end #logo -->
	<div id="visit_care" class="push_2 grid_2">
			<a href="http://www.care.com/adults-seniors" target="_new"><img src="/care_mockup/care_images/visit_care.GIF" width="115" height="29" alt="Care.com - How happy
families run" title="Care.com - How happy families run"></a>
	</div>
	<!-- end #visit_care -->
	<div class="clear"></div>
	
	<h1 class="grid_12">Senior Care Benefits</h1>
	<div class="clear"></div>
	
	<div id="tabs_div" class="grid_12">
		<ul id="tabs">
			<li class="left_tab active"><a href="index.cfm?partner_id=80" onClick="leftTab();"><span>BenefitsCheckUp</span></a></li>
			<li class="right_tab inactive"><a href="http://www.care.com/adults-seniors" target="_new"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Find Senior Care&nbsp;</span></a></li>
		</ul>
	</div>
	<!-- end #tabs -->
	<div class="clear"></div>
	<!-- Extra padding for non-semantic content -->
	<div id="extra_padding"></div>
	<div class="clear"></div>