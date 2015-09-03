<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="session.screening.recap" default="0">
<cfparam name="url.repop" default="false">
<cfset session.reloadpage = "false">
<cfset session.SCREENING.PGNO = 2>
<cfset session.subset_id = 63>
<cfset session.org_id = 0>
<cfset session.partner_id = 77>
<cfset session.source_id = 1>
<cfset session.client_id=''>
<cfset session.user_id =''>
<cfset session.prev_id  =''>
<cfset session.access_id  =''>
<cfset session.STATE_ID =''>
<cfset session.test_ID =''>
<cfset session.language_id = 'EN'>
<cfoutput>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>EconomicCheckUp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="language" content="en-US" />
	<meta name="lang" content="en" />
	<meta name="description" content="EconomicCheckUp helps you find benefit programs that can help pay for medications, health care, food, utilities and more. All from a reliable and trusted source." />
	<meta name="keywords" content="benefit programs, prescription drug assistance, Medicare Part D, extra help, low income subsidy, LIS, Medicare Savings Programs, QMB, SLMB, QI, nutrition, food stamps, SNAP, supplemental nutrition assistance program,  energy assistance, LIHEAP, tax relief, reverse mortgage, foreclosure counseling, housing assistance, in-home services, transportation, educational assistance, employment and volunteer services." />
	<meta name="Copyright" content="Copyright NCOA 2013" />

		<script src="/cf/bootswatch/bootstrap/js/jquery.js"></script>
        <script type="text/javascript" src="/cf/bootswatch/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/cf/bootswatch/bootstrap/js/jquery.validate.js"></script>
		<script type="text/javascript" src="/cf/bootswatch/bootstrap/js/bootstrap.js"></script>
		<script src="/cf/bootswatch/bootstrap/js/bootstrap-tooltip.js" type="text/javascript"></script>
		<script type="text/javascript" src="/cf/bootswatch/js/scrolltofixed.js"></script>
    	<script src="/cf/bootswatch/bootstrap/js/application.js"></script>
		
		<link rel="stylesheet" href="/cf/bootswatch/css/font-awesome.css">
		<link href="/cf/bootswatch/bootstrap/css/style.css" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet">		
        <link href="/cf/bootswatch/bootstrap/css/bootstrap_esi.min.css" rel="stylesheet">
        <link href="/cf/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
        
       
        
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="/cf/bootswatch/bootstrap/js/html5shiv.js"></script>
    <![endif]-->

  <script>
  $(document).ready(function(){
    $("##commentForm").validate();
  });
  </script>
  </head>

  <body data-spy="scroll" data-target=".sidebar-nav">
		<script>
			$(document).ready(function() {
		  	var sidebar = $('.sidebar-nav');
		  	sidebar.scrollToFixed({
			marginTop: $('.navbar').outerHeight(true) + 50,
			zIndex: 999
		  	});
	
		  	var body_headers = $('.body-header');              
			body_headers.each(function(i) {
			var body_header = $(body_headers[i]);
			var next = body_headers[i + 1];
	
			body_header.scrollToFixed({
				marginTop: $('.navbar').outerHeight(true) ,
				limit: function() {
				var limit = 0;
				if (next) {
					limit = $(next).offset().top + $(this).outerHeight(true);
				} 
				return limit;
				},
					zIndex: 999
				});
			}); 
			});

		</script>
		<div class="container-fluid">
            <div id="header" class="row-fluid">
            	<div class="span12"><a href="http://www.ncoa.org" target="_blank"><img id="topbar" alt="National Council on Aging" title="National Council on Aging" src="/wp-content/themes/bcuwptheme/images/logos/ncoa_top.png"></a><BR></div>
         	</div>
           <div id="header" class="row-fluid">
                <div class="span5">
                	<a href="http://www.ncoa.org/enhance-economic-security/economic-security-Initiative/" target="_new" class="block">                  <img src="/wp-content/uploads/2014/12/ECU-PNG-Logo-2015.png" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" alt="EconomicCheckUp" id="logo"></a><br><br>
              	</div>
               	<div class="span7 statistics" id="logo"><br>Since 2010, we've helped thousands of older adults find work, budget their money, and save on daily expenses.
                </div>
            </div><!--end header -->
            <div id="main-nav" class="navbar row-fluid">
                <ul id="home-nav" class="row-fluid">
                    <li id="esi-home" class="span2"><a href="/esi-home">Home</a></li>
                    <li id="esi-spq" class="span2"><a href="/esi-questions" class="current_tab">My&nbsp;CheckUp</a></li>
		    		<li id="esi-help" class="span2"><a href="/esi-find-help">Resources</a></li>
                    <li id="esi-about" class="span2"><a href="/esi-about">About Us</a></li>				
                    <li id="esi-news" class="span2"><a href="/esi-news">News</a></li>
                    <li id="esi-donate" class="span2"><a href="http://www.ncoa.org/Donate" class="" target="_blank">Donate</a></li>
                </ul>	
            </div>
            <div class="content row-fluid">
            	<div class="row-fluid" id="outercontainer">


<!--- wait message  --->
<div class="span12">  
	<section id="factsheet">  	
        <div class="body-header-wrapper">	<h2><i class="icon-refresh "></i> Processing Results </h2>	
            <div class="body-header" style="z-index: 999; position: static; top: 251.5px;">
                <div class="body-header-inner">
                    <div class="">
                            
                    </div>
                </div>
            </div>
            <div style="display: none; width: 620px; height: 0px; float: none;"></div>
        </div>
        <div class="whitewell"><br><br><br>
            <h4>&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/gears_animated.gif"> &nbsp;&nbsp;&nbsp;&nbsp;We are calculating your results. Please wait.</h4>
          
        </div>
      </section>
                    
</div> 
<!--span8-->
<div class="span2">
  
</div>


        	</div>    
       	</div>
  	</div>
     <div id="footer">
		<div class="sub-wrapper">	


<div id="bcu" class="span2">
					<h2>EconomicCheckUp:</h2>
						<ul>
							<li><a href="/esi-questions">My CheckUp</a></li>
							<li><a href="/esi-find-help">Resources</a></li>
							<li><a href="/esi-about">About Us</a></li>
							<li><a href="/esi-news">News</a></li>
							<li><a href="http://www.ncoa.org/Donate" target="_blank">Donate</a></li>
							<li><a href="/esi-privacy-policy/">Privacy Policy</a></li>
							<li><a href="/esi-termsofuse/">Terms of Use</a></li>
							<li><a href="https://www.surveymonkey.com/s/3V39M9Z">Feedback</a></li>
							<li><a href="mailto:economiccheckup@ncoa.org">Contact Us</a></li>
							<li><a target =_blank href="https://oe.benefitscheckup.org/oe/?partner_id=77">Partner Login</a></li>
						</ul>
				</div>
                <div id="other" class="span2 sites">
                    <h2>Other NCOA Sites:</h2>
						<ul>

<li><a target=_blank href="http://NCOA.org/">NCOA.org</a></li>
<li><a target=_blank href="http://www.benefitscheckup.org/">BenefitsCheckUp&reg;</a></li>

<li><a target=_blank href="http://www.mymedicarematters.org/">My Medicare Matters&reg;</a></li>

<li><a target=_blank href="http://www.ncoa.org/enhance-economic-security/center-for-benefits/">Center for Benefits Access</a></li>

<li><a target=_blank href="http://www.ncoa.org/improve-health/center-for-healthy-aging/">Center for Healthy Aging</a></li>

<li><a href="http://www.ncoa.org/national-institute-of-senior-centers/" target="_blank">National Institute of Senior Centers</a></li>



						</ul>
                  	</div>
					                    <div id="pressroom" class="span2 sites">
					<h2>Press Room:</h2>
						<ul>
							<li><a target="_blank" href="http://ncoa.org/press-room/">Overview</a></li>
							<li><a target="_blank" href="http://ncoa.org/press-room/press-release/">Press Releases</a></li>
							<li><a target="_blank" href="http://ncoa.org/press-room/news.html">News</a></li>
							<li><a target="_blank" href="http://ncoa.org/press-room/fact-sheets/">Fact Sheets</a></li>
                            <li><a target="_blank" href="http://www.ncoa.org/press-room/thought-leader/">Thought Leaders</a></li>
						</ul>
					</div>
                   <div id="about" class="span2 sites">
					<h2>About NCOA:</h2>
						<ul>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/">Overview</a></li>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/our-impact/">Our Impact</a></li>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/locations.html">Locations</a></li>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/leadership/">Leadership</a></li>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/funders/">Funders</a></li>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/annual-report.html">Annual Report</a></li>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/careers/">Careers</a></li>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/contact-us/">Contact Us</a></li>
						</ul>
					</div>
                   <!-- <div id="f-stay-connected" class="sites"> -->
                   <div id="f-stay-connected" class="span2 sites">
					<h2>Stay Connected:</h2>
						<ul>
<!--
							<li class="fb"><a target=_blank href="http://www.facebook.com/NCOAging">NCOA on Facebook</a></li>
<li><a target=_blank href="http://www.twitter.com/NCOAging">NCOA on Twitter</a></li>

<li class="cr"><a target=_blank href="http://www.youtube.com/ncoaging">NCOA on YouTube</a></li>

<li class="cr"><a target=_blank href="http://www.ncoacrossroads.org">Crossroads Community for Professionals in Aging</a></li>

<li class="rss"><a target=_blank href="http://www.ncoa.org/system/rss/channel.jsp?feedID=277156535">RSS</a></li>
-->
	<li><a target="_blank" href="http://www.facebook.com/NCOAging">NCOA on Facebook</a></li>
	<li class="twitter"><a target="_blank" href="http://www.twitter.com/NCOAging">NCOA on Twitter</a></li>
	<li class="youtube"><a target="_blank" href="http://www.youtube.com/ncoaging">NCOA on YouTube</a></li>
	<li class="linkedin"><a target="_blank" href="https://www.linkedin.com/company/216832">NCOA on LinkedIn</a></li>
	<li class="cr"><a target="_blank" href="http://www.ncoacrossroads.org">Crossroads Community for Professionals in Aging</a></li>
	<li class="rss"><a target="_blank" href="http://www.ncoa.org/system/rss/channel.jsp?feedID=277156535">RSS</a></li>					
						</ul>
                	</div>




               	</div>
			<div id="footer-primary">
				<p><a href="http://www.ncoa.org/" target="_blank"><img title="National Council on Aging" alt="National Council on Aging" src="/wp-content/uploads/2011/11/BCUfooter-ncoa-logo.png"></a></p>		
<p id="ncoaAddress">251 18th Street South&nbsp;|&nbsp; Suite 500 &nbsp;| &nbsp;Arlington, VA 22202 &nbsp;|&nbsp; 571-527-3900</p>
			</div> <!-- end footer-primary -->

		</div> <!-- end sub-wrapper -->
	</div><!-- footer -->


</body>
</html> 
</cfoutput>
<cfflush>
<!--- Process Report from wordpress page questionnaire --->
<!---cf_sessionLoadVarsPHP --->
<cfif isdefined('form.screeningID') >
	<cfif isdefined('url.debug')>	
		<cfoutput>rescreen #form.screeningID#</cfoutput>
   	</cfif>
<!--- handleScreeningPHP initvarname="accumAFList" debug="true" action="start" screening_id="#form.screeningID#" --->
<cfset session.screening_id = form.screeningID>
</cfif>
<cf_handleScreeningPHP initvarname="accumAFList" debug="false">
<!---cfdump var="#form#" --->
<!--- Log Screening Data , Validate and Set values to database --->
<cf_logScreeningInputPHP initvarname="accumAFList" useOptionCodes="true" debug="false">
<cfflush>
<!--- Check for Validation Errors if so return to form --->
<cfif badResponseList neq ''>
  <cfif isdefined('url.debug')>
	<cfoutput><p>ScreeningID: #session.screening_id# badResponseList: #badResponseList#</p></cfoutput>
	<cfabort>
  <cfelse>
	<cfoutput><a href="/esi-questions?badresponselist=#badResponseList#&screeningID=#session.screening_id#">test</a></cfoutput>
  </cfif>
<cfabort>
<cfelse>
	<cfset tmpScreeningID = session.screening_id>
	<cfinclude template="procESIShadowPHP.cfm">
	<cfoutput><meta http-equiv="refresh" content="0;url=/esi-results/?screeningID=#tmpScreeningID#&shadowID=#session.screening_id#"></cfoutput>
</cfif>
