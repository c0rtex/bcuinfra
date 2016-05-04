<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="session.screening.recap" default="0">
<cfparam name="url.repop" default="false">
<cfparam name="url.esiprod" default="0">
<cfparam name="url.eversafe_id" default="0">
<cfparam name="url.eversafe" default="0">
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

	<cfif url.esiprod eq 1>
<cfset theUrl = "www">
<cfelse>
<cfset theUrl = "qa">

</cfif>

<cfif url.eversafe eq 0>
<cfset session.partner_id = 142>
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
            <h4>&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/gears_animated.gif"> &nbsp;&nbsp;&nbsp;&nbsp;We are calculating your results. Please wait. </h4>
          
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
							<li><a target="_blank" href="http://ncoa.org/news/">Overview</a></li>
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
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/our-impact/">Impact</a></li>
							<li><a target="_blank" href="http://www.ncoa.org/about-ncoa/leadership/">Leadership</a></li>
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
<cfelse>
<cfoutput>
<!----EVERSAFE--->

<!-- stylesheets -->
	<link rel="stylesheet" type="text/css" href="https://www.eversafe.com/css/compiled/theme.css?v=1"/>
	<link rel="stylesheet" type="text/css" href="https://www.eversafe.com/css/vendor/animate.css?v=1"/>
	<link rel="stylesheet" type="text/css" href="https://www.eversafe.com/css/vendor/entypo.css?v=1">
	<link rel="stylesheet" type="text/css" href="https://www.eversafe.com/css/vendor/font-awesome.min.css?v=1"/>
<style>

.footer-powered{
text-align: center;
}

@media (min-width: 767px) {
.esiprocess_eversafe{
margin-left: 100px;
}
}
</style>

	
	<!-- javascript -->
	<script src="https://www.eversafe.com/scripts/jquery/jquery-1.10.2.min.js?v=1"></script>
	<script src="https://www.eversafe.com/js/bootstrap/bootstrap.min.js?v=1"></script>
	<script src="https://www.eversafe.com/js/theme.js?v=1"></script>


<div class="hide"><script type="text/javascript">
		var url = 'https://www.eversafe.com/seam/resource/timage?ts=' + new Date().getTime();
		url += (window.location.search ? "&" + window.location.search.substring(1) : "");
		url += '&path=' + unescape(encodeURIComponent(window.location.pathname));
		document.write('<img width="1" height="1" src="' + url + '">');
	</script></div>

		<header class="navbar navbar-fixed-top navbar-inverse white header-eversafe" role="banner">
        <div class="container">

            <div class="log col-md-12 hidden-xs" style="z-index: 10 !important;">
                <a href="https://www.eversafe.com/static/login.scan" style="color: ##f09e38;" ><span class="entypo-key"></span>Log In</a>            </div>

            <div class="navbar-header">
                <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <div class="homelogo">
                    <a href="https://www.eversafe.com/index.html" class="navbar-brand"><img src="https://www.eversafe.com/images/logos/logo.png" alt="EverSafe"></a>
                    <a class="navbar-brand" href="https://www.eversafe.com/index.html"><span title="Home" class="entypo-house"></span></a>
                    <a class="navbar-brand" href="https://www.eversafe.com/contact-us.html"><span title="Contact Us" class="entypo-mail"></span></a>

                    <a href="https://www.eversafe.com/index.html" class="navbar-small"><img src="https://www.eversafe.com/images/logos/logo-i.png" alt="EverSafe"></a>
                    <a class="navbar-small" href="https://www.eversafe.com/index.html"><span class="entypo-house"></span></a>
                    <a class="navbar-small" href="https://www.eversafe.com/contact-us.html"><span class="entypo-mail"></span></a>
                </div>
            </div>

           <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
                <ul class="nav navbar-nav navbar-right" style="font-family: 'Merriweather', Georgia, serif; text-shadow: none;">
                    <li class="dropdown "><a href="https://www.eversafe.com/how-it-works.html" class="dropdown-toggle" style="text-shadow: none;"> How It Works </a></li>
                    <li class="dropdown "><a href="https://www.eversafe.com/pricing.html" class="dropdown-toggle" style="text-shadow: none;"> Pricing </a></li>
                    <li class="dropdown "><a href="https://www.eversafe.com/trusted-advocates.html" class="dropdown-toggle" style="text-shadow: none;">Why EverSafe</a></li>
                    <li class="dropdown "><a href="##" class="dropdown-toggle" data-toggle="dropdown" style="text-shadow: none;"> About Us <i class="icon-chevron-down" style="color: ##777; font-size: 8px; vertical-align: middle;"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="https://www.eversafe.com/our-story.html">Our Story</a></li>
                            <li><a href="https://www.eversafe.com/our-team.html">Our Team</a></li>
                            <li><a href="https://www.eversafe.com/eversafe-advisory-board.html">Advisory Board</a></li>
                            <li><a href="https://www.eversafe.com/press.html">Press</a></li>
                            <li><a href="https://www.eversafe.com/eversafe-appearances.html">EverSafe Appearances</a></li>
                            <li><a href="https://www.eversafe.com/contact-us.html">Contact us</a></li>
                        </ul>
                    </li>
                    <li class="dropdown"><a href="##" class="dropdown-toggle" data-toggle="dropdown" style="text-shadow: none;"> Resources <i class="icon-chevron-down" style="color: ##777; font-size: 8px; vertical-align: middle;"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="/elder-financial-abuse/overview.html">Elder Financial Abuse</a></li>
                            <li><a href="http://www.eversafe.com/blog/">EverSafe Blog</a></li>
                            <li><a href="https://www.eversafe.com/blog/elder-financial-abuse-in-the-news">General News</a>
                            <li><a href="http://#theUrl#.economiccheckup.org/eversafe-find-help">NCOA Resources</a>
<li><a href="http://www.ncoajobsource.org/" target="_blank">Find Jobs for Seniors</a>
                            <li><a href="https://calculator.benefitscheckup.org/calculators/make-a-budget-in-3-min" target="_blank">Budget Calculator</a>
<li><a href="http://#theUrl#.economiccheckup.org/home-eversafe">EconomicCheckUp Home</a></li>
                        </ul>
                    </li>
                    <li class="dropdown"><a href="http://#theUrl#.economiccheckup.org/esi-questions-eversafe" style="text-shadow: none;">EconomicCheckUp<span style="font-size: 0.8em">&reg;</span></a></li>
                    
                    <li class="dropdown"><a class="visible-xs entypo-key" href="https://www.eversafe.com/static/login.scan">Log In</a></li>
                    <li class="dropdown"><a class="visible-xs" href="https://www.eversafe.com/pricing.html">Sign Up</a></li>
                </ul>
            </nav>


 


        </div>
    </header>


	
<!--- wait message  --->
<div class="span12 esiprocess_eversafe">  
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
            <h4>&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/gears_animated.gif"> &nbsp;&nbsp;&nbsp;&nbsp;We are calculating your results. Please wait. </h4>
          
        </div>
      </section>
                    
</div> 

	<div class="footer-powered esiprocess_eversafe">

EconomicCheckUp&reg; is powered by the National Council on Aging.
<br>
&copy;2016 National Council on Aging. All Rights Reserved.
<br>

<a href="https://www.economiccheckup.org/esi-privacy-policy/">EconomicCheckUp® Privacy Policy </a>
| 
<a href="https://www.economiccheckup.org/esi-termsofuse/">EconomicCheckUp® Terms of Use</a>

<br>
<br>
</div>



	<div id="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-4 logos">
					<a target="blank" title="Elderscan, LLC, Information Technology Services, Columbia, MD" href="https://www.bbb.org/greater-maryland/business-reviews/information-technology-services/elderscan-in-columbia-md-90239055##bbbseal"><img src="https://www.eversafe.com/images/logos/bbbreg.png" alt="Elderscan, LLC, Information Technology Services, Columbia, MD"> </a>
					<a target="blank" href="https://trustsealinfo.websecurity.norton.com/splash?form_file=fdf/splash.fdf&dn=www.eversafe.com&lang=en">	<img src="https://www.eversafe.com/images/logos/norton.png" alt="norton"></a>
					<a target="blank" href="http://privacy.truste.com/privacy-seal/Elderscan,-LLC/validation?rid=348e0b2a-51cc-48f4-a855-8d591cf833ce">	<img src="https://www.eversafe.com/images/logos/trust.png" alt="truste"></a>
				</div>
				<div class="col-md-6 menu">
					<ul>
						<li>
		          			<a href="https://www.eversafe.com/terms.html">Terms of Use</a>
		        		</li>
		      			<li>
		          			<a href="https://www.eversafe.com/security.html">Security</a>
		        		</li>
		        		<li>
		        			<a href="https://www.eversafe.com/privacy.html">Privacy</a>
		        		</li>
		        		<li>
		          			<a href="http://www.eversafe.com/blog/">Blog</a>
		        		</li>
						<li>
		          			<a href="https://www.eversafe.com/contact-us.html">Contact Us</a>
		        		</li>
	      			</ul>
				</div>
				<div class="col-md-2 social">
					<a href="https://twitter.com/EverSafeSeniors" target="blank">
						<img src="https://www.eversafe.com/images/social/social-tw.png" alt="twitter" />
					</a>
					<a href="https://www.facebook.com/EverSafeSeniors" target="blank">
						<img src="https://www.eversafe.com/images/social/fbt.png" alt="facebook" />
					</a>					
				</div>
			</div>
			<div class="row credits">
				<div class="col-md-12">
					
					Copyright &##0169; 2016 Elderscan, LLC (d/b/a EverSafe) - All Rights Reserved 
				</div>
			</div>
		</div>
	</div>







</cfoutput>
</cfif>


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
<!--- Check for Validation Errors if so return to form otherwise go to report --->
<cfif badResponseList neq ''>
  <cfif isdefined('url.debug')>
	<cfoutput><p>ScreeningID: #session.screening_id# badResponseList: #badResponseList#</p></cfoutput>
	<cfabort>
  <cfelse>
      <cfif url.eversafe neq 0>
	<cfif url.esiprod eq 1>
	<cfoutput><a href="https://www.economiccheckup.org/esi-questions-eversafe?badresponselist=#badResponseList#&screeningID=#session.screening_id#">test</a></cfoutput>
  	<cfelse>
	<cfoutput><a href="http://qa.economiccheckup.org/esi-questions-eversafe?badresponselist=#badResponseList#&screeningID=#session.screening_id#">test</a></cfoutput>
  	</cfif>
     <cfelse> <!--- regular ESI --->
	<cfif url.esiprod eq 1>
	<cfoutput><a href="https://www.economiccheckup.org/esi-questions?badresponselist=#badResponseList#&screeningID=#session.screening_id#">test</a></cfoutput>
  	<cfelse>
	<cfoutput><a href="http://qa.economiccheckup.org/esi-questions?badresponselist=#badResponseList#&screeningID=#session.screening_id#">test</a></cfoutput>
  	</cfif>
     </cfif> <!--- end of Eversafe check --->
  </cfif>
<cfabort>
<cfelse>
	<cfset tmpScreeningID = session.screening_id>
	<cfinclude template="procESIShadowPHP.cfm">
      <cfif url.eversafe_id neq 0>
<!--- Lynna Cekova: add the Eversafe id together with the screening id into table ecu_eversafe --->
<cfquery datasource="#application.dbSrc#" name="insertEversafeID">
insert into ecu_eversafe (screening_id, eversafe_id) values (#tmpScreeningID#, #url.eversafe_id#);
		</cfquery>
</cfif>
      <cfif url.eversafe neq 0>


	<cfif url.esiprod eq 1>
	<cfoutput><meta http-equiv="refresh" content="0;url=https://www.economiccheckup.org/esi-results-eversafe/?screeningID=#tmpScreeningID#&shadowID=#session.screening_id#"></cfoutput>
	<cfelse>
		<cfoutput><meta http-equiv="refresh" content="0;url=http://qa.economiccheckup.org/esi-results-eversafe/?screeningID=#tmpScreeningID#&shadowID=#session.screening_id#"></cfoutput>
	</cfif>
       <cfelse> <!--- regular ESI --->
	<cfif url.esiprod eq 1>
	<cfoutput><meta http-equiv="refresh" content="0;url=https://www.economiccheckup.org/esi-results/?screeningID=#tmpScreeningID#&shadowID=#session.screening_id#"></cfoutput>
	<cfelse>
		<cfoutput><meta http-equiv="refresh" content="0;url=http://qa.economiccheckup.org/esi-results/?screeningID=#tmpScreeningID#&shadowID=#session.screening_id#"></cfoutput>
	</cfif>

</cfif>
</cfif>
 
