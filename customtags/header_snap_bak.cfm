<cfif IsDefined("URL.subset_id") AND URL.subset_id NEQ ''>
	<cfset SESSION.subset_id = URL.subset_id>
	<cfset SESSION.current_subset_id = URL.subset_id>
</cfif>

<cfparam name="SESSION.site_url" default="#CGI.server_name#">
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

<!---<cf_sessionLoadVars>
<cfset SESSION.partner_id = 0>--->

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
						
<cfquery name="getCallout" dataSource="wp_benefitscheckup">
	SELECT post_content
	FROM wp_posts
	WHERE ID = 2185
</cfquery>

<!doctype html>
<html dir="ltr" lang="en-US" xmlns:fb="https://www.facebook.com/2008/fbml" xmlns:addthis="https://www.addthis.com/help/api-spec" >

<head>
	<meta charset="UTF-8" />
	<meta name="language" content="en-US" />
	<meta name="lang" content="en" />
	<meta name="description" content="Here is the description of your project." />
	<meta name="keywords" content="" />
	<meta name="Copyright" content="Copyright NCOA 2011" />

	<!-- Speaking of Google, don't forget to set your site up: http://google.com/webmasters -->	
	<meta name="google-site-verification" content="" />

	<!-- This is the traditional favicon.
		 - size: 16x16 or 32x32
		 - transparency is OK
		 - see wikipedia for info on broswer support: http://mky.be/favicon/ -->	
	<link href="/favicon.ico" rel="shortcut icon">
	<!-- The is the icon for iOS's Web Clip.
		 - size: 57x57 for older iPhones, 72x72 for iPads, 114x114 for iPhone4's retina display (IMHO, just go ahead and use the biggest one)
		 - To prevent iOS from applying its styles to the icon name it thusly: apple-touch-icon-precomposed.png
		 - Transparency is not recommended (iOS will put a black BG behind the icon) -->
	<link rel="apple-touch-icon" href="/wp-content/themes/bcuwptheme/images/custom_icon.png"/>
	<link rel="stylesheet" type="text/css" media="all" href="/wp-content/themes/bcuwptheme/style.css" /> 
	<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/wp-content/themes/bcuwptheme/css/ie6.css" /><![endif]-->
	<!--[if IE 7]><link rel="stylesheet" type="text/css" href="/wp-content/themes/bcuwptheme/css/ie7.css" /><![endif]-->
	<!--[if IE 8]><link rel="stylesheet" type="text/css" href="/wp-content/themes/bcuwptheme/css/ie8.css" /><![endif]-->

<script type="text/javascript">
/*
CSS Browser Selector v0.4.0 (Nov 02, 2010)
Rafael Lima (http://rafael.adm.br)
http://rafael.adm.br/css_browser_selector
License: http://creativecommons.org/licenses/by/2.5/
Contributors: http://rafael.adm.br/css_browser_selector#contributors
*/
function css_browser_selector(u){var ua=u.toLowerCase(),is=function(t){return ua.indexOf(t)>-1},g='gecko',w='webkit',s='safari',o='opera',m='mobile',h=document.documentElement,b=[(!(/opera|webtv/i.test(ua))&&/msie\s(\d)/.test(ua))?('ie ie'+RegExp.$1):is('firefox/2')?g+' ff2':is('firefox/3.5')?g+' ff3 ff3_5':is('firefox/3.6')?g+' ff3 ff3_6':is('firefox/3')?g+' ff3':is('gecko/')?g:is('opera')?o+(/version\/(\d+)/.test(ua)?' '+o+RegExp.$1:(/opera(\s|\/)(\d+)/.test(ua)?' '+o+RegExp.$2:'')):is('konqueror')?'konqueror':is('blackberry')?m+' blackberry':is('android')?m+' android':is('chrome')?w+' chrome':is('iron')?w+' iron':is('applewebkit/')?w+' '+s+(/version\/(\d+)/.test(ua)?' '+s+RegExp.$1:''):is('mozilla/')?g:'',is('j2me')?m+' j2me':is('iphone')?m+' iphone':is('ipod')?m+' ipod':is('ipad')?m+' ipad':is('mac')?'mac':is('darwin')?'mac':is('webtv')?'webtv':is('win')?'win'+(is('windows nt 6.0')?' vista':''):is('freebsd')?'freebsd':(is('x11')||is('linux'))?'linux':'','js']; c = b.join(' '); h.className += ' '+c; return c;}; css_browser_selector(navigator.userAgent);
</script>

<style>
/*
Breadcrumb hack for Chrome

.chrome div#breadcrumbs { margin: 0 0 -15px 242px !important; }
*/
/*
Breadcrumb hack for Safari

@media screen and (-webkit-min-device-pixel-ratio:0) {

#breadcrumbs
{
	margin: 0 0 -15px 94px !important;
}

}
.win.gecko #breadcrumbs
{
	margin: 0 0 -15px 225px;
}
.win.ie8 #breadcrumbs
{
	margin: 0 0 -15px 223px;
}
*/
.win.ie7 #wrapper
{
	margin-top:-15px;
}

</style>
	

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet" type="text/css">
<title>BenefitsCheckUp.org</title>

	<link rel='archives' title='October 2011' href='/2011/10/' />
	<link rel='archives' title='May 2011' href='/2011/05/' />

	<link rel='archives' title='April 2011' href='/2011/04/' />
	<link rel='archives' title='March 2011' href='/2011/03/' />
	<link rel='archives' title='February 2011' href='/2011/02/' />
	<link rel='archives' title='December 2010' href='/2010/12/' />
	<link rel='archives' title='November 2010' href='/2010/11/' />
	<link rel='archives' title='October 2010' href='/2010/10/' />
	<link rel='archives' title='August 2010' href='/2010/08/' />
	<link rel='archives' title='July 2010' href='/2010/07/' />
	<link rel='archives' title='June 2010' href='/2010/06/' />

	<link rel='archives' title='May 2010' href='/2010/05/' />
	<link rel='archives' title='March 2010' href='/2010/03/' />
	<link rel='archives' title='January 2010' href='/2010/01/' />
	<link rel='archives' title='December 2009' href='/2009/12/' />
	<link rel='archives' title='November 2009' href='/2009/11/' />
	<link rel='archives' title='October 2009' href='/2009/10/' />
	<link rel='archives' title='May 2009' href='/2009/05/' />
	<link rel='archives' title='April 2009' href='/2009/04/' />
	<link rel='archives' title='March 2009' href='/2009/03/' />

	<link rel='archives' title='January 2009' href='/2009/01/' />
	<link rel='archives' title='November 2008' href='/2008/11/' />
	<link rel='archives' title='September 2008' href='/2008/09/' />
	<link rel='archives' title='August 2008' href='/2008/08/' />
	<link rel='archives' title='July 2008' href='/2008/07/' />
	<link rel='archives' title='May 2008' href='/2008/05/' />
	<link rel='archives' title='April 2008' href='/2008/04/' />
	<link rel='archives' title='December 2007' href='/2007/12/' />
	<link rel='archives' title='November 2007' href='/2007/11/' />

	<link rel='archives' title='September 2007' href='/2007/09/' />
	<link rel='archives' title='August 2007' href='/2007/08/' />
	<link rel='archives' title='July 2007' href='/2007/07/' />
	<link rel='archives' title='June 2007' href='/2007/06/' />
	<link rel='archives' title='May 2007' href='/2007/05/' />
	<link rel='archives' title='April 2007' href='/2007/04/' />
	<link rel='archives' title='March 2007' href='/2007/03/' />
	<link rel='archives' title='February 2007' href='/2007/02/' />
	<link rel='archives' title='January 2007' href='/2007/01/' />

	<link rel='archives' title='December 2006' href='/2006/12/' />
	<link rel='archives' title='November 2006' href='/2006/11/' />
	<link rel='archives' title='October 2006' href='/2006/10/' />
	<link rel='archives' title='September 2006' href='/2006/09/' />
	<link rel='archives' title='July 2006' href='/2006/07/' />
	<link rel='archives' title='June 2006' href='/2006/06/' />

	<script src="/cf/ValidationFunctions.js"></script>
	<script src="/cf/scripts.js"></script>
	<script src="/cf/textResize.js"></script>
	
</head>

<body class="js">

<div id="wrapper">
	<div id="ada508">  
		<strong>Shortcut Navigation:</strong> 
		<ul> 
			<li><a href="#content" accesskey="p" title="Skip to page content">Page Content</a></li> 
			<li><a href="#topNav" accesskey="n" title="Skip to main navigation menu">Site Navigation</a></li>

			<li><a href="#search" accesskey="s" title="Skip to search">Search</a></li> 
			<li><a href="#footer" accesskey="f" title="Skip to footer (ctrl/alt + f)">Footer</a></li> 
		</ul> 
	</div> 
<!-- #ada508 shortcuts --> 
	
    <div id="header">
   
    	<h1><a target="_blank" href="http://www.ncoa.org"><img src="/wp-content/themes/bcuwptheme/images/logos/ncoa_top.png"  title="National Council on Aging" alt="National Council on Aging" id="topbar" /></a></h1>
       	<a href="/index.php" class="block"><!---<img src="/wp-content/themes/bcuwptheme/images/logos/bcu.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" />---><img src="/wp-content/themes/bcuwptheme/images/logos/bcu.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" /></a>
       	<p>
 <p>We have helped more than <strong>1 million people</strong>
find over <strong>$1.1 billion</strong> in SNAP benefits.</p>

		</p>

       
        <div id="sponsors">
        	<h2>Special thanks to:</h2>
        	<!--<img src="/wp-content/themes/bcuwpthemeimages/logos/walmart.gif" alt="Walmart logo" />-->
        </div><!-- sponsors --> 

    </div><!--end header -->
	
   <!--- hide main-nav 
    <div id="main-nav">
    	<div class="menu-main-menu-container"><ul id="menu-main-menu" class="nav"><li id="menu-item-1691" class="menu-item menu-item-type-post_type menu-item-object-page page_item page-item-1673 menu-item-1691"><a href="/">Home</a></li>
<li id="menu-item-1688" class="current_page_item current-menu-item menu-item menu-item-type-post_type menu-item-object-page menu-item-1688"><a href="/find-help/">Find Help</a></li>

<li id="menu-item-1690" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1690"><a href="/about-us/">About Us</a></li>
<li id="menu-item-1686" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1686"><a href="/our-sponsors/">Our Sponsors</a></li>
<li id="menu-item-1709" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1709"><a href="/news/">News</a></li>
<li id="menu-item-2019" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-2019"><a href="http://ncoa2.pub30.convio.net/BCUdonation">Donate</a></li>
</ul></div> 
--->
	
    </div><!--end main nav --> 
	
	<div id="breadcrumbs">
		<p>
			<!-- Breadcrumb NavXT 3.9.0 -->
		</p>

	</div><!--end breadcrumbs --> 
  
<div id="page" class="subpage layout-noRightCol"><!-- "page" id should remain on every page, swap or extend the "layout-default" class for alternate layouts (class="subpage layout-noRightCol" or class="forum layout-default" -->

<div id="content" class="surveypage">
   			
<div class="col1">
			
<!--- END HEADER --->

