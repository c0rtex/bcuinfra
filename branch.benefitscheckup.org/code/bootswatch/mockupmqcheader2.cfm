<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>MedicareCheckUp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="language" content="en-US" />
	<meta name="lang" content="en" />
	<meta name="description" content="MedicareCheckUp helps you find benefit programs that can help pay for medications, health care, food, utilities and more. All from a reliable and trusted source." />
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
		<link href="/cf/bootswatch/bootstrap/css/mqc_style.css" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=PT+Sans&v1" rel="stylesheet">		
        <link href="/cf/bootswatch/bootstrap/css/bootstrap_esi2.min.mqc.css" rel="stylesheet">
        <link href="/cf/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
        
       
        
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="/cf/bootswatch/bootstrap/js/html5shiv.js"></script>
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
        	<!--- replacement header (MYY) --->
            <div id="header" class="row-fluid">
                <img width="100%" src="/wp-content/uploads/2013/08/mqc_logo.png" alt="MyMedicareMatters" title="MyMedicareMatters">
            	<div style="margin-top:-30px;" class="span12"><a target="_blank" href="http://www.ncoa.org"><img src="/wp-content/themes/bcuwptheme/images/logos/ncoa_top.png" title="National Council on Aging" alt="National Council on Aging" id="topbar"></a></div>
         	</div>
            <!--- previous header (PE) --->
			<!---div id="header" class="row-fluid">
            	<div class="span12"><a href="http://www.ncoa.org" target="_blank"><img id="topbar" alt="National Council on Aging" title="National Council on Aging" src="/wp-content/themes/bcuwptheme/images/logos/ncoa_top.png"></a><BR></div>
         	</div>
            <div id="header" class="row-fluid">
                <div class="span5">
                	<h3>Logo Here</h3><br><BR>
              	</div>
               	<div class="span6 offset1 statistics" id="logo">Heading Text. Placeholder for now.<br />
                </div>
            </div--->
			<!--- end header --->
            <div id="main-nav" class="navbar row-fluid">
                <ul id="home-nav" class="row-fluid">
                    <li id="esi-home" class="span2"><a class="current_tab" href="/cf/mockup_esi_home.cfm">Home</a></li>
                    <li class="span2"><a href="#">Get&nbsp;Started</a></li>
                    <li class="span2"><a href="/cf/frmwelcome2.cfm?subset_id=0&amp;partner_id=77">QuickCheck</a></li>				
                    <li id="esi-about" class="span2"><a href="/cf/mockup_esi_about.cfm">About Us</a></li>
                    <li id="esi-news" class="span2"><a href="#">News</a></li>
                    <li id="esi-donate" class="span2"><a href="#">Donate</a></li>
                </ul>	
            </div>
            <div class="content row-fluid">
            	<div class="row-fluid" id="outercontainer">