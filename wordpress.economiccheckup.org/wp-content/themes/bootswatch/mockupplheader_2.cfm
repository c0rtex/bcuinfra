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
        <link href="/cf/bootswatch/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="/cf/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
        
       
        
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="bootstrap/js/html5shiv.js"></script>
    <![endif]-->

  <script>
  $(document).ready(function(){
    $("#commentForm").validate();
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
                <div class="span6 bculogo">
                	<a href="https://www.benefitscheckup.org" target="_new" class="block">                  <img src="/wp-content/themes/bcuwptheme/images/logos/bcu.png" alt="BenefitsCheckup" title="BenefitsCheckup" > </a><br><BR>
              	</div>
                
                <div class="span6">
                <img src="img/partners/humanarc/logo.gif" border="0" alt="Human Arc" title="Human Arc">
               	</div>
               
            </div><!--end header -->
            <div id="main-nav" class="navbar row-fluid">
                <ul id="home-nav" class="row-fluid">
                    <li id="esi-home" class="span2"><a class="current_tab" href="/cf/mockup_esi_home.cfm">Home</a></li>
                    <li class="span2"><a href="#">Get&nbsp;Started</a></li>
                    <li class="span2"><a href="/cf/frmwelcome2.cfm?subset_id=0&amp;partner_id=77">BenefitsCheckUp</a></li>				
                    <li id="esi-about" class="span2"><a href="/cf/mockup_esi_about.cfm">About Us</a></li>
                    <li id="esi-news" class="span2"><a href="#">News</a></li>
                    <li id="esi-donate" class="span2"><a href="#">Donate</a></li>
                    <li class="extra_help">
<a href="https://esidtc.benefitscheckup.org/cf/lisapp/index.cfm?partner_id=47&amp;skipintro=true" onclick="this.href='https://esidtc.benefitscheckup.org/cf/dispatch.cfm?cfid=2818&amp;cftoken=62640846&amp;source_id=1&amp;prev_id=0&amp;org_id=0&amp;partner_id=47&amp;subset_id=0&amp;language_id=EN&amp;access_id=0&amp;client_id=NULL&amp;user_id=NULL&amp;test_id=0&amp;skipintro=true&amp;bcu_url=https%3A%2F%2Fredesign%2Ebenefitscheckup%2Eorg%2Fcf%2Flisapp%2Findex%2Ecfm%3Fpartner%5Fid%3D47%26skipintro%3Dtrue';">Apply for Extra Help</a>
</li>
                </ul>	
            </div>
            <div class="content row-fluid">
            	<div class="row-fluid" id="outercontainer">