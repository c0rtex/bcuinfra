<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>MedicareQuickCheck</title>
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
		<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
		<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto+Condensed">
		<link href="/cf/bootswatch/bootstrap/css/mqc_style1.css" rel="stylesheet">
       	<link href="/cf/bootswatch/bootstrap/css/bootstrap_mqc.css" rel="stylesheet">
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
        	<img src="/cf/img/MQC_header2.png">
            <div class="content row-fluid">
            	<div class="row-fluid" id="outercontainer">