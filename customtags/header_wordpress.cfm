<cfif IsDefined("URL.subset_id") AND URL.subset_id NEQ ''>
	<cfset SESSION.subset_id = URL.subset_id>
	<cfset SESSION.current_subset_id = URL.subset_id>
</cfif>

<cfparam name="SESSION.site_url" default="redesign.benefitscheckup.org">
<cfparam name="SESSION.subset_id" default="0">
<cfparam name="SESSION.current_subset_id" default="#SESSION.subset_id#">
<cfparam name="preserve" type="boolean" default="false">

<cfset hasRadio = false>
<!--- Initialize and load any session variable value passed into this page --->
<!--- Call header tag --->

<cftry>
<!--- Check if SESSION.subset_id has changed.  --->
<cfif IsDefined('SESSION.subset_id')>
	<cfif SESSION.subset_id NEQ SESSION.current_subset_id>
		
		<cfif CGI.SERVER_PORT NEQ '80'>
			<cfset REQUEST.serverPort = "https">
		<cfelse>
			<cfset REQUEST.serverPort = "http">
		</cfif>
		
		<cfif CGI.QUERY_STRING NEQ ''>
			<cfset tmpQueryString = CGI.QUERY_STRING>
			<cfset tmpQueryString = Replace(tmpQueryString,"subset_id=#SESSION.subset_id#", "subset_id=#SESSION.current_subset_id#")>
		</cfif>
		
		<cfset forwardURL = REQUEST.serverPort & "://" & SESSION.subdomain & ".benefitscheckup.org" & CGI.SCRIPT_NAME &"?" & tmpQueryString>
		
		<!--- Reset subset_id --->
		<cfset SESSION.subset_id = Duplicate(SESSION.current_subset_id)>
		<cfset SESSION.current_subset_id = Duplicate(SESSION.subset_id)>
		
		<cflocation url="#forwardURL#" addtoken="true">
		<cfabort>
	</cfif>
</cfif>	
<cfcatch type="any"></cfcatch>
</cftry>

<!---<cf_sessionLoadVars>--->
<cfset SESSION.partner_id = 0>

<cfif session.partner_id IS 0>
	<cfset qpartner = 1>
<cfelse>
	<cfset qpartner = session.partner_id>
</cfif>
<cf_cachepartnerquery query="partnerQuery" partner_id="#qpartner#">

<cfparam name="session.cellpadding" default="0">
<cfparam name="session.cellspacing" default="0">
<!--- pass in URL variable to override SESSION --->
<cfif IsDefined("URL.site_url")>
		<cfset SESSION.site_url = URL.site_url>
		<cfelse>
		<cfset URL.site_url = SESSION.site_url>
</cfif>

<cfset session.cellpadding="12">
<cfset session.cellspacing="2">
<cfset session.innercellpadding="2">
<cfset session.innercellspacing="2">
<cfparam name="link" default="">
<cfparam name="showmenu" default="1">
<cfparam name="guts" default="">
<cfparam name="content_title_override" default="">
<cfparam name="session.org_id" default="">
<cfparam name="URL.printfriendly" default="false">
<cfparam name="URL.showOtherWrapper" default="false">

<!DOCTYPE html>
<html dir="ltr" lang="en-US">
	<head>
	<title>BenefitsCheckUp &#8211; NCOA&#039;s Online Screening Service</title>
	<!-- Platform WordPress Framework By PageLines - www.PageLines.com -->
	<cfif attributes.refreshurl neq ''>
		<cfoutput><meta http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
	</cfif>
	<link rel="shortcut icon" href="/wp-content/themes/platformbase/images/favicon.png" type="image/x-icon" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="profile" href="http://gmpg.org/xfn/11" />
	<meta name="generator" content="WordPress 3.1.1" />
	<link rel="pingback" href="/xmlrpc.php" />
	<script type="text/javascript">var addthis_config = {"data_track_clickback":true};</script>

<!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/wp-content/themes/platformbase/ie7.css">
<![endif]-->
<!--[if IE 8]>
        <link rel="stylesheet" type="text/css" href="/wp-content/themes/platformbase/ie8.css">
<![endif]-->
	<link rel='stylesheet' id='pagelines-pro-css'  href='/wp-content/themes/platformpro/pro/pro.css?ver=1.2.3' type='text/css' media='all' />
	<link rel='stylesheet' id='pagelines-stylesheet-css'  href='/wp-content/themes/platformbase/style.css?ver=1.2.3' type='text/css' media='all' />
	<!--[if lte IE 6]>
<link rel='stylesheet' id='ie6-style-css'  href='/wp-content/themes/platformpro/css/ie6.css?ver=1.2.3' type='text/css' media='all' />
<![endif]-->
	<!--[if IE 7]>
<link rel='stylesheet' id='ie7-style-css'  href='/wp-content/themes/platformpro/css/ie7.css?ver=1.2.3' type='text/css' media='all' />
<![endif]-->
	<link rel='stylesheet' id='superfish-css'  href='/wp-content/themes/platformpro/sections/nav/superfish.css?ver=1.2.3' type='text/css' media='screen' />
	<link rel='stylesheet' id='superfish-shadow-css'  href='/wp-content/themes/platformpro/sections/nav/superfish_shadow.css?ver=1.2.3' type='text/css' media='screen' />
	<link rel='stylesheet' id='superfish-arrows-css'  href='/wp-content/themes/platformpro/sections/nav/superfish_arrows.css?ver=1.2.3' type='text/css' media='screen' />
	<link rel="EditURI" type="application/rsd+xml" title="RSD" href="/xmlrpc.php?rsd" />
	<link rel="wlwmanifest" type="application/wlwmanifest+xml" href="/wp-includes/wlwmanifest.xml" />
	<link rel='index' title='BenefitsCheckup &#8211; NCOA&#039;s Online Screening Service' href='http://redesign.benefitscheckup.org' />
	<link rel='next' title='Take Action' href='/take-action' />
	<meta name="generator" content="WordPress 3.1.1" />
	<link rel="stylesheet" href="/wp-content/plugins/communications/comms.css" type="text/css" />

	<!-- Meta SEO Pack BEGIN -->
	<meta name="keywords" content="benefit programs,prescription drug assistance,energy assistance,food stamps,tax relief,Medicare Part D,housing assistance,in-home services,nutrition,transportation,educational assistance,employment and volunteer Services" />
	<meta name="description" content="How Can We Help You? Share &amp; Print: //" />
	<meta name="robots" content="noodp,noydir" />
	<link rel="canonical" href="/" />
	<!-- Meta SEO Pack END -->

	<link rel="stylesheet" id="pagelines-dynamic-css" href="/wp-content/themes/platformpro/core/css/dynamic.css?ver=1.2.3" type="text/css" media="all" />
	
<script language="JavaScript" src="ValidationFunctions.js"></script>
<script language="JavaScript" src="js/bcu.js"></script>
<script language="JavaScript" src="js/jquery.js"></script>
<script language="JavaScript" src="include/zipcheck.js"></script>
<script language="JavaScript" src="include/ziplist.js"></script>


<cfset custom_js = replacenocase(partnerQuery.wrapper_custom_js, "[serverpath]", "#application.transferType#://#application.serverPath#", "all")>

<script language="JavaScript">


<cfif val(partnerQuery.wrapper_iframe) GT 0>
	document.domain="caring.com";
	$(document).ready(function(){
	resize();
});

function resize() {

	height = $("##container").innerHeight() + 40;
	var theFrame = $("##bcuFrame", parent.document.body);	
	var theTop = $(top.document);	
	frameheight = height + "px";
	if (height > 680) {
	$(theFrame).height(frameheight);
		$(theFrame).css("height", frameheight);
	} else {
		$(theFrame).height(680);
	}
	parent.location.hash = '##';
	
	

}

</cfif>


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
			oetag.href = "javascript:help2('/privacy.cfm')";
		}
		
		var tag2 = "terms";
		if (document.getElementById(tag2)) {
			var oetag2 = document.getElementById(tag2);
			oetag2.href = "javascript:help2('/terms.cfm')";
		}
	}
	
	<cfoutput>#custom_js#</cfoutput>


</script>

<link rel=stylesheet href="css/bcu.css" type="text/css" media="screen" />
<link rel=stylesheet href="css/menu.css" type="text/css" media="screen" />

<link rel=stylesheet href="css/screening.css" type="text/css" />
<link rel="stylesheet" href="js/theme.css" type="text/css" media="screen" />

<!-- ALL CUSTOM CSS TO MODIFY STYLES IN QUESTIONNAIRES SHOULD BE ADDED TO BCU_WORDPRESS_WRAPPER.CSS-->
<link rel=stylesheet href="css/bcu_wordpress_wrapper.css" type="text/css" />

</head>
	<body onLoad="fixpopups();" class="home page page-id-14 page-template page-template-default logged-in fixed_width ttype-default tmain-default">
	
<div id="site" class="fullwidth">
<!-- #site // Wraps #header, #page-main, #footer - closed in footer -->

<div id="page"> <!-- #page // Wraps #header, #page-main - closed in footer -->
			
			<div id="page-canvas">
				<div id="header" class="container-group fix">
							<div class="outline">
								<div class="ncoaBranding"> <a href="http://www.ncoa.org" target="_blank" class="ncoaLink"><img src="/wp-content/themes/platformbase/images/ncoaHeaderLogo.png" alt="NCOA - National Council on Aging" title="NCOA - National Council on Aging" width="126" height="61"></a> 
											<!--<a href="http://oe4.benefitscheckup.org/oe">Organization Users</a>--> 
									</div>
								<div id="tagline">As of Tuesday, April 27, 2011 we have helped 2,802,793 people find over $9.7 billion worth of the annual benefits they deserve.</div>
								<div id="resizingText">&nbsp;</div>
								<div id="branding" class="container fix">
											<div class="texture">
												<div class="content">
															<div class="content-pad">
																<div class="branding_wrap"> <a class="mainlogo-link" href="http://redesign.benefitscheckup.org" title="BenefitsCheckUp"><img class="mainlogo-img" src="/wp-content/themes/platformbase/images/logo.png" alt="BenefitsCheckUp" /></a>
																			<div class="icons" style="bottom: 0px; right: px;"> </div>
																	</div>
																<div class="clear"></div>
														</div>
													</div>
										</div>
									</div>
								<div id="primary-nav" class="container fix">
											<div class="texture">
												<div class="content">
															<div class="content-pad">
																<div id="nav_row" class="main_nav fix">
																		<ul id="menu-top-menu" class="main-nav nosearch"><li id="menu-item-1453" class="menu-item menu-item-type-post_type menu-item-object-page  page_item page-item-14 current_page_item menu-item-1453"><a href="/">Home Page</a></li>
																		<li id="menu-item-71" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-71"><a href="/about-2">About BenefitsCheckUp</a></li>
																		<li id="menu-item-69" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-69 <cfif Trim(CGI.script_name) NEQ '/cf/snap.cfm' AND Trim(CGI.script_name) NEQ '/cf/snap_state.cfm'>current-menu-item</cfif>"><a href="/check-eligibility">Find Benefit Programs Now</a></li>
																		<li id="menu-item-1496" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1496 <cfif CGI.script_name EQ '/cf/snap.cfm' OR CGI.script_name EQ '/cf/snap_state.cfm'>current-menu-item</cfif>"><a href="/cf/snap.cfm?partner_id=0">Food Benefits</a></li>
																		<li id="menu-item-979" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-979"><a href="/news-2011">Current News</a></li>
																		<li id="menu-item-67" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-67"><a href="/benefitcheckup-sponsors">BenefitsCheckUp Sponsors</a></li>
																		
																		<li id="menu-item-66" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-66"><a href="/donate">Donate</a></li>
																		</ul>	
																	</div>
																<div class="clear"></div>
														</div>
													</div>
										</div>
									</div>
						</div>
					</div>
				<div id="page-main" class="container-group fix"> <!-- #page-main // closed in footer -->
							<div id="dynamic-content" class="outline fix"> 
														
							

