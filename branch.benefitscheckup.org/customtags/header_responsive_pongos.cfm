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
<cfcontent reset="true" />
<!doctype html>



 



<!--[if lt IE 7]><html lang="en-US" xmlns:fb="http://ogp.me/ns/fb#" xmlns:addthis="http://www.addthis.com/help/api-spec"  class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->

<!--[if (IE 7)&!(IEMobile)]><html lang="en-US" xmlns:fb="http://ogp.me/ns/fb#" xmlns:addthis="http://www.addthis.com/help/api-spec"  class="no-js lt-ie9 lt-ie8"><![endif]-->

<!--[if (IE 8)&!(IEMobile)]><html lang="en-US" xmlns:fb="http://ogp.me/ns/fb#" xmlns:addthis="http://www.addthis.com/help/api-spec"  class="no-js lt-ie9"><![endif]-->

<!--[if gt IE 8]><!--> <html lang="en-US" xmlns:fb="http://ogp.me/ns/fb#" xmlns:addthis="http://www.addthis.com/help/api-spec"  class="no-js"><!--<![endif]-->



	<head>

		<meta charset="utf-8">



		

		<meta name="language" content="en-US" />

		<meta name="lang" content="en" />



		<!-- Google Chrome Frame for IE -->

		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">



		<!-- mobile meta -->

		<meta name="HandheldFriendly" content="True">

		<meta name="MobileOptimized" content="320">

		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>



		<!-- icons & favicons -->

		<link rel="shortcut icon" href="/favicon.ico"/>

  	

  	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->

  	   <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

  	   <!--[if lt IE 9]>

  	     <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>

  	     <script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>

  	<![endif]-->

  	

		  

				

		<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>-->

				  				         

				  		<!-- Need to upgrade WordPress so it gets a newer version of jQuery to work with Bootstrap -->

			  	  <script src="/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>

			  	   <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>-->

			      <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/jquery.validate.js"></script>

			      <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap.js"></script>

			      <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/scrolltofixed.js"></script>

				  <link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet" type="text/css">

				  <script src="/cf/ValidationFunctions.js"></script>

				  <script src="/cf/scripts.js"></script>

				  <!--<script src="/cf/textResize.js"></script>-->

				  <script src="/wp-content/themes/bcuwptheme/responsive/js/bootstrap.min.js"></script>

				  <!--<script src="https://www.benefitscheckup.org/wp-content/themes/bcuwptheme/mqc.js"></script>	-->			

					<link href="/wp-content/themes/bcuwptheme/responsive/css/bootstrap.min.css" rel="stylesheet" type="text/css">

					

					<link href="/wp-content/themes/bcuwptheme/bcu.css" rel="stylesheet" type="text/css">

				  <script type="text/javascript">

				 

				  	$(function() {

				  		$.get("//www.benefitscheckup.org/cf/populateWPheader.cfm");

				  	});

				  	

				 

				  

				  </script>	

				  				  <script src="/wp-content/themes/bcuwptheme/snap.js"></script>

				  		

	<script>

dataLayer = [{

        'partner_id': '0',

        'partner_name': '',

        'subset_id': '0',

        'state': '',

}];

</script>

	

        <title>BenefitsCheckUp.org</title>


		<script type="text/javascript">

		

		  var _gaq = _gaq || [];

		  _gaq.push(['_setAccount', 'UA-2674020-2']);

		  _gaq.push(['_setDomainName', 'benefitscheckup.org']);

		  _gaq.push(['_trackPageview']);

		

		  (function() {

		    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;

		    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';

		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);

		  })();

		

		</script>

		

            <!-- move into mqc.js? only if it's used in the mqc files and not the ecu files -->

            <!--

            <script src="https://www.benefitscheckup.org/wp-content/themes/bcuwptheme/application.js"></script>

            <script src="https://www.benefitscheckup.org/wp-content/themes/bcuwptheme/ecu.js"></script>

		<script src="/cf/js/infinite-rotator.js" type="text/javascript"></script>

 <script src="https://www.benefitscheckup.org/wp-content/themes/bcuwptheme/ecu_liveonly.js"></script>-->

		

	     <link rel="stylesheet" href="/wp-content/themes/bootswatch/bootstrap/css/font-awesome.css">		

	</head>



	<body class="page" data-spy="scroll">


<!-- Google Tag Manager -->

<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHJ4LQ"

height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>

<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':

new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],

j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=

'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);

})(window,document,'script','dataLayer','GTM-PHJ4LQ');</script>

<!-- End Google Tag Manager -->


  	<div class="container" id="top-bar">

    	<div class="row">

    		<div id="top-logo" class="span12">

  				<a target="_blank" href="http://www.ncoa.org"><img src="/wp-content/themes/bcuwptheme/images/ncoa-logo-top.png" alt="National Council on Aging" title="National Council on Aging" alt="National Council on Aging" /></a>

    		</div>

        </div>    

   </div>

   

	<div class="container" id="header">

    	<div class="row-fluid">    

    		<div id="header_logo" class="span5">

	              <a href="/" class="block"><img src="/wp-content/themes/bcuwptheme/images/logos/bcu.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" /><!--<img src="/wp-content/uploads/2011/11/bcu_10th-anni-logo.png" title="BenefitsCheckUp" alt="BenefitsCheckUp" />--></a>                  

	     	</div>	     		

            

             <div class="span5 statistics" id="logo" ><p>

			We have helped <strong> 4,180,045 </span></strong> 

			people find over <strong> $15.2 billion </span></strong> worth of benefits.

		</p>

                 </div>  

                 	</div>

     </div>

	

		<div class="container navbar" id="main-nav">

		<div class="navbar-inner">           

	        <div class="container" >

				<div id="main-nav" class="navbar row-fluid">

		           <ul id="home-nav" role="navigation" >

		           		               <li><a href="/" >Home</a></li>

		               <li><a href="/find-help" class='current'>Find Help</a></li>

		               <li><a href="/about-us" >About Us</a></li>	

		               <li><a href="/our-sponsors" >Our Sponsors</a></li>				

		               <li><a href="/news" >News</a></li>

		               <li><a href="https://secure3.convio.net/ncoa/site/SPageServer?pagename=donationform" class="" target="_blank">Donate</a></li>

		           </ul>

	           </div>	

	       </div>

		</div>

	</div>

	     

   <div class="container">     

			
<!--- END HEADER --->