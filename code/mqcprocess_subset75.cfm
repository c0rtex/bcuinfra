<cfparam name="page" type="numeric" default="0">
<cfparam name="edit" type="numeric" default="0">
<cfparam name="continue" type="numeric" default="0">
<cfparam name="badResponseList" type="string" default="">
<cfparam name="session.screening.recap" default="0">
<cfparam name="url.repop" default="false">
<cfset session.reloadpage = "false">
<cfset session.SCREENING.PGNO = 2>
<cfset session.subset_id = 75>
<cfset session.org_id = 0>
<cfset session.partner_id = 14>
<cfset session.source_id = 1>
<cfset session.client_id=''>
<cfset session.user_id =''>
<cfset session.prev_id  =''>
<cfset session.access_id  =''>
<cfset session.STATE_ID =''>
<cfset session.test_ID =''>
<cfset session.language_id = 'EN'>


<!doctype html>

<!--[if lt IE 7]><html dir="ltr" lang="en-US" class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html dir="ltr" lang="en-US" class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html dir="ltr" lang="en-US" class="no-js lt-ie9"><![endif]-->
<!--[if gt IE 8]><!--> <html dir="ltr" lang="en-US" class="no-js"><!--<![endif]-->

	<head>
		<meta charset="utf-8">

		<title>Medicare QuickCheck Processing....</title>
		
		<meta name="language" content="en-US" />
		<meta name="lang" content="en" />

		<!-- Google Chrome Frame for IE -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

		<!-- mobile meta -->
		<meta name="HandheldFriendly" content="True">
		<meta name="MobileOptimized" content="320">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

		<!-- icons & favicons -->
		<link rel="apple-touch-icon" href="/wp-content/themes/bcuwptheme/library/images/apple-icon-touch.png">
		<link rel="icon" href="/wp-content/themes/bcuwptheme/favicon.png">
		<!--[if IE]>
			<link rel="shortcut icon" href="/wp-content/themes/bcuwptheme/favicon.ico">
		<![endif]-->
		


  	<link rel="pingback" href="https://www.benefitscheckup.org/xmlrpc.php">
  	
  	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  	   <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  	   <!--[if lt IE 9]>
  	     <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  	     <script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
  	<![endif]-->
  	
		<link rel="alternate" type="application/rss+xml" title="BenefitsCheckUp.org &raquo; Feed" href="https://wwwt.benefitscheckup.org/feed/" />
<link rel="alternate" type="application/rss+xml" title="BenefitsCheckUp.org &raquo; Comments Feed" href="https://wwwt.benefitscheckup.org/comments/feed/" />

<link rel="stylesheet" href="/wp-content/plugins/fancybox-for-wordpress/css/fancybox.css" type="text/css" media="screen" />

	<style type="text/css">
		div#fancy_inner {border-color:#BBBBBB}
		div#fancy_close {right:-15px;top:-12px}
		div#fancy_bg {background-color:#FFFFFF}
			</style>

	<link rel='stylesheet' id='my-style-css'  href='/wp-content/plugins/auto-font-resizer-plugin-for-wordpress/jfontsize.css?ver=3.2.1' type='text/css' media='all' />
<link rel='stylesheet' id='rbcu-stylesheet-css'  href='/wp-content/themes/bcuwptheme/responsive/css/bootstrap.min.css?ver=3.2.1' type='text/css' media='all' />
<link rel='stylesheet' id='rbcu-mqc-stylesheet-css'  href='/wp-content/themes/bcuwptheme/mqc.css?ver=3.2.1' type='text/css' media='all' />

<script type='text/javascript' src='/wp-content/plugins/auto-font-resizer-plugin-for-wordpress/jquery-1.5.js?ver=3.2.1'></script>
<script type='text/javascript' src='/wp-content/plugins/auto-font-resizer-plugin-for-wordpress/jquery.jfontsize-1.0.js?ver=3.2.1'></script>
<script type='text/javascript' src='https://wwwt.benefitscheckup.org/wp-includes/js/jquery/jquery.js?ver=1.6.1'></script>
<script type='text/javascript' src='/wp-content/plugins/fancybox-for-wordpress/js/jquery.fancybox-1.2.6.min.js?ver=1.3.2'></script>
<script type='text/javascript' src='/wp-content/plugins/vslider/js/vslider.js?ver=3.2.1'></script>
<link rel="EditURI" type="application/rsd+xml" title="RSD" href="https://wwwt.benefitscheckup.org/xmlrpc.php?rsd" />
<link rel="wlwmanifest" type="application/wlwmanifest+xml" href="https://wwwt.benefitscheckup.org/wp-includes/wlwmanifest.xml" /> 
<link rel='index' title='BenefitsCheckUp.org' href='https://wwwt.benefitscheckup.org/' />
<link rel='prev' title='test mqc layout' href='https://wwwt.benefitscheckup.org/?page_id=12390' />
<meta name="generator" content="WordPress 3.2.1" />
<link rel="stylesheet" href="/wp-content/plugins/communications/comms.css" type="text/css" />
  

<!-- Fancybox for WordPress v2.7.5 -->

<script type="text/javascript">

	jQuery.noConflict();

	jQuery(function(){

				jQuery.fn.getTitle = function() {
			var arr = jQuery("a.fancybox");
			jQuery.each(arr, function() {
				var title = jQuery(this).children("img").attr("title");
				jQuery(this).attr('title',title);
			})
		}

		// Supported file extensions
		var thumbnails = 'a:has(img)[href$=".bmp"],a:has(img)[href$=".gif"],a:has(img)[href$=".jpg"],a:has(img)[href$=".jpeg"],a:has(img)[href$=".png"],a:has(img)[href$=".BMP"],a:has(img)[href$=".GIF"],a:has(img)[href$=".JPG"],a:has(img)[href$=".JPEG"],a:has(img)[href$=".PNG"]';

	
		jQuery(thumbnails).addClass("fancybox").attr("rel","fancybox").getTitle();

			jQuery("a.fancybox").fancybox({
			'imageScale': true,
			'padding': 10,
			'zoomOpacity': true,
			'zoomSpeedIn': 500,
			'zoomSpeedOut': 500,
			'zoomSpeedChange': 300,
			'overlayShow': true,
			'overlayColor': "#666666",
			'overlayOpacity': 0.7,
			'enableEscapeButton': true,
			'showCloseButton': true,
			'hideOnOverlayClick': true,
			'hideOnContentClick': false,
			'frameWidth':  560,
			'frameHeight':  340,
												'centerOnScroll': true
		});

})

</script>
<!-- END Fancybox for WordPress -->
<!-- Meta SEO Pack BEGIN -->
<meta name="keywords" content="benefit programs,prescription drug assistance,energy assistance,food stamps,tax relief,Medicare Part D,housing assistance,in-home services,nutrition,transportation,educational assistance,employment and volunteer Services" />
<meta name="description" content="Did you know? Medicare Part D plans change from year to year and not shopping around can be costly. According to the National Bureau for Economic Research, 90&#8230;" />
<meta name="robots" content="noodp,noydir" />
<!-- Meta SEO Pack END -->
<script charset="utf-8" type="text/javascript">var switchTo5x=false;</script><script charset="utf-8" type="text/javascript" src="https://ws.sharethis.com/button/buttons.js"></script><script type="text/javascript">stLight.options({publisher:'wp.d755296b-07e1-4859-98e1-2617b740015a'});var st_type='wordpress3.2.1';</script>
<!-- Using Simple Yearly Archive Plugin v1.2.5 | http://www.schloebe.de/wordpress/simple-yearly-archive-plugin/ // -->
		
				        
  			<!-- Need to upgrade WordPress so it gets a newer version of jQuery to work with Bootstrap -->
  			<script src="/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/jquery.validate.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/scrolltofixed.js"></script>
            <!-- move into mqc.js? only if it's used in the mqc files and not the ecu files -->
            <script src="/wp-content/themes/bcuwptheme/application.js"></script>

		
		<link rel="stylesheet" href="/wp-content/themes/bootswatch/bootstrap/css/font-awesome.css">
		<link type="text/css" rel="stylesheet" href="//fonts.googleapis.com/css?family=Roboto">
		<link type="text/css" rel="stylesheet" href="//fonts.googleapis.com/css?family=Roboto+Condensed">		
		<link href='//fonts.googleapis.com/css?family=Roboto:400,500,900' rel='stylesheet' type='text/css'>
		
	</head>

	<body class="page page-id-12390 page-template page-template-index-mqc-rev-php logged-in" data-spy="scroll" data-target=".sidebar-nav">

<!--
Start of DoubleClick Floodlight Tag: Please do not remove
Activity name of this tag: MQC View Your Report (Processing page)
URL of the webpage where the tag is expected to be placed: https://medicarequickcheck.benefitscheckup.org/cf/mqcprocess_subset75.cfm
This tag must be placed between the <body> and </body> tags, as close as possible to the opening tag.
Creation Date: 07/11/2014
-->
<script type="text/javascript">
var axel = Math.random() + "";
var a = axel * 10000000000000;
document.write('<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=NewTe0;cat=MQCVi0;ord=1;num=' + a + '?" width="1" height="1" frameborder="0" style="display:none"></iframe>');
</script>
<noscript>
<iframe src="https://4381487.fls.doubleclick.net/activityi;src=4381487;type=NewTe0;cat=MQCVi0;ord=1;num=1?" width="1" height="1" frameborder="0" style="display:none"></iframe>
</noscript>
<!-- End of DoubleClick Floodlight Tag: Please do not remove -->
  	<div class="container" id="top-bar">
    	<div class="row">
    		<div id="top-logo" class="span12">
  				<img src="/wp-content/themes/bcuwptheme/images/ncoa-logo-top.png" alt="National Council on Aging">
    		</div>
        </div>    
   </div>
   
	<div class="container" id="header">
    	<div class="row">    
    		<div id="header_logo" class="span10">
	              <a href="http://www.mymedicarematters.org" target="_blank"><img src="/wp-content/themes/bcuwptheme/images/mmm-logo.png" alt="My Medicare Matters" title="My Medicare Matters" /></a>
	     	</div>
    	</div>
     </div>
     <div class="container">      
			
			
			<div id="content">
			
				<div id="inner-content" class="row-fluid">
			
				    <div id="main" class="span12 col-md-8" role="main">
                                              <div class="row-fluid">
                    

					    					
					    	<div class="span8"> 
<center><img alt="MedicareQuickCheck" title="Medicare QuickCheck Logo" src="/wp-content/uploads/2013/12/Medicare-QuickCheck.jpg"></center>
	
       
        <div class="whitewell span12" >
	  <div class="span4" align="center">
            <img src="/cf/img/gears_animated.gif"><br /><br />
	  </div>
	  <div  class="span8" >
            <h4>Did you know?</h4>

<cfset texttoshow = RandRange(0, 6 )>
<cfif texttoshow eq 1>
		<h4>Medicare Part D plans change from year to year and not shopping around can be costly. According to the National Bureau for Economic Research, 90 percent of people with Medicare Part D could save an average of $300 per year by switching to a different plan.</h4><br /><br />
<cfelseif texttoshow eq 2>
		<h4>If you are working for an employer with 20 or more employees who provides
your health insurance, you don't need to take Part B when you initially sign up
for Medicare. This can save you at least $100 per month.</h4><br /><br />
<cfelseif texttoshow eq 3>
		<h4>Medicare offers a "Welcome to Medicare Physical" within the first year of
your enrollment in Part B.  This is the only time Medicare covers an annual
physical and is a great way to get a "baseline" on your health status that can
be checked annually.</h4><br /><br />
<cfelseif texttoshow eq 4>
		<h4>You can join Part B when you retire, but then may opt out again if you go
back to work for an employer who offers you health insurance. You can think
about that second or third career!</h4><br /><br />
<cfelseif texttoshow eq 5>
		<h4>It's important to check whether your supplemental Medicare coverage will
still be in effect if you travel for an extended period of time. Don't spoil
your winter getaway with unexpected health costs!</h4><br /><br />
<cfelse>
		<h4>Signing up with www.mymedicare.gov will give you access to all of your
billing information and send you reminders of when free preventive visits are
due.</h4><br /><br />
</cfif>
<p>Please do not leave this page while we gather your results.<br /></p>
	  </div>
	 
	
        </div>
                      
</div> 
					
					    	
					
					
					    						</div>
				    </div> <!-- end #main -->
				    
    				<!--<div class="col-md-3">
				   						    </div>-->
				    
				</div> <!-- end #inner-content -->
    
			</div> <!-- end #content -->

		</div> <!-- end of container -->
        <div class="container" id="footer">
        	<div class="row">
			
				<!-- this is the footer for MQC; for testing purposes only -->
				
				<div class="span3">
			        <a target="_new" href="http://www.ncoa.org/"><img src="/wp-content/themes/bcuwptheme/images/BCUfooter-ncoa-logo.png" alt="NCOA" title="NCOA"></a>
			    </div>
				
			    <div class="span9">
			        <ul id="footer_links">
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/about/">About This Site</a>
			            </li>
			            <li class="footer_divider">|</li>
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/privacy-policydisclaimers/">Privacy Policy</a>
			            </li>
			            <li class="footer_divider">|</li>
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/get-help/contact-us/">Contact Us</a>
			            </li>
			            <li class="footer_divider">|</li>
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/get-help/faq/">FAQs</a>
			            </li>
			            <li class="footer_divider">|</li>
			            <li>
			                <a target="_new" href="https://www.mymedicarematters.org/get-help/glossary/">Glossary</a>
			            </li>
			        </ul>
	
			        <ul id="socialnetwork_links">
			            <li>
			                <a target="_new" href="https://www.facebook.com" id="facebook_link"></a>
			            </li>
			            <li>
			                <a target="_new" href="https://www.twitter.com" id="twitter_link"></a>
			            </li>
			            <li>
			                <a target="_new" href="https://www.pinterest.com" id="pinterest_link"></a>
			            </li>
			            <li>
			                <a target="_new" href="https://www.mysocialnetwork.com" id="socialnetwork_link"></a>
			            </li>
			        </ul>
			    </div>
			
			
			</div>
		
		</div> <!-- end .container -->
				
				
		<script type="text/javascript">
		//this is from the MQC footer
		 $(function() {
		$(".learnMore").hide();
		       $(".showMore").click(function() {
		  $showId = "#" + $(this).attr("id") + "_more";
		           $($showId).show();
		           return false;
		       });        
		   });
		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new
		Date();a=s.createElement(o),
		 
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		
		  ga('create', 'UA-2674020-11', 'benefitscheckup.org');
		  ga('send', 'pageview');
		
		</script>

	</body>

</html> <!-- end page -->


<cfflush>
<!--- Process Report from wordpress page questionnaire --->
<cfif isdefined('form.mqc_medicare_enroll')>
	<cfif form.mqc_medicare_enroll eq 'mqc_medicare_enroll_past_3_months'>
		<cfset form.mqc_medicare_enroll_past_3_months = 'y'>
	</cfif>
</cfif>
<cfif isdefined('form.mqc_medicare_enroll_no')>
	<cfif form.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_3_months'>
		<cfset form.mqc_medicare_enroll_within_3_months = 'y'>
	<cfelseif form.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_1_year_no'>
		<cfset form.mqc_medicare_enroll_within_1_year_no = 'y'>
	<cfelseif form.mqc_medicare_enroll_no eq 'mqc_medicare_enroll_within_1_year_yes'>
		<cfset form.mqc_medicare_enroll_within_1_year_yes = 'y'>
	</cfif>
</cfif>
<cfif isdefined('form.mqc_medicare_enroll_situation')>
	<cfif form.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_within_1_year_yes'>
		<cfset form.mqc_medicare_enroll_within_1_year_yes = 'y'>
	<cfelseif form.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_disability_yes'>
		<cfset form.mqc_medicare_enroll_disability_yes = 'y'>
	<cfelseif form.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_disability_no'>
		<cfset form.mqc_medicare_enroll_disability_no = 'y'>
	<cfelseif form.mqc_medicare_enroll_situation eq 'mqc_medicare_enroll_age_65'>
		<cfset form.mqc_medicare_enroll_age_65 = 'y'>
	<cfelseif form.mqc_medicare_enroll_situation eq 'mqc_not_sure_medicare_qualify'>
		<cfset form.mqc_not_sure_medicare_qualify = 'y'>
	</cfif>
</cfif>
<cfset form.satisfied_yes = "">
<cfset form.satisfied_no = "">
<cfset form.mqc_employees_lt_20_self = "">
<cfset form.mqc_employees_gt_20_self = "">
<cfset form.mqc_employees_gt_100_self = "">
<cfset form.mqc_employees_dont_know  = "">
<cfset form.mqc_employees_lt_20_spouse = "">
<cfset form.mqc_employees_gt_20_spouse = "">
<cfset form.mqc_employees_gt_100_spouse = "">
<cfset form.mqc_employees_dont_know_spouse  = "">

<cfif isdefined('form.mqc_coveragesatisfaction_2')>
	<cfif form.mqc_coveragesatisfaction_2 eq 'satisfied_yes'>
		<cfset form.satisfied_yes = "y">
	<cfelseif form.mqc_coveragesatisfaction_2 eq 'satisfied_no'>
		<cfset form.satisfied_no = "y">
	</cfif>
</cfif> 
<cfif isdefined('form.mqc_number_employees_self')>
	<cfif form.mqc_number_employees_self eq 'mqc_employees_lt_20_self'>
		<cfset form.mqc_employees_lt_20_self = "y">
	<cfelseif form.mqc_number_employees_self eq 'mqc_employees_gt_20_self'>
		<cfset form.mqc_employees_gt_20_self = "y">
	<cfelseif form.mqc_number_employees_self eq 'mqc_employees_gt_100_self'>
		<cfset form.mqc_employees_gt_100_self = "y">
        <cfelseif form.mqc_number_employees_self eq 'mqc_employees_dont_know'>
		<cfset form.mqc_employees_dont_know = "y">
	</cfif>
</cfif>
<cfif isdefined('form.mqc_number_employees_spouse')>
	<cfif form.mqc_number_employees_spouse eq 'mqc_employees_lt_20_spouse'>
		<cfset form.mqc_employees_lt_20_spouse = "y">
	<cfelseif form.mqc_number_employees_spouse eq 'mqc_employees_gt_20_spouse'>
		<cfset form.mqc_employees_gt_20_spouse = "y">
	<cfelseif form.mqc_number_employees_spouse eq 'mqc_employees_gt_100_spouse'>
		<cfset form.mqc_employees_gt_100_spouse = "y">
        <cfelseif form.mqc_number_employees_spouse eq 'mqc_employees_dont_know_spouse'>
		<cfset form.mqc_employees_dont_know_spouse = "y">
	</cfif>
</cfif>

<cfif isdefined('form.mqc_medicarecoverage')>
	<cfif form.mqc_medicarecoverage eq 'mqc_originalmedicare'>
		<cfset form.mqc_originalmedicare = "y">
	<cfelseif form.mqc_medicarecoverage eq 'mqc_medhealthplan'>
		<cfset form.mqc_medhealthplan = "y">
	<cfelseif form.mqc_medicarecoverage eq 'mqc_justenrolled'>
		<cfset form.mqc_justenrolled = "y">
        <cfelseif form.mqc_medicarecoverage eq 'mqc_dontknowcoverage'>
		<cfset form.mqc_dontknowcoverage = "y">
	</cfif>
</cfif>

<cfif not isdefined('form.MQC_EMPLOYEES_LT_20_SELF')>
	<cfset form.MQC_EMPLOYEES_LT_20_SELF = "">
</cfif> 
<cfif not isdefined('form.MQC_EMPLOYEES_DONT_KNOW_SPOUSE')>
	<cfset form.MQC_EMPLOYEES_DONT_KNOW_SPOUSE = "">
</cfif> 
<cfif not isdefined('form.MQC_EMPLOYEES_DONT_KNOW')>
	<cfset form.MQC_EMPLOYEES_DONT_KNOW = "">
</cfif> 
<cfif not isdefined('form.MQC_NOT_RECEIVING_PARTA')>
	<cfset form.MQC_NOT_RECEIVING_PARTA = "">
</cfif> 
<cfif not isdefined('form.SATISFIED_NO')>
	<cfset form.SATISFIED_NO = "">
</cfif> 
<cfif not isdefined('form.MQC_HEALTH_INSURANCE_CREDITABLE')>
	<cfset form.MQC_HEALTH_INSURANCE_CREDITABLE = "">
</cfif>
<!---cf_sessionLoadVarsPHP --->
<cfif isdefined('form.screeningID') >
	<cfif isdefined('url.debug')>	
		<cfoutput>rescreen #form.screeningID#</cfoutput>
   	</cfif>
<!--- handleScreeningPHP initvarname="accumAFList" debug="false" action="start" screening_id="#form.screeningID#" --->
<cfset session.screening_id = form.screeningID>
</cfif>
<cf_handleScreeningPHP initvarname="accumAFList" debug="false">
<!---cfdump var="#form#" --->
<!--- Log Screening Data , Validate and Set values to database --->
<cf_logScreeningInputPHP initvarname="accumAFList" useOptionCodes="true" debug="true">
<cfflush>
<!--- Check for Validation Errors if so return to form --->
<cfif badResponseList neq ''>
  <cfif isdefined('url.debug') >
	<cfoutput><p>ScreeningID: #session.screening_id# badResponseList: #badResponseList#</p></cfoutput>
	<cfabort>
  <cfelseif session.subset_id eq 75>
       <cfoutput><meta http-equiv="refresh" content="0;url=/medicare-quick-check/?badresponselist=#badResponseList#&screeningID=#session.screening_id#"></cfoutput>
  <cfelse>
	<cfoutput><meta http-equiv="refresh" content="0;url=/quickcheck-ce/?badresponselist=#badResponseList#&screeningID=#session.screening_id#"></cfoutput>
  </cfif>
<cfelse>
	<cfinclude template="getcontentrules.cfm">
	<cfset tmpScreeningID = session.screening_id>
	<cfif session.subset_id eq 72>
		<cfinclude template="procMQCShadowPHP.cfm">
	<cfelse>
		<cf_handleScreening action="end" screening_id="#session.screening_id#">
	</cfif>
	<cfset appendURL = "">
	<cfif isdefined('form.click_id') and isdefined('form.CID') and  isdefined('form.PID')>
		<cfset appendURL = "&click_id=#form.click_id#&CID=#form.CID#&PID=#form.PID#">
	</cfif>
	<cfoutput><meta http-equiv="refresh" content="0;url=/mqc-results-3/?screeningID=#tmpScreeningID#&shadowID=#session.screening_id#&request_id=#session.cfid#-#cftoken##appendURL#"></cfoutput>
		<cfabort>
</cfif>
