<!doctype html>

<!--[if lt IE 7]><html <?php language_attributes(); ?> class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html <?php language_attributes(); ?> class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html <?php language_attributes(); ?> class="no-js lt-ie9"><![endif]-->
<!--[if gt IE 8]><!--> <html <?php language_attributes(); ?> class="no-js"><!--<![endif]-->

	<head>
		<meta charset="utf-8">

		<title><?php wp_title(''); ?></title>
		
		<meta name="language" content="en-US" />
		<meta name="lang" content="en" />

		<!-- Google Chrome Frame for IE -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

		<!-- mobile meta -->
		<meta name="HandheldFriendly" content="True">
		<meta name="MobileOptimized" content="320">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

		<!-- icons & favicons -->
		<link rel="apple-touch-icon" href="<?php echo get_template_directory_uri(); ?>/library/images/apple-icon-touch.png">
		<link rel="icon" href="<?php echo get_template_directory_uri(); ?>/favicon.png">
		<!--[if IE]>
			<link rel="shortcut icon" href="<?php echo get_template_directory_uri(); ?>/favicon.ico">
		<![endif]-->
		


  	<link rel="pingback" href="<?php bloginfo('pingback_url'); ?>">
  	
  	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  	   <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  	   <!--[if lt IE 9]>
  	     <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  	     <script src="//oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
  	<![endif]-->
  	
		<?php wp_head(); ?>
		
		<?php //add most of this to enqueue during clean-up ?>
		        
  			<!-- Need to upgrade WordPress so it gets a newer version of jQuery to work with Bootstrap -->
  			<script src="/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/jquery.validate.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/bootstrap.js"></script>
            <script type="text/javascript" src="/wp-content/themes/bootswatch/bootstrap/js/scrolltofixed.js"></script>
            <!-- move into mqc.js? only if it's used in the mqc files and not the ecu files -->
            <script src="<?php echo get_template_directory_uri(); ?>/application.js"></script>

		
		<link rel="stylesheet" href="/wp-content/themes/bootswatch/bootstrap/css/font-awesome.css">
		<link type="text/css" rel="stylesheet" href="//fonts.googleapis.com/css?family=Roboto">
		<link type="text/css" rel="stylesheet" href="//fonts.googleapis.com/css?family=Roboto+Condensed">		
		<link href='//fonts.googleapis.com/css?family=Roboto:400,500,900' rel='stylesheet' type='text/css'>
		
	</head>

	<body <?php body_class(); ?> data-spy="scroll" data-target=".sidebar-nav">

	<div class="container">
			
