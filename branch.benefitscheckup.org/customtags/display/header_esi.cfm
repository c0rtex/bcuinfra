<cfif IsDefined("URL.subset_id") AND URL.subset_id NEQ ''>
	<cfset SESSION.subset_id = URL.subset_id>
	<cfset SESSION.current_subset_id = URL.subset_id>
</cfif>
<cfif IsDefined('URL.partner_id') AND URL.partner_id NEQ ''>
	<cfset session.partner_id = URL.partner_id>
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
	<!--- 7061 - Need to route to new child theme favicon once created in WP --->
	<link rel="apple-touch-icon" href="/wp-content/themes/bcuwptheme/images/custom_icon.png"/>
	<!--- 7061 - Need to route to new child theme stylesheets once created in WP --->
    	<link rel="stylesheet" type="text/css" media="all" href="/wp-content/themes/bcuwptheme/style.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/wp-content/themes/bcuwptheme/style-oesi-cf.css" /> 
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
<cfif URL.printfriendly>
    <style>
    /* ------ Page Layout ----------------*/
    html, body {
		background:none;
        margin: 0 !important;
        padding: 0 !important;
        /* no decoration here */
        border-width: 0 !important;
        border-style: none !important;
        width: 100% !important; /* on sites with body width, text goes off edge of page on print*/
        text-align: left !important; /* IE messes up sites with text-align: center on body tag */
        width: 100% !important; /* on sites with body width, text goes off edge of page on print*/
    }
	DIV#barchart {
		background: none repeat scroll 0 0 #FFFFFF;
	}
	#footer .sub-wrapper .sites {
		float: left;
		margin-right: 5px;
		width: 130px;
	}
	#footer .sub-wrapper #bcu {
		background: none repeat scroll 0 0 white;
		padding: 0 35px 65px;
		width: 130px;
	}
	#footer .sub-wrapper #other {
 	   width: 150px;
	}
	#footer-primary P {
    	margin: 0 auto 4px;
    	padding-left: 10px;
    	width: 935px;
	}
    </style>
    <!--[if gte IE 8]>
		<style>
        	#footer .sub-wrapper #bcu {
				background: none repeat scroll 0 0 white;
				padding: 0 10px 65px;
                width: auto;
	}
        </style>
	<![endif]-->
</cfif>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet" type="text/css">
<title>EconomicCheckUp</title>

	<script src="/cf/ValidationFunctions.js"></script>
	<script src="/cf/scripts.js"></script>
	<script src="/cf/textResize.js"></script>
<cfinclude template="..util/google_data_tracking.cfm">	
</head>

<body class="js">
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PHJ4LQ');</script>
<!-- End Google Tag Manager -->

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
       	<a href="http://www.ncoa.org/enhance-economic-security/economic-security-Initiative/" target="_new" class="block"><!---<img src="/wp-content/themes/bcuwptheme/images/logos/bcu.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" />---><img src="/wp-content/uploads/2013/08/EconomicCheckUp_NCOA_small.jpg" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" alt="EconomicCheckUp" /></a>
	<p style="width:450px; padding:20px;" align="left" >Since 2010, we've helped thousands of older adults find work, budget their money, and save on daily expenses.</p>
</div><!--end header -->
	
    <!---  Test to highlight Find Benefits and Property Tax tabs--->
	<cfset highlightFindBenefits = 'no'>
    <cfset highlightPropertyTax = 'no'>
    	<!--- Scenarios where Find Benefits Tab should be highlighted--->
	<cfif (session.current_subset_id IS 0 OR session.current_subset_id IS 39) AND (CGI.SCRIPT_NAME NEQ '/cf/snap.cfm' AND CGI.SCRIPT_NAME NEQ '/cf/snap_state.cfm' AND CGI.SCRIPT_NAME NEQ '/cf/taxRelief.cfm' AND CGI.SCRIPT_NAME NEQ '/cf/taxRelief2.cfm' AND ((CGI.HTTP_REFERER NEQ '/cf/taxRelief2.cfm' AND CGI.HTTP_REFERER NEQ '/cf/taxRelief.cfm') AND CGI.SCRIPT_NAME NEQ '/cf/frmDetails.cfm')) AND (
		cgi.script_name IS "/cf/frmwelcome2.cfm" 
		OR cgi.script_name IS "/cf/frmquestions.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssec.cfm" 
		OR cgi.script_name IS "/cf/frmquestionssecdep.cfm" 	
		OR cgi.script_name IS "/cf/frmskipgrid.cfm" 
		OR cgi.script_name IS "/cf/frmquestionsthird.cfm" 
		OR cgi.script_name IS "/cf/frmRecommend.cfm" 	
		OR cgi.script_name IS "/cf/frmincomegrid.cfm" 	
		OR cgi.script_name IS "/cf/frmassetgrid.cfm" 		
		OR cgi.script_name IS "/cf/frmDrugList.cfm" 			
		OR cgi.script_name IS "/cf/frmeligibility.cfm" 
		OR cgi.script_name IS "/cf/proceligibility.cfm" 
		OR cgi.script_name IS "/cf/frmDetails.cfm" 
		OR cgi.script_name IS "/cf/frmOptionalQuestions.cfm" 		
		OR cgi.script_name IS "/cf/redirect.cfm" 	
		OR cgi.script_name IS "/cf/genericdruginfo.cfm" 	
		OR cgi.script_name IS "/cf/printed.cfm" 
		OR cgi.script_name IS "/cf/full.cfm")>
        	<cfset highlightFindBenefits = 'yes'>
        </cfif>
        <!--- Check if CGI HTTP REFERER is from the tax relief tool --->
		<cfset ctTaxRelief = #find("taxRelief",CGI.HTTP_REFERER)#> 
        <cfif session.current_subset_id IS 0 AND CGI.SCRIPT_NAME EQ '/cf/frmDetails.cfm' AND session.partner_id EQ 77>
        	<cfif ctTaxRelief EQ 0>
        		<cfset highlightFindBenefits = 'yes'>
           	<cfelse>
            	<cfset highlightPropertyTax = 'yes'>
            </cfif>
        </cfif>
                
        <!--- Other Scenarios where Property Tax Tab should be highlighted--->
        <cfif CGI.SCRIPT_NAME IS '/cf/taxRelief.cfm' OR CGI.SCRIPT_NAME IS '/cf/taxRelief2.cfm' OR ((CGI.HTTP_REFERER IS '/cf/taxRelief2.cfm' OR CGI.HTTP_REFERER IS '/cf/taxRelief.cfm') AND CGI.SCRIPT_NAME IS '/cf/frmDetails.cfm')>
        	<cfset highlightPropertyTax = 'yes'>
		</cfif>	
        
    <!--- END Test --->
    
    <div id="main-nav">
	<ul id="home">
	<li id="esi-home"><a href="http://www.economiccheckup.org/">Home</a></li>
	<li id="esi-findhelp"><a href="http://www.economiccheckup.org/esi-questions/" class="">My&nbsp;CheckUp</a></li>
	<li id="esi-benefits"><a href="http://www.economiccheckup.org/esi-find-help/"<cfif highlightFindBenefits IS 'yes'> class="current_tab"</cfif>>Resources</a></li>
	<li id="esi-findfood"><a href="http://www.economiccheckup.org/esi-about/" class="">About&nbsp;Us</a></li>
	<li id="esi-taxrelief"><a href="http://www.economiccheckup.org/esi-news/">News</a></li>
	<li id="esi-about"><a href="http://www.ncoa.org/Donate" class="" target="_blank"">Donate</a></li>

	</ul>
    </div><!--end main nav --> 

    <div id="breadcrumbs">
		<p>
			<!-- Breadcrumb NavXT 3.9.0 -->
		</p>

	</div><!--end breadcrumbs --> 
<div id="page" class="subpage layout-noRightCol"><!-- "page" id should remain on every page, swap or extend the "layout-default" class for alternate layouts (class="subpage layout-noRightCol" or class="forum layout-default" -->

<div id="content" class="surveypage">
   			
<div class="col1">
<cfset session.partner_id = 77>		
<!--- END HEADER --->

